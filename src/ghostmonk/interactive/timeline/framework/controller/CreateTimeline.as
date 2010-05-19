package ghostmonk.interactive.timeline.framework.controller 
{	
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.timeline.CategoryHeader;
	import ghostmonk.interactive.timeline.components.timeline.PositionCalculator;
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
		private var _positionCalculator:PositionCalculator;
		
		override public function execute( note:INotification ) : void 
		{	
			var config:ConfigProxy = note.getBody() as ConfigProxy;
			var stage:Stage = StageMediator( facade.retrieveMediator( StageMediator.NAME ) ).stage; 
			createPositionCalculator( config.years );
			
			facade.registerMediator( 
				new TimelineMediator( 
					getTimeline(), 
					getTimeline(), 
					config.categories, 
					stage 
				)
			);	
		}
		
		private function createPositionCalculator( years:Array ) : void
		{
			_positionCalculator = new PositionCalculator();
			var minDate:int = int( years[ 1 ] );
			var maxDate:int = int( years[ years.length - 1 ] );
			_positionCalculator.setDateRange( minDate, maxDate );
		}
		
		private function getTimeline() : Timeline
		{
			var graph:TimelineDivider = new TimelineDivider(); 
			var output:Timeline = new Timeline();
			output.header = new CategoryHeader();
			output.divider = graph;
			_positionCalculator.graphWidth = graph.baseWidth; 
			output.positionCalculator = _positionCalculator;
			return output;
		}
	}
}