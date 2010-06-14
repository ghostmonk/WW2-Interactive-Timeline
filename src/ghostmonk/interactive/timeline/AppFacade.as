package ghostmonk.interactive.timeline 
{	
	import ghostmonk.interactive.timeline.data.BootStrapData;
	import ghostmonk.interactive.timeline.framework.controller.CommandTree;
	
	import org.puremvc.as3.patterns.facade.Facade;

	/**
	 * 
	 * @author ghostmonk 15/08/2009
	 * 
	 */
	public class AppFacade extends Facade
	{
		public static var LANGUAGE:String = "en";
		
		public static function isEnglish() : Boolean
		{
			return LANGUAGE.slice( 0, 2 ) == "en";
		}
		
		override protected function initializeController() : void 
		{	
			super.initializeController();
			registerCommand( CommandTree.EXECUTE, CommandTree );
		}
		
		public function bootStrap( data:BootStrapData ) : void 
		{
			sendNotification( CommandTree.EXECUTE );
			sendNotification( CommandTree.CREATE_STAGE_MEDIATOR, data );
		}
	}
}