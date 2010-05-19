package ghostmonk.interactive.timeline.framework.controller
{
	import assets.ui.LargeTextBtnAsset;
	import assets.ui.SmallTextBtnAsset;
	
	import com.ghostmonk.ui.interactive.buttons.interfaces.INavigationButton;
	import com.ghostmonk.ui.navigation.NavButtonCollection;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	
	import ghostmonk.interactive.timeline.components.timeline.TimelineFilter;
	import ghostmonk.interactive.timeline.components.ui.FilterEffectButton;
	import ghostmonk.interactive.timeline.framework.model.ConfigProxy;
	import ghostmonk.interactive.timeline.framework.view.FilterMediator;
	import ghostmonk.interactive.timeline.framework.view.StageMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class CreateFilter extends SimpleCommand
	{
		override public function execute( note:INotification ) : void 
		{	
			var configProxy:ConfigProxy = note.getBody() as ConfigProxy;
			var stageMediator:StageMediator = facade.retrieveMediator( StageMediator.NAME ) as StageMediator;
			
			createFilterMediator( stageMediator.stage, configProxy );
		}
		
		private function createFilterMediator( stage:Stage, proxy:ConfigProxy ) : void
		{
			var monthBar:TimelineFilter = getFilter( proxy.months, SmallTextBtnAsset, 22.5 );
			var yearBar:TimelineFilter = getFilter( proxy.years, LargeTextBtnAsset, 26 );
			facade.registerMediator( new FilterMediator( monthBar, yearBar, stage ) );
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