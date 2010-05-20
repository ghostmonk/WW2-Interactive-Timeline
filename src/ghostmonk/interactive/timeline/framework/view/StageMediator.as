package ghostmonk.interactive.timeline.framework.view 
{	
	import flash.display.Stage;
	
	import ghostmonk.interactive.timeline.components.Background;
	import ghostmonk.interactive.timeline.components.MainTitle;
	
	import net.hires.debug.Stats;
	
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class StageMediator extends Mediator 
	{
		public static const NAME:String = "stageMediator";
		private static const PADDING:Number = 10;
		
		private var _title:MainTitle;
		private var _background:Background;
		
		public function StageMediator( viewComponent:Stage ) 
		{		
			super( NAME, viewComponent );
			stage.stageFocusRect = false;
		}
		
		public function set title( value:MainTitle ) : void
		{
			_title = value;
			_title.x = ( stage.width - _title.width ) * 0.5;
			_title.y = PADDING;
			stage.addChild( _title );
		}
		
		public function set background( value:Background ) : void
		{
			_background = value;
			stage.addChild( _background.view );
			stage.addChild( new Stats() );
		}
		
		public function get stage() : Stage 
		{	
			return viewComponent as Stage;	
		}
	}
}