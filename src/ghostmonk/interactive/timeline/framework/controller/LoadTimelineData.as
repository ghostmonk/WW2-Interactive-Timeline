package ghostmonk.interactive.timeline.framework.controller
{
	import com.ghostmonk.net.XMLLoader;
	
	import ghostmonk.interactive.timeline.data.TimelineData;
	import ghostmonk.interactive.timeline.framework.model.TimelineDataProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class LoadTimelineData extends SimpleCommand
	{
		override public function execute( note:INotification ) : void
		{
			var loader:XMLLoader = new XMLLoader( note.getBody() as String, onComplete );
		}
		
		private function onComplete( data:XML ) : void
		{
			var timelineProxy:TimelineDataProxy = new TimelineDataProxy( new TimelineData( data ) );
			facade.registerProxy( timelineProxy );
			sendNotification( TimelineDataProxy.TIMELINE_DATA_READY, timelineProxy );
		}
	}
}