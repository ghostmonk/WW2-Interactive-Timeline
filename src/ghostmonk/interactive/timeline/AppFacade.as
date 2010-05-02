package ghostmonk.interactive.timeline 
{	
	import ghostmonk.interactive.timeline.data.BootStrapData;
	import ghostmonk.interactive.timeline.framework.controller.BootStrapCmd;
	import ghostmonk.interactive.timeline.framework.controller.CreateComponentsCmd;
	
	import org.puremvc.as3.patterns.facade.Facade;

	/**
	 * 
	 * @author ghostmonk 15/08/2009
	 * 
	 */
	public class AppFacade extends Facade
	{	
		public static const BOOT_STRAP:String = "bootStrap";
		public static const CREATE_COMPONENTS:String = "createComponents";
		
		override protected function initializeController() : void 
		{	
			super.initializeController();
			
			registerCommand( BOOT_STRAP, BootStrapCmd );
			registerCommand( CREATE_COMPONENTS, CreateComponentsCmd );
		}
		
		public function bootStrap( data:BootStrapData ) : void 
		{	
			sendNotification( BOOT_STRAP, data );
		}
	}
}