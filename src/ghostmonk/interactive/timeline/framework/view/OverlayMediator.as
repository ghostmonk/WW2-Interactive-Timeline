package ghostmonk.interactive.timeline.framework.view
{
	import com.ghostmonk.display.graphics.shapes.SimpleRectangle;
	
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.view.Overlay;
	import ghostmonk.interactive.timeline.data.collections.WarEventData;
	import ghostmonk.interactive.timeline.events.OverlayEvent;
	import ghostmonk.interactive.timeline.events.TimelineEvent;
	import ghostmonk.interactive.timeline.framework.model.TimelineDataProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class OverlayMediator extends Mediator
	{
		public static const NAME:String = "OverlayMediator";
		private var _stage:Stage;
		private var _data:TimelineDataProxy;
		private var _view:Overlay;
		private var _interactiveNet:SimpleRectangle;
		
		public function OverlayMediator( viewComponent:Overlay, stage:Stage )
		{
			_stage = stage;
			
			_interactiveNet = new SimpleRectangle( 0, _stage.stageWidth, _stage.stageWidth );
			_interactiveNet.alpha = 0;
			
			_view = viewComponent;
			_view.addEventListener( OverlayEvent.CLOSE, onCloseOverlay );
			
			super( NAME, viewComponent );
		}
		
		public function get view() : Overlay
		{
			return _view;
		}
		
		override public function listNotificationInterests() : Array
		{
			return [ 
				TimelineEvent.ICON_CLICK,
				TimelineDataProxy.TIMELINE_DATA_READY
			];
		}
		
		override public function handleNotification( note:INotification ) : void
		{
			switch( note.getName() )
			{
				case TimelineEvent.ICON_CLICK:
					showOverlay( note.getBody() as String );
					break;
					
				case TimelineDataProxy.TIMELINE_DATA_READY:
					_data = note.getBody() as TimelineDataProxy;
					break;
			}
		}
		
		private function showOverlay( id:String ) : void
		{
			_stage.addChild( _interactiveNet );
			var warEventData:WarEventData = _data.warEventCollection.getDataByID( id );
			_view.bodyField.text = warEventData.text;
			_stage.addChild( _view );
			_view.buildIn();
			_view.loadImg( _data.thumbLink + warEventData.img );
			_view.x = ( _stage.stageWidth - _view.width ) * 0.5;
			_view.y = ( _stage.stageHeight - _view.height ) * 0.5;
		}
		
		private function onCloseOverlay( e:OverlayEvent ) : void
		{
			_stage.removeChild( _interactiveNet );
			_view.buildOut();
		}
	}
}