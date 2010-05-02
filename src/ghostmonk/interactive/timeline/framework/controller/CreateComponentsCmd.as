package ghostmonk.interactive.timeline.framework.controller 
{	
	import ghostmonk.interactive.timeline.components.Background;
	import ghostmonk.interactive.timeline.components.MainTitle;
	import ghostmonk.interactive.timeline.framework.model.ConfigProxy;
	import ghostmonk.interactive.timeline.framework.view.StageMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class CreateComponentsCmd extends SimpleCommand 
	{	
		override public function execute( note:INotification ) : void 
		{	
			var configProxy:ConfigProxy = note.getBody() as ConfigProxy;
			var stageMediator:StageMediator = facade.retrieveMediator( StageMediator.NAME ) as StageMediator;
			buildStage( stageMediator, configProxy );
			
			//stageMediator.stage.addChild( new CategoryHeader() );
			//stageMediator.stage.addChild( new DivisionLines() );
			//stageMediator.stage.addChild( new Navigation() );
			//stageMediator.stage.addChild( new FilterEffectButton() );
			//stageMediator.stage.addChild( new Icon() );
			//stageMediator.stage.addChild( new IconLabel() );
			//stageMediator.stage.addChild( new MainTitle() );
		}
		
		public function buildStage( mediator:StageMediator, proxy:ConfigProxy ) : void
		{
			var titleAsset:MainTitle = new MainTitle();
			mediator.background = new Background();
			titleAsset.text = proxy.mainTitle;
			mediator.title = titleAsset;
		}
	}
}