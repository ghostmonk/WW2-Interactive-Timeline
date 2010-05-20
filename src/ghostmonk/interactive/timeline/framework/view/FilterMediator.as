
package ghostmonk.interactive.timeline.framework.view
{
	import com.ghostmonk.events.IDEvent;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.timeline.TimelineFilter;
	
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class FilterMediator extends Mediator
	{
		public static const NAME:String = "TimelineMediator";
		
		public static const MONTH_NAV:String = "monthNavigation";
		public static const YEAR_NAV:String = "yearNavigation";
		
		private var _holder:Sprite;
		private var _monthNav:TimelineFilter;
		private var _yearNav:TimelineFilter;
		private var _stage:Stage;
		
		public function FilterMediator( monthNav:TimelineFilter, yearNav:TimelineFilter, stage:Stage )
		{
			_holder = new Sprite();
			super( NAME, _holder );
			
			_monthNav = monthNav;
			_monthNav.addEventListener( IDEvent.UPDATE, onMonthClick );
			
			_yearNav = yearNav;
			_yearNav.addEventListener( IDEvent.UPDATE, onYearClick );
			
			_stage = stage;
			positionAssets();
			_yearNav.enable();
			_yearNav.activateButton( 0 );
		}
		
		public function get view() : Sprite
		{
			return _holder;
		}
		
		private function onMonthClick( e:IDEvent ) : void
		{
			sendNotification( MONTH_NAV, e.id );
			_monthNav.selectItem( e.id );
		}
		
		private function onYearClick( e:IDEvent ) : void
		{
			sendNotification( YEAR_NAV, e.id );
			_yearNav.selectItem( e.id );
		}
		
		private function positionAssets() : void
		{
			_yearNav.y = _monthNav.height + 5;
			_monthNav.x = ( _yearNav.width - _monthNav.width ) * 0.5 + 45;
			_monthNav.disable();
			
			_holder.addChild( _monthNav );
			_holder.addChild( _yearNav );
			
			_holder.x = _stage.stageWidth - _holder.width - 50;
			_holder.y = _stage.stageHeight - _holder.height - 10;
			
			_stage.addChild( _holder );
		}
	}
}