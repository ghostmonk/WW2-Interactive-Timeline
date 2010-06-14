package ghostmonk.interactive.timeline.framework.view
{
	import com.ghostmonk.display.graphics.shapes.SimpleRectangle;
	import com.ghostmonk.events.ArrayNavEvent;
	
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.ui.Icon;
	import ghostmonk.interactive.timeline.components.view.Overlay;
	import ghostmonk.interactive.timeline.data.collections.Vetran;
	import ghostmonk.interactive.timeline.data.collections.WarEventData;
	import ghostmonk.interactive.timeline.events.OverlayEvent;
	import ghostmonk.interactive.timeline.framework.model.TimelineDataProxy;
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class OverlayMediator extends Mediator
	{
		public static const NAME:String = "OverlayMediator";
		private var _stage:Stage;
		private var _data:TimelineDataProxy;
		private var _view:Overlay;
		private var _stageGuard:SimpleRectangle;
		//private var _incrementNav:ArrayNavigator;
		private var _targetVetran:Vetran;
		private var _currentYear:Number;
		
		public function OverlayMediator( viewComponent:Overlay, stage:Stage )
		{
			_stage = stage;
			
			_stageGuard = new SimpleRectangle( 0, _stage.stageWidth, _stage.stageWidth );
			
			_view = viewComponent;
			_view.addEventListener( OverlayEvent.CLOSE, onCloseOverlay );
			
			//_incrementNav = new ArrayNavigator( _view.next, _view.previous );
			//_incrementNav.addEventListener( ArrayNavEvent.CHANGE, onArrayNav );
			//_incrementNav.disable();
			
			super( NAME, viewComponent );
		}
		
		public function get view() : Overlay
		{
			return _view;
		}
		
		private function set data( value:TimelineDataProxy ) : void
		{
			_data = value;
			_view.vetLink = value.vetProfileLink;
			_view.imgLink = value.thumbLink;
		}
		
		override public function listNotificationInterests() : Array
		{
			return [ 
				Icon.WAR_EVENT,
				Icon.VET,
				TimelineDataProxy.TIMELINE_DATA_READY,
				FilterMediator.FILTER_YEAR,
				FilterMediator.FILTER_ALL
			];
		}
		
		override public function handleNotification( note:INotification ) : void
		{
			switch( note.getName() )
			{
				case Icon.WAR_EVENT:
					showOverlay( note.getBody() as String );
					break;
					
				case TimelineDataProxy.TIMELINE_DATA_READY:
					data = note.getBody() as TimelineDataProxy;
					break;
					
				case Icon.VET:
					showVetranOverlay( note.getBody() as String );
					break;
					
				case FilterMediator.FILTER_ALL:
					_currentYear = 0;
					break;
					
				case FilterMediator.FILTER_YEAR:
					_currentYear = note.getBody() as Number;
					break;
			}
		}
		
		private function showVetranOverlay( id:String ) : void
		{
			_targetVetran = _data.vetranCollection.getVetranByID( id );
			var warEventIDs:Array = _targetVetran.warEventIDs;
			var eventList:Array = _data.warEventCollection.getListByIDs( warEventIDs );
			
			var warEvent:WarEventData = _data.warEventCollection.getDataByID( warEventIDs[ Math.floor( Math.random() * warEventIDs.length ) ] );
			
			var testYear:Number = _currentYear > 0 ? _currentYear : _targetVetran.seedDate.fullYear;
			
			for each( var id:String in warEventIDs )
			{
				var eachEvent:WarEventData = _data.warEventCollection.getDataByID( id );
				if( eachEvent.date.fullYear == testYear ) 
				{
					warEvent = eachEvent;
					break;
				} 
			}
			
			setContent( warEvent, _targetVetran.name );
			show();
		}
		
		private function showOverlay( id:String ) : void
		{
			show();
			setContent( _data.warEventCollection.getDataByID( id ) );
		}
		
		private function show() : void
		{
			_stage.addChild( _stageGuard );
			_stageGuard.alpha = 0;
			Animator.transition = "easeNone";
			Animator.tween( _stageGuard, { alpha:0.5, time:Tween.BASE_TIME } );
			_stage.addChild( _view );
			_view.buildIn();
		}
		
		private function onCloseOverlay( e:OverlayEvent = null ) : void
		{
			//_incrementNav.disable();
			_stage.removeChild( _stageGuard );
			_view.buildOut();
		}
		
		private function onArrayNav( e:ArrayNavEvent ) : void
		{
			setContent( e.content as WarEventData, _targetVetran.name );
		}
		
		private function setContent( warData:WarEventData, vetName:String = null ) : void
		{
			_view.setContent( warData, _data.vetranCollection.getVetransByIDList( warData.vetIDs ), vetName );
			_view.x = ( _stage.stageWidth - _view.bg.width ) * 0.5;
			_view.y = ( _stage.stageHeight - _view.bg.height ) * 0.5;
		}
	}
}