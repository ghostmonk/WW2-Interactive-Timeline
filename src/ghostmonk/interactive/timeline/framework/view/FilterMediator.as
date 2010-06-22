
package ghostmonk.interactive.timeline.framework.view
{
	import com.ghostmonk.events.IDEvent;
	import com.ghostmonk.utils.TimedCallback;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.filters.DropShadowFilter;
	
	import ghostmonk.interactive.timeline.AppFacade;
	import ghostmonk.interactive.timeline.components.timeline.TimelineFilter;
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;
	
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class FilterMediator extends Mediator
	{
		public static const NAME:String = "TimelineMediator";
		private static const DROP:DropShadowFilter = new DropShadowFilter(0,0,0,0.5,10,10);
		
		public static const FILTER_YEAR:String = "filterYear";
		public static const FILTER_ALL:String = "filterAll";
		
		private var _holder:Sprite;
		private var _monthBar:TimelineFilter;
		private var _yearFilter:TimelineFilter;
		private var _stage:Stage;
		private var _years:Array;
		
		public function FilterMediator( monthBar:TimelineFilter, yearNav:TimelineFilter, stage:Stage )
		{
			_holder = new Sprite();
			super( NAME, _holder );
			
			_yearFilter = yearNav;
			_monthBar = monthBar;
			_monthBar.filters = [ DROP ];
			_yearFilter.filters = [ DROP ]
			_monthBar.alpha = 0;
			_yearFilter.addEventListener( IDEvent.UPDATE, onFilterClick );
			
			_stage = stage;
			positionAssets();
			_yearFilter.enable();
			_yearFilter.activateButton( 0 );
		}
		
		public function set years( value:Array ) : void
		{
			_years = value;
			TimedCallback.create( sendNotification, 300, FILTER_ALL, _years );
		}
		
		public function get view() : Sprite
		{
			return _holder;
		}
		
		private function onFilterClick( e:IDEvent ) : void
		{
			_yearFilter.selectItem( e.id );
			if( e.id == 0 ) 
			{
				sendNotification( FILTER_ALL, _years );
				Animator.tween( _monthBar, Tween.ALPHA_OUT );
			}
			else 
			{
				sendNotification( FILTER_YEAR, int( _years[ e.id ] ) );
				Animator.tween( _monthBar, Tween.ALPHA_IN );
			}
		}
		
		private function positionAssets() : void
		{
			_monthBar.y = _yearFilter.height + 5;
			var offset:Number = AppFacade.LANGUAGE == "eng" ? 45 : 70;  
			_monthBar.x = ( _yearFilter.width - _monthBar.width ) * 0.5 + offset;
			_monthBar.disable();
			
			_holder.addChild( _monthBar );
			_holder.addChild( _yearFilter );
			
			var holderOff:Number = AppFacade.LANGUAGE == "eng" ? 20 : 30;  
			_holder.x = _stage.stageWidth - _holder.width - holderOff;
			_holder.y = 110;
			
			_stage.addChild( _holder );
		}
	}
}