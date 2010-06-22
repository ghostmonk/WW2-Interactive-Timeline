package ghostmonk.interactive.timeline.framework.view
{
	import flash.display.Stage;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import ghostmonk.interactive.timeline.components.timeline.Timeline;
	import ghostmonk.interactive.timeline.components.ui.Icon;
	import ghostmonk.interactive.timeline.events.TimelineEvent;
	import ghostmonk.interactive.timeline.framework.model.TimelineDataProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class TimelineMediator extends Mediator
	{
		public static const NAME:String = "TimelineMediator";
		private static const PADDING:int = 55;
		
		private var _stage:Stage;
		private var _initDelayInterval:uint;
		private var _data:TimelineDataProxy;
		private var _veteranTimeline:Timeline;
		private var _warEventTimeline:Timeline;
		
		public function TimelineMediator( soldierTimeline:Timeline, eventTimeline:Timeline, categories:Array, stage:Stage )
		{
			super( NAME );
			_veteranTimeline = soldierTimeline;
			_veteranTimeline.addEventListener( TimelineEvent.ICON_CLICK, onVetranIconClick );
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
			_veteranTimeline.createVeteranEventIcons( _data.veteranEventCollection );
			showAll();
		}
		
		private function onVetranIconClick( e:TimelineEvent ) : void
		{
			sendNotification( Icon.VET, e.id );
		}
		
		private function onWarEventIconClick( e:TimelineEvent ) : void
		{
			sendNotification( Icon.WAR_EVENT, e.id );
		}
		
		private function showAll() : void
		{
			_warEventTimeline.showAll();
			_veteranTimeline.showAll();
		}
		
		private function onYearNav( year:int ) : void
		{
			_warEventTimeline.removeAll();
			for each( var id:String in _data.warEventCollection.getIDsByYear( year ) )
				_warEventTimeline.showIcon( id, false );
			
			_veteranTimeline.removeAll();
			for each( var vetID:String in _data.veteranEventCollection.getIDsByYear( year ) )
				_veteranTimeline.showIcon( vetID, false );
			
		}
		
		private function setup( categories:Array ) : void
		{
			var eventTitle:Array = String( categories[ 0 ] ).split( " " );
			_warEventTimeline.header.field1.text = eventTitle[ 0 ];
			_warEventTimeline.header.field2.text = eventTitle[ 1 ];
			
			_veteranTimeline.header.image.gotoAndStop( 2 );
			_veteranTimeline.header.field1.text = categories[ 1 ];
			
			normalView();
		}
		
		private function normalView() : void
		{
			var timelineHeight:Number = _warEventTimeline.height;
			_warEventTimeline.y = ( _stage.stageHeight - ( 2 * timelineHeight + PADDING ) ) * 0.5 + 60;
			_veteranTimeline.y = _warEventTimeline.y + timelineHeight + PADDING;
			_stage.addChild( _veteranTimeline );
			_stage.addChild( _warEventTimeline );
		}
	}
}