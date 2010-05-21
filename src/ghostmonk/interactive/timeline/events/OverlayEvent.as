package ghostmonk.interactive.timeline.events
{
	import flash.events.Event;
	
	public class OverlayEvent extends Event
	{
		public static const CLOSE:String = "overlayClose";
		
		public function OverlayEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		override public function clone() : Event
		{
			return new OverlayEvent( type, bubbles, cancelable );
		}
	}
}