package ghostmonk.interactive.timeline.framework.view 
{	
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.Background;
	import ghostmonk.interactive.timeline.components.MainTitle;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class StageMediator extends Mediator {
		
		public static const NAME:String = "stageMediator";
		private static const PADDING:Number = 10;
		
		private var _title:MainTitle;
		private var _background:Background;
		
		public function StageMediator( viewComponent:Stage ) 
		{		
			super( NAME, viewComponent );
			stage.stageFocusRect = false;
		}
		
		public function set title( value:MainTitle ) : void
		{
			_title = value;
			_title.x = stage.width * 0.5;
			_title.y = _title.field.height * 0.5 + PADDING;
			stage.addChild( _title );
		}
		
		public function set background( value:Background ) : void
		{
			_background = value;
			stage.addChild( _background );
		}
		
		public function get stage() : Stage 
		{	
			return viewComponent as Stage;	
		}
		
		override public function listNotificationInterests() : Array 
		{	
			return [  ];	
		}
		
		override public function handleNotification( note:INotification ) : void 
		{	
			
		}
	}
}