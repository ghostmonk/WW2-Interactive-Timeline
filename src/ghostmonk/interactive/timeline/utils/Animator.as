package ghostmonk.interactive.timeline.utils
{
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.FilterShortcuts;
	import caurina.transitions.properties.TextShortcuts;
	
	import com.ghostmonk.utils.ObjectFuncs;
	
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class Animator
	{
		private static var _position:Point;
		private static var _delay:Number;
		private static var _transition:String;
		private static var _callback:Function;
		private static var _params:Array;
		
		public static function init() : void
		{
			TextShortcuts.init();
			FilterShortcuts.init();
		}
		
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
		
		public static function setCallback( callback:Function, params:Array = null ) : void
		{
			_callback = callback;
			_params = params;
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
		
		public static function textTween( field:TextField, text:String, time:Number = 0.3, reset:Boolean = true ) : void
		{
			start( field, { _text:text, time:time, transition:Equations.easeNone }, reset );
		}
		
		public static function filterTween( item:DisplayObject, filter:BitmapFilter, time:Number = 0.3, reset:Boolean = true ) : void
		{
			start( item, { _filter:filter, time:time }, reset );
		}
		
		public static function destroyTweens( item:DisplayObject ) : void
		{
			Tweener.removeTweens( item );
		}
		
		private static function start( item:DisplayObject, animObj:Object, reset:Boolean ) : void
		{
			if( _transition )  animObj.transition = _transition;
			animObj.delay = _delay;
			animObj.onComplete = _callback;
			animObj.onCompleteParams = _params;
			Tweener.addTween( item, animObj );
			_callback = null;
			_params = null;
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