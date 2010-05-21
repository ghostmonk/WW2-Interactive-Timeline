package ghostmonk.interactive.timeline.framework.view
{
	import flash.display.Stage;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import ghostmonk.interactive.timeline.components.timeline.Timeline;
	import ghostmonk.interactive.timeline.events.TimelineEvent;
	import ghostmonk.interactive.timeline.framework.model.TimelineDataProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class TimelineMediator extends Mediator
	{
		public static const NAME:String = "TimelineMediator";
		private static const PADDING:int = 60;
		
		private var _vetranTimeline:Timeline;
		private var _warEventTimeline:Timeline;
		private var _data:TimelineDataProxy;
		private var _stage:Stage;
		private var _initDelayInterval:uint;
		
		public function TimelineMediator( soldierTimeline:Timeline, eventTimeline:Timeline, categories:Array, stage:Stage )
		{
			super( NAME );
			_vetranTimeline = soldierTimeline;
			_vetranTimeline.addEventListener( TimelineEvent.ICON_CLICK, onVetranIconClick );
			_warEventTimeline = eventTimeline;
			_warEventTimeline.addEventListener( TimelineEvent.ICON_CLICK, onWarEventIconClick );
			_stage = stage;
			setup( categories );
		}
		
		override public function listNotificationInterests() : Array 
		{
			return [ 
				TimelineDataProxy.TIMELINE_DATA_READY,
				FilterMediator.FILTER_ALL,
				FilterMediator.FILTER_YEAR
			];
		}
		
		override public function handleNotification( note:INotification ) : void
		{
			switch( note.getName() )
			{
				case TimelineDataProxy.TIMELINE_DATA_READY :
					_data = note.getBody() as TimelineDataProxy ;
					_initDelayInterval = setInterval( onTimelineDataReady, 500 );
					break;
				
				case FilterMediator.FILTER_ALL:
					showAll();
					break;
					
				case FilterMediator.FILTER_YEAR:
					onYearNav( note.getBody() as int );
					break;
			}
		}
		
		private function onTimelineDataReady() : void
		{
			clearInterval( _initDelayInterval );
			_warEventTimeline.createWarEventIcons( _data.warEventCollection );
			_vetranTimeline.createVetranIcons( _data.vetranCollection );
			showAll();
		}
		
		private function onVetranIconClick( e:TimelineEvent ) : void
		{
			
		}
		
		private function onWarEventIconClick( e:TimelineEvent ) : void
		{
			sendNotification( e.type, e.id );
		}
		
		private function showAll() : void
		{
			_warEventTimeline.showAll();
			_vetranTimeline.showAll();
		}
		
		private function onYearNav( year:int ) : void
		{
			_warEventTimeline.removeAll();
			for each( var id:String in _data.warEventCollection.getIDsByYear( year ) )
				_warEventTimeline.showIcon( id, false );
			
			_vetranTimeline.removeAll();
			for each( var vetId:String in _data.vetranCollection.getIDsByYear( year ) )
				_vetranTimeline.showIcon( vetId, false );
		}
		
		private function setup( categories:Array ) : void
		{
			var eventTitle:Array = String( categories[ 0 ] ).split( " " );
			_warEventTimeline.header.field1.text = eventTitle[ 0 ];
			_warEventTimeline.header.field2.text = eventTitle[ 1 ];
			
			_vetranTimeline.header.image.gotoAndStop( 2 );
			_vetranTimeline.header.field1.text = categories[ 1 ];
			
			normalView();
		}
		
		private function normalView() : void
		{
			var timelineHeight:Number = _warEventTimeline.height;
			_warEventTimeline.y = ( _stage.stageHeight - ( 2 * timelineHeight + PADDING ) ) * 0.5;
			_vetranTimeline.y = _warEventTimeline.y + timelineHeight + PADDING;
			_stage.addChild( _vetranTimeline );
			_stage.addChild( _warEventTimeline );
		}
	}
}