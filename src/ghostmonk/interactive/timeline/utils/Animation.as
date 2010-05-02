package ghostmonk.interactive.timeline.utils
{
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import flash.display.DisplayObject;
	
	public class Animation
	{
		public static const TITLE_ANIMATE_IN:Object = { time:0.3, delay:0.3 };
		public static const ALPHA_IN:Object = { alpha:1, time:0.3, transition:Equations.easeNone };
		public static const SCALE_IN:Object = { time:0.3, scaleX:1, scaleY:1 };
		public static const ALL_IN:Object = { time:0.3, scaleX:1, scaleY:1, alpha:1, rotation:0 };
		
		public static function tween( item:DisplayObject, value:Object ) : void
		{
			Tweener.addTween( item, value );
		}
	}
}