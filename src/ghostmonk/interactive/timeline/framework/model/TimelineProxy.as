package ghostmonk.interactive.timeline.framework.model
{
	import ghostmonk.interactive.timeline.data.TimelineData;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class TimelineProxy extends Proxy
	{
		public static const NAME:String = "TimelineProxy";
		private var _timelineData:TimelineData;
		
		public function TimelineProxy( data:TimelineData )
		{
			_timelineData = data;
			super( NAME, _timelineData );
		}
		
		public function get thumbLink() : String
		{
			return _timelineData.thumbLink;
		}
		
		public function get vetProfileLink() : String
		{
			return _timelineData.vetProfileLink;
		}
		
		public function get eventCollection() : Array
		{
			return _timelineData.eventCollection;
		}
		
		public function getVetranName( id:String ) : String
		{
			return getVetranName( id );
		}
	}
}