package ghostmonk.interactive.timeline.events
{
	import flash.events.Event;

	public class TimelineEvent extends Event
	{
		public static const ICON_CLICK:String = "timelineIconClick";
		
		private var _id:String;
		
		public function TimelineEvent( type:String, id:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			_id = id;
			super( type, bubbles, cancelable );
		}
		
		public function get id() : String
		{
			return _id;
		}
		
		override public function clone() : Event
		{
			return new TimelineEvent( type, id, bubbles, cancelable );
		}
		
	}
}