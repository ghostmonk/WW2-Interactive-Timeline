package ghostmonk.interactive.timeline.components.ui
{
	import com.ghostmonk.ui.interactive.buttons.NavigationButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class FilterEffectButton extends NavigationButton
	{
		private var _field:TextField;
		
		public function FilterEffectButton( view:Sprite, field:TextField )
		{
			super( view );
			_field = field;
			_field.autoSize = TextFieldAutoSize.LEFT;
			rollOutFunc = rollOut;
			rollOverFunc = rollOver;
		}
		
		override public function set text( value:String ) : void
		{
			_field.text = value;
		}
		
		override public function activate() : void
		{
			rollOver();
			disable();
		}
		
		override public function deactivate() : void
		{
			rollOut();
			enable();
		}
		
		private function rollOut( e:MouseEvent = null ) : void
		{
			view.filters = [];
			_field.textColor = 0x000000;
		}
		
		private function rollOver( e:MouseEvent = null ) : void
		{
			view.filters = [ new GlowFilter( 0x990101, 0.8, 15, 15, 10, 3 ) ];
			_field.textColor = 0xFFFFFF;
		}	
	}
}