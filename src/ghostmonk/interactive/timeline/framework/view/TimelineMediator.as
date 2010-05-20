package ghostmonk.interactive.timeline.framework.view
{
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.timeline.Timeline;
	import ghostmonk.interactive.timeline.data.EventDateData;
	import ghostmonk.interactive.timeline.framework.model.TimelineDataProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class TimelineMediator extends Mediator
	{
		public static const NAME:String = "TimelineMediator";
		private static const PADDING:int = 60;
		
		private var _soldierTimeline:Timeline;
		private var _eventTimeline:Timeline;
		private var _data:TimelineDataProxy;
		private var _stage:Stage;
		
		public function TimelineMediator( soldierTimeline:Timeline, eventTimeline:Timeline, categories:Array, stage:Stage )
		{
			super( NAME );
			_soldierTimeline = soldierTimeline;
			_eventTimeline = eventTimeline;
			_stage = stage;
			setup( categories );
		}
		
		override public function listNotificationInterests() : Array 
		{
			return [ 
				TimelineDataProxy.TIMELINE_DATA_READY,
				FilterMediator.MONTH_NAV,
				FilterMediator.YEAR_NAV 
			];
		}
		
		override public function handleNotification( note:INotification ) : void
		{
			switch( note.getName() )
			{
				case TimelineDataProxy.TIMELINE_DATA_READY :
					onTimelineDataReady( note.getBody() as TimelineDataProxy );
					break;
				
				case FilterMediator.MONTH_NAV:
					onMonthNav( note.getBody() as int );
					break;
					
				case FilterMediator.YEAR_NAV:
					onYearNav( note.getBody() as int );
					break;
			}
		}
		
		private function onTimelineDataReady( proxy:TimelineDataProxy ) : void
		{
			_data = proxy;
			for each( var event:EventDateData in _data.eventCollection )
			{
				_eventTimeline.createDateIcon( event );
			}
		}
		
		private function onMonthNav( node:int ) : void
		{
		}
		
		private function onYearNav( node:int ) : void
		{
		}
		
		private function setup( categories:Array ) : void
		{
			var eventTitle:Array = String( categories[ 0 ] ).split( " " );
			_eventTimeline.header.field1.text = eventTitle[ 0 ];
			_eventTimeline.header.field2.text = eventTitle[ 1 ];
			
			_soldierTimeline.header.image.gotoAndStop( 2 );
			_soldierTimeline.header.field1.text = categories[ 1 ];
			
			normalView();
		}
		
		private function normalView() : void
		{
			var timelineHeight:Number = _eventTimeline.height;
			_eventTimeline.y = ( _stage.stageHeight - ( 2 * timelineHeight + PADDING ) ) * 0.5;
			_soldierTimeline.y = _eventTimeline.y + timelineHeight + PADDING;
			_stage.addChild( _soldierTimeline );
			_stage.addChild( _eventTimeline );
		}
	}
}