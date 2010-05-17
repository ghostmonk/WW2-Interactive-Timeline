package ghostmonk.interactive.timeline.framework.controller
{
	import com.ghostmonk.net.XMLLoader;
	
	import ghostmonk.interactive.timeline.data.TimelineData;
	import ghostmonk.interactive.timeline.framework.model.TimelineProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class CreateTimelineCmd extends SimpleCommand
	{
		public static const TIMELINE_DATA_READY:String = "timelineDataReady";
		
		override public function execute( note:INotification ) : void
		{
			var loader:XMLLoader = new XMLLoader( note.getBody() as String, onComplete );
		}
		
		private function onComplete( data:XML ) : void
		{
			var timelineProxy:TimelineProxy = new TimelineProxy( new TimelineData( data ) );
			facade.registerProxy( timelineProxy );
			sendNotification( TIMELINE_DATA_READY, timelineProxy );
		}
	}
}