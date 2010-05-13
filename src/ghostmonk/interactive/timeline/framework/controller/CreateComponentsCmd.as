package ghostmonk.interactive.timeline.framework.controller 
{	
	import assets.main.BackgroundTexture;
	import assets.ui.LargeTextBtnAsset;
	import assets.ui.SmallTextBtnAsset;
	
	import com.ghostmonk.ui.interactive.buttons.interfaces.INavigationButton;
	import com.ghostmonk.ui.navigation.NavButtonCollection;
	import com.ghostmonk.ui.navigation.NavigationBar;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	
	import ghostmonk.interactive.timeline.components.Background;
	import ghostmonk.interactive.timeline.components.MainTitle;
	import ghostmonk.interactive.timeline.components.timeline.TimelineFilter;
	import ghostmonk.interactive.timeline.components.ui.FilterEffectButton;
	import ghostmonk.interactive.timeline.framework.model.ConfigProxy;
	import ghostmonk.interactive.timeline.framework.view.FilterMediator;
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
			createNavMediator( stageMediator.stage, configProxy );
			
			//stageMediator.stage.addChild( new CategoryHeader() );
			//stageMediator.stage.addChild( new DivisionLines() );
			//stageMediator.stage.addChild( new Navigation() );
			//stageMediator.stage.addChild( new Icon() );
			//stageMediator.stage.addChild( new IconLabel() );
			//stageMediator.stage.addChild( new MainTitle() );
		}
		
		private function createNavMediator( stage:Stage, proxy:ConfigProxy ) : FilterMediator
		{
			var monthBar:TimelineFilter = createNavBar( proxy.months, SmallTextBtnAsset );
			var yearBar:TimelineFilter = createNavBar( proxy.years, LargeTextBtnAsset );
			return new FilterMediator( monthBar, yearBar, stage );
		}
		
		private function createNavBar( titles:Array, btnType:Class ) : TimelineFilter
		{
			var output:TimelineFilter = new TimelineFilter();
			output.padding = 15;
			output.isVertical = false;
			var collection:NavButtonCollection = new NavButtonCollection();
			
			for( var i:int = 0; i < titles.length; i++ )
			{
				var view:Sprite = new btnType();
				var textField:TextField = view is LargeTextBtnAsset ? ( view as LargeTextBtnAsset ).field : ( view as SmallTextBtnAsset ).field;
				var btn:INavigationButton = new FilterEffectButton( view, textField );
				btn.id = i;
				btn.text = titles[ i ];
				collection.addButton( btn );
			}
			
			output.init( collection );
			return output;
		}
		
		private function buildStage( mediator:StageMediator, proxy:ConfigProxy ) : void
		{
			var titleAsset:MainTitle = new MainTitle();
			mediator.background = new Background( new BackgroundTexture( 0, 0 ) );
			titleAsset.text = proxy.mainTitle;
			mediator.title = titleAsset;
		}
	}
}