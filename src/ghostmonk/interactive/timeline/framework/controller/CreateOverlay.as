package ghostmonk.interactive.timeline.framework.controller
{
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.view.Overlay;
	import ghostmonk.interactive.timeline.framework.view.OverlayMediator;
	import ghostmonk.interactive.timeline.framework.view.StageMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class CreateOverlay extends SimpleCommand
	{
		override public function execute( note:INotification ) : void
		{
			var stage:Stage = ( facade.retrieveMediator( StageMediator.NAME ) as StageMediator ).stage;
			facade.registerMediator( new OverlayMediator( new Overlay(), stage ) ); 
		}
	}
}