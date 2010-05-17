package ghostmonk.interactive.timeline.framework.controller 
{	
	import assets.main.BackgroundTexture;
	import assets.ui.LargeTextBtnAsset;
	import assets.ui.SmallTextBtnAsset;
	
	import com.ghostmonk.ui.interactive.buttons.interfaces.INavigationButton;
	import com.ghostmonk.ui.navigation.NavButtonCollection;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	
	import ghostmonk.interactive.timeline.components.Background;
	import ghostmonk.interactive.timeline.components.MainTitle;
	import ghostmonk.interactive.timeline.components.timeline.CategoryHeader;
	import ghostmonk.interactive.timeline.components.timeline.Timeline;
	import ghostmonk.interactive.timeline.components.timeline.TimelineDivider;
	import ghostmonk.interactive.timeline.components.timeline.TimelineFilter;
	import ghostmonk.interactive.timeline.components.ui.FilterEffectButton;
	import ghostmonk.interactive.timeline.framework.model.ConfigProxy;
	import ghostmonk.interactive.timeline.framework.view.FilterMediator;
	import ghostmonk.interactive.timeline.framework.view.StageMediator;
	import ghostmonk.interactive.timeline.framework.view.TimelineMediator;
	
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
			createStageAssets( stageMediator, configProxy );
			createFilterMediator( stageMediator.stage, configProxy );
			createTimelineMediator( configProxy, stageMediator.stage );
		}
		
		private function createTimelineMediator( config:ConfigProxy, stage:Stage ) : TimelineMediator
		{
			var eventTimeline:Timeline = getTimeline();
			var soldierTimeline:Timeline = getTimeline();
			return new TimelineMediator( soldierTimeline, eventTimeline, config, stage );
		}
		
		private function createFilterMediator( stage:Stage, proxy:ConfigProxy ) : FilterMediator
		{
			var monthBar:TimelineFilter = getFilter( proxy.months, SmallTextBtnAsset, 22.5 );
			var yearBar:TimelineFilter = getFilter( proxy.years, LargeTextBtnAsset, 27 );
			return new FilterMediator( monthBar, yearBar, stage );
		}
		
		private function createStageAssets( mediator:StageMediator, proxy:ConfigProxy ) : void
		{
			var titleAsset:MainTitle = new MainTitle();
			mediator.background = new Background( new BackgroundTexture( 0, 0 ) );
			titleAsset.text = proxy.mainTitle;
			mediator.title = titleAsset;
		}
		
		private function getTimeline() : Timeline
		{
			var output:Timeline = new Timeline();
			output.header = new CategoryHeader();
			output.divider = new TimelineDivider();
			return output;
		}
		
		private function getFilter( titles:Array, btnType:Class, btnPadding:Number ) : TimelineFilter
		{
			var output:TimelineFilter = new TimelineFilter();
			output.padding = btnPadding;
			output.isVertical = false;
			var collection:NavButtonCollection = new NavButtonCollection();
			
			for( var i:int = 0; i < titles.length; i++ )
			{
				collection.addButton( getButton( new btnType(), i, titles[ i ] ) );
			}
			
			output.init( collection );
			return output;
		}
		
		private function getButton( view:Sprite, id:int, title:String ) : INavigationButton
		{
			var textField:TextField = view is LargeTextBtnAsset 
				? ( view as LargeTextBtnAsset ).field 
				: ( view as SmallTextBtnAsset ).field;
			var btn:INavigationButton = new FilterEffectButton( view, textField );
			btn.id = id;
			btn.text = title;
			return btn;
		}
	}
}