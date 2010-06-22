package ghostmonk.interactive.timeline.framework.view 
{	
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.Background;
	import ghostmonk.interactive.timeline.components.MainTitle;
	import ghostmonk.interactive.timeline.utils.Animator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class StageMediator extends Mediator 
	{
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
			_title.x = ( stage.width - _title.width ) * 0.5;
			_title.y = PADDING;
			//_title.date.text = "";
			stage.addChild( _title );
		}
		
		override public function listNotificationInterests() : Array
		{
			return [ 	
				//FilterMediator.FILTER_ALL,
				//FilterMediator.FILTER_YEAR  	
			];
		}
		
		override public function handleNotification( note:INotification ) : void
		{
			switch( note.getName() )
			{
				case FilterMediator.FILTER_ALL:	
					//_title.dateText = getRange( note.getBody() as Array );
					break;
				case FilterMediator.FILTER_YEAR:
					//_title.dateText = note.getBody().toString();
					break;
			}
		}
		
		private function getRange( yearArray:Array ) : String
		{
			return yearArray[ 1 ] + " - " + yearArray[ yearArray.length - 1 ];
		}
		
		public function set background( value:Background ) : void
		{
			_background = value;
			stage.addChild( _background.view );
			//stage.addChild( new Stats() );
		}
		
		public function get stage() : Stage 
		{	
			return viewComponent as Stage;	
		}
	}
}