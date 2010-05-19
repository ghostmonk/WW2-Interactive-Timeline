package ghostmonk.interactive.timeline.components.ui
{
	import assets.category.IconAsset;
	
	import com.ghostmonk.ui.interactive.buttons.InteractiveSprite;
	
	import flash.events.MouseEvent;
	
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

	public class Icon extends IconAsset
	{
		public static const VET:String = "vet";
		public static const EVENT:String = "event";
		
		private var _interactive:InteractiveSprite;
		
		public function Icon( type:String )
		{
			_interactive = new InteractiveSprite( this );
			_interactive.rollOverFunc = onRollover;
			_interactive.rollOutFunc = onRollout;
			_interactive.mouseClickFunc = onClick;
			var frame:int = type == VET ? 2 : 1;
			icon.gotoAndStop( frame );
			bg.alpha = 0;
		}
		
		private function onRollover( e:MouseEvent ) : void
		{
			Animator.tween( bg, { alpha:0.6, time:Tween.BASE_TIME } );
		}
		
		private function onRollout( e:MouseEvent ) : void
		{
			Animator.tween( bg, Tween.ALPHA_OUT );
		}
		
		private function onClick( e:MouseEvent ) : void
		{
			trace( "click" );
		}
	}
}