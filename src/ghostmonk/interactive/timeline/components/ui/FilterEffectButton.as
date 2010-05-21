package ghostmonk.interactive.timeline.components.ui
{
	import com.ghostmonk.ui.interactive.buttons.NavigationButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

	public class FilterEffectButton extends NavigationButton
	{
		private static const GLOW:GlowFilter = new GlowFilter( 0x990101, 0, 15, 15, 10, 3 );
		private var _field:TextField;
		
		public function FilterEffectButton( view:Sprite, field:TextField )
		{
			super( view );
			_field = field;
			_field.filters = [ GLOW ];
			_field.autoSize = TextFieldAutoSize.LEFT;
		}
		
		override public function set text( value:String ) : void
		{
			_field.text = value;
		}
		
		override public function activate() : void
		{
			onRollover();
			disable();
		}
		
		override public function deactivate() : void
		{
			GLOW.alpha = 0;
			view.filters = [ GLOW ];
			_field.textColor = 0x000000;
			enable();
		}
		
		override protected function onRollout( e:MouseEvent = null ) : void
		{
			GLOW.alpha = 0;
			view.filters = [GLOW];
			_field.textColor = 0x000000;
			//Animator.filterTween( view, GLOW );
			//Animator.tween( _field, { _text_color:0x000000, time:Tween.BASE_TIME } );
		}
		
		override protected function onRollover( e:MouseEvent = null ) : void
		{
			GLOW.alpha = 1;
			view.filters = [GLOW];
			_field.textColor = 0xFFFFFF;
			//Animator.filterTween( view, GLOW );
			//Animator.tween( _field, { _text_color:0xFFFFFF, time:Tween.BASE_TIME } );
		}	
	}
}