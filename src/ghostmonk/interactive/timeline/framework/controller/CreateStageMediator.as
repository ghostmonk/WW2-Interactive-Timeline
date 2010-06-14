package ghostmonk.interactive.timeline.framework.controller 
{	
	import assets.main.BackgroundTexture;
	
	import com.ghostmonk.net.XMLLoader;
	
	import ghostmonk.interactive.timeline.AppFacade;
	import ghostmonk.interactive.timeline.components.Background;
	import ghostmonk.interactive.timeline.components.MainTitle;
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
	public class CreateStageMediator extends SimpleCommand 
	{	
		private var _stageMediator:StageMediator;
		
		override public function execute( note:INotification ) : void 
		{	
			var data:BootStrapData = note.getBody() as BootStrapData;
			var loader:XMLLoader = new XMLLoader( data.congfigURL, onConfigDataLoaded );
			
			_stageMediator = new StageMediator( data.stage ); 
			facade.registerMediator( _stageMediator );
		}
		
		private function onConfigDataLoaded( data:XML ) : void
		{
			AppFacade.LANGUAGE = data.@lang.toString();
			var config:ConfigProxy = new ConfigProxy( new ConfigData( data ) );
			facade.registerProxy( config );
			
			createStageAssets( _stageMediator, config.mainTitle );
			sendNotification( CommandTree.CREATE_OVERLAY, config );
			sendNotification( CommandTree.CONFIG_READY, config );
			sendNotification( CommandTree.CREATE_TIMELINE, config );
			sendNotification( CommandTree.CREATE_FILTER, config );
			sendNotification( CommandTree.LOAD_TIMELINE_DATA, config.timelineDataURL );
		}
		
		private function createStageAssets( mediator:StageMediator, mainTitle:String ) : void
		{
			var titleAsset:MainTitle = new MainTitle();
			mediator.background = new Background( new BackgroundTexture( 0, 0 ) );
			titleAsset.text = mainTitle;
			mediator.title = titleAsset;
		}
	}
}