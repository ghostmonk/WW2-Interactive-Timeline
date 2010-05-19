package ghostmonk.interactive.timeline.utils
{
	import caurina.transitions.Equations;
	
	public class Tween
	{
		public static const BUILD_IN_DELAY:Number = 0.3;
		public static const BASE_TIME:Number = 0.3;
		public static const BACKGROUND_BUILD_IN:Object = { alpha:1, time:0.3, delay:BUILD_IN_DELAY, transition:Equations.easeNone };
		public static const SCALE_Y_OUT:Object = { time:0.3, scaleY:0 };
		public static const ALPHA_IN:Object = { alpha:1, time:0.3, transition:Equations.easeNone };
		public static const ALPHA_OUT:Object = { alpha:0, time:0.3, transition:Equations.easeNone };
		public static const SCALE_IN:Object = { time:0.3, scaleX:1, scaleY:1 };
		public static const ALL_IN:Object = { time:0.3, scaleX:1, scaleY:1, alpha:1, rotation:0 };
	}
}