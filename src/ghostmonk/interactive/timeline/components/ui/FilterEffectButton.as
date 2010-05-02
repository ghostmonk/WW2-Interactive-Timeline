package ghostmonk.interactive.timeline.components.ui
{
	import assets.ui.LargeTextBtnAsset;
	import assets.ui.SmallTextBtnAsset;
	
	import com.ghostmonk.ui.composed.ClickableSprite;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ghostmonk.interactive.timeline.events.NavigationEvent;

	public class FilterEffectButton extends ClickableSprite
	{
		private var _id:int;
		private var _field:TextField;
		private var _eventType:String;
		
		public function FilterEffectButton( id:int, view:Sprite )
		{
			super( view, onClick );
			_id = id;
			_field = btn is LargeTextBtnAsset ? ( btn as LargeTextBtnAsset ).field : ( btn as SmallTextBtnAsset ).field;
			_eventType = btn is LargeTextBtnAsset ? NavigationEvent.YEAR_SELECTION : NavigationEvent.MONTH_SELECTION; 
			
			
		}
		
		public function set text( value:String ) : void
		{
			_field.text = id;
		}
		
		public function onClick( e:MouseEvent ) : void
		{
			dispatchEvent( new NavigationEvent( _eventType, _id ) );
		}
	}
}