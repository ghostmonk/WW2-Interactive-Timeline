package ghostmonk.interactive.timeline.components.ui
{
	import assets.category.IconAsset;
	
	import com.ghostmonk.ui.interactive.buttons.InteractiveSprite;
	
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import ghostmonk.interactive.timeline.events.TimelineEvent;
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

	public class Icon extends InteractiveSprite
	{
		public static const VET:String = "vet";
		public static const WAR_EVENT:String = "event";
		
		private var _view:IconAsset;
		private var _label:IconLabel;
		private var _uid:String;
		private var _labelText:String;
		private var _date:Date;
		private var _clickCallback:Function;
		
		public function Icon( view:IconAsset, type:String )
		{
			super( view );	
			view.icon.stop();
			
			var frame:int = type == VET ? 2 : 1;
			
			_view = view;
			_view.icon.gotoAndStop( frame );
			_view.bg.alpha = 0;
			_view.alpha = 0;
			
			_label = new IconLabel( view );
		}
		
		public function set clickCallback( value:Function ) : void
		{
			_clickCallback = value;
		}
		
		public function set date( value:Date ) : void
		{
			_date = value;
		}
		
		public function get date() : Date
		{
			return _date;
		}
		
		public function set uid( value:String ) : void
		{
			_uid = value;
		}
		
		public function get uid() : String
		{
			return _uid;
		}
		
		public function set labelDirection( value:int ) : void
		{
			_label.direction = value;
		}
		
		public function set labelText( value:String ) : void
		{
			_label.text = value;
		}
		
		public function buildIn() : void
		{
			_view.alpha = 0;
			Animator.destroyTweens( _view );
			Animator.delay = Math.random();
			Animator.tween( _view, Tween.ALPHA_IN, false );
		}
		
		public function buildOut() : void
		{
			Animator.destroyTweens( _view );
			Animator.setCallback( _view.parent.removeChild, [ _view ] );
			Animator.tween( _view, Tween.ALPHA_OUT );
		}
		
		override protected function onRollover( e:MouseEvent = null ) : void
		{
			_view.bg.alpha = 0.6;
			_view.icon.transform.colorTransform = new ColorTransform(1,1,1,1,255,255,255,0);
			_label.buildIn();
			view.parent.addChild( view );
			//Animator.tween( _view.bg, { alpha:0.6, time:Tween.BASE_TIME } );
		}
		
		override protected function onRollout( e:MouseEvent = null ) : void
		{
			_view.bg.alpha = 0;
			_view.icon.transform.colorTransform = new ColorTransform();
			_label.buildOut();
			//Animator.tween( _view.bg, Tween.ALPHA_OUT);
		}
		
		override protected function onClick( e:MouseEvent = null ) : void
		{
			_clickCallback( _uid );
		}
	}
}