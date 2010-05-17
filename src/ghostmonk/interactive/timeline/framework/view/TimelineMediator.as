package ghostmonk.interactive.timeline.framework.view
{
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.timeline.Timeline;
	import ghostmonk.interactive.timeline.framework.model.ConfigProxy;
	
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class TimelineMediator extends Mediator
	{
		public static const NAME:String = "TimelineMediator";
		private static const PADDING:int = 30;
		
		private var _soldierTimeline:Timeline;
		private var _eventTimeline:Timeline;
		private var _config:ConfigProxy;
		private var _stage:Stage;
		
		public function TimelineMediator( soldierTimeline:Timeline, eventTimeline:Timeline, config:ConfigProxy, stage:Stage )
		{
			super( NAME );
			_soldierTimeline = soldierTimeline;
			_eventTimeline = eventTimeline;
			_config = config;
			_stage = stage;
			setup();
		}
		
		private function setup() : void
		{
			var eventTitle:Array = String( _config.categories[ 0 ] ).split( " " );
			_eventTimeline.header.field1.text = eventTitle[ 0 ];
			_eventTimeline.header.field2.text = eventTitle[ 1 ];
			
			_soldierTimeline.header.image.gotoAndStop( 2 );
			_soldierTimeline.header.field1.text = _config.categories[ 1 ];
			
			normalView();
		}
		
		private function normalView() : void
		{
			var timelineHeight:Number = _eventTimeline.height;
			_eventTimeline.y = ( _stage.stageHeight - ( 2 * timelineHeight + PADDING ) ) * 0.5 + timelineHeight * 0.5;
			_soldierTimeline.y = _eventTimeline.y + timelineHeight + PADDING;
			_stage.addChild( _soldierTimeline );
			_stage.addChild( _eventTimeline );
		}
	}
}