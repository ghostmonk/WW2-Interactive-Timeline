package ghostmonk.interactive.timeline.events
{
	import flash.events.Event;

	public class NavigationEvent extends Event
	{
		public static const YEAR_SELECTION:String = "yearSelection";
		public static const MONTH_SELECTION:String = "monthSelection";
		
		private var _index:int;
		
		public function NavigationEvent( type:String, index:int, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			_index = index;
			super( type, bubbles, cancelable );
		}
		
		public function get index() : int
		{
			return _index;
		}
		
		override public function clone() : Event
		{
			return new NavigationEvent( type, index, bubbles, cancelable );
		}
	}
}