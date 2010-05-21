package ghostmonk.interactive.timeline.framework.controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class CommandTree extends SimpleCommand
	{
		public static const EXECUTE:String = "CommandTree";
		public static const CONFIG_READY:String = "configReady";
		public static const CREATE_STAGE_MEDIATOR:String = "createStageMediator";
		public static const CREATE_TIMELINE:String = "createComponents";
		public static const CREATE_FILTER:String = "createFilter";
		public static const LOAD_TIMELINE_DATA:String = "loadTimelineData";
		public static const CREATE_OVERLAY:String = "createOverlay"
		
		override public function execute( note:INotification ) : void
		{
			facade.registerCommand( CREATE_STAGE_MEDIATOR, CreateStageMediator );
			facade.registerCommand( CREATE_TIMELINE, CreateTimeline );
			facade.registerCommand( CREATE_FILTER, CreateFilter );
			facade.registerCommand( LOAD_TIMELINE_DATA, LoadTimelineData );
			facade.registerCommand( CREATE_OVERLAY, CreateOverlay );
		}
	}
}