package ghostmonk.interactive.timeline.components.ui
{
	import com.ghostmonk.events.IDEvent;
	import com.ghostmonk.ui.interactive.buttons.NavigationButton;
	
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.text.TextField;

	public class FilterEffectButton extends NavigationButton
	{
		private var _id:int;
		private var _field:TextField;
		
		public function FilterEffectButton( view:Sprite, field:TextField )
		{
			super( view );
			_field = field;
			rollOutFunc = onRollOut;
			rollOverFunc = onRollOver;
		}
		
		override public function set text( value:String ) : void
		{
			_field.text = id;
		}
		
		private function onRollOut( e:MouseEvent ) : void
		{
			view.filters = [];
		}
		
		private function onRollOver( e:MouseEvent ) : void
		{
			view.filters = [ new GlowFilter() ];
			_field.transform.colorTransform = new ColorTransform(  );
		}
	}
}