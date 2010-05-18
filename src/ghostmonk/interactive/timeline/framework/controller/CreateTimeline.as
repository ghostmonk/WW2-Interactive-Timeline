package ghostmonk.interactive.timeline.framework.controller 
{	
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.timeline.CategoryHeader;
	import ghostmonk.interactive.timeline.components.timeline.Timeline;
	import ghostmonk.interactive.timeline.components.timeline.TimelineDivider;
	import ghostmonk.interactive.timeline.framework.model.ConfigProxy;
	import ghostmonk.interactive.timeline.framework.view.StageMediator;
	import ghostmonk.interactive.timeline.framework.view.TimelineMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class CreateTimeline extends SimpleCommand 
	{	
		override public function execute( note:INotification ) : void 
		{	
			var config:ConfigProxy = note.getBody() as ConfigProxy;
			var stageMediator:StageMediator = facade.retrieveMediator( StageMediator.NAME ) as StageMediator;
			
			var eventTimeline:Timeline = getTimeline();
			var soldierTimeline:Timeline = getTimeline();
			facade.registerMediator( new TimelineMediator( soldierTimeline, eventTimeline, config.categories, stageMediator.stage ) );	
		}
		
		private function getTimeline() : Timeline
		{
			var output:Timeline = new Timeline();
			output.header = new CategoryHeader();
			output.divider = new TimelineDivider();
			return output;
		}
	}
}