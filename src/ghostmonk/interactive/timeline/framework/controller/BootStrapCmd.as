package ghostmonk.interactive.timeline.framework.controller 
{	
	import com.ghostmonk.net.XMLLoader;
	
	import ghostmonk.interactive.timeline.AppFacade;
	import ghostmonk.interactive.timeline.data.BootStrapData;
	import ghostmonk.interactive.timeline.data.ConfigData;
	import ghostmonk.interactive.timeline.framework.model.ConfigProxy;
	import ghostmonk.interactive.timeline.framework.view.StageMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 
	 * @author ghostmonk 15/08/2009
	 * 
	 */
	public class BootStrapCmd extends SimpleCommand 
	{	
		override public function execute( note:INotification ) : void 
		{	
			var data:BootStrapData = note.getBody() as BootStrapData;
			var loader:XMLLoader = new XMLLoader( data.congfigURL, onConfigDataLoaded );
			facade.registerMediator( new StageMediator( data.stage ) );
		}
		
		private function onConfigDataLoaded( data:XML ) : void
		{
			var config:ConfigProxy = new ConfigProxy( new ConfigData( data ) );
			facade.registerProxy( config );
			sendNotification( AppFacade.CREATE_COMPONENTS, config );
		}
	}
}