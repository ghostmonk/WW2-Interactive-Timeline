package ghostmonk.interactive.timeline.utils
{
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.utils.ObjectFuncs;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public class Animation
	{
		public static const BACKGROUND_BUILD_IN:Object = { alpha:1, time:0.3, delay:0.3, transition:Equations.easeNone };
		public static const ALPHA_IN:Object = { alpha:1, time:0.3, transition:Equations.easeNone };
		public static const SCALE_IN:Object = { time:0.3, scaleX:1, scaleY:1 };
		public static const ALL_IN:Object = { time:0.3, scaleX:1, scaleY:1, alpha:1, rotation:0 };
		
		private static var _position:Point;
		private static var _delay:Number;
		private static var _transition:String;
		
		public static function set position( value:Point ) : void
		{
			_position = value;
		} 
		
		public static function set transition( value:String ) : void
		{
			_transition = value;
		} 
		
		public static function set delay( value:Number ) : void
		{
			_delay = value;
		} 
		
		public static function tween( item:DisplayObject, tweenValues:Object, reset:Boolean = true ) : void
		{
			var animObj:Object = ObjectFuncs.clone( tweenValues );
			if( _position ) 
			{
				animObj.x = _position.x;
				animObj.y = _position.y;
			}
			
			start( item, animObj, reset );
		}
		
		public static function offsetTween( item:DisplayObject, x:Number, y:Number, time:Number = 0.3, reset:Boolean = true ) : void
		{
			var animObj:Object = { x:item.x, y:item.y, time:time };
			item.x += x;
			item.y += y;
			start( item, animObj, reset );
		}
		
		private static function start( item:DisplayObject, animObj:Object, reset:Boolean ) : void
		{
			if( _transition )  animObj.transition = _transition;
			animObj.delay = _delay;
			Tweener.addTween( item, animObj );
			if( reset ) resetConfig();
		}
		
		private static function resetConfig() : void
		{
			_position = null;
			_delay = 0;
			_transition = null;
		}
	}
}