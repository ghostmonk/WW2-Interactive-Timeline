package ghostmonk.interactive.timeline.components.ui
{
	import assets.category.IconAsset;
	
	import com.ghostmonk.ui.interactive.buttons.InteractiveSprite;
	
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;

	public class Icon extends IconAsset
	{
		public static const VET:String = "vet";
		public static const EVENT:String = "event";
		
		private var _interactive:InteractiveSprite;
		private var _labelDirection:int;
		
		public function Icon( type:String, labelDirection:int = 1 )
		{
			_interactive = new InteractiveSprite( this );
			_interactive.rollOverFunc = onRollover;
			_interactive.rollOutFunc = onRollout;
			_interactive.mouseClickFunc = onClick;
			var frame:int = type == VET ? 2 : 1;
			icon.gotoAndStop( frame );
			bg.alpha = 0;
			_labelDirection = labelDirection;
		}
		
		private function get labelDirection() : int
		{
			return _labelDirection;
		}
		
		private function onRollover( e:MouseEvent ) : void
		{
			bg.alpha = 0.6;
			icon.transform.colorTransform = new ColorTransform(1,1,1,1,255,255,255,0);
			//Animator.tween( bg, { alpha:0.6, time:Tween.BASE_TIME } );
		}
		
		private function onRollout( e:MouseEvent ) : void
		{
			bg.alpha = 0;
			icon.transform.colorTransform = new ColorTransform();
			//Animator.tween( bg, Tween.ALPHA_OUT);
		}
		
		private function onClick( e:MouseEvent ) : void
		{
			trace( _labelDirection );
		}
	}
}