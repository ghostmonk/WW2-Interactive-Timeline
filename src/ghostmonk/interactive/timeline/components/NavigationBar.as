package ghostmonk.interactive.timeline.components
{
	import assets.ui.LargeTextBtnAsset;
	import assets.ui.SmallTextBtnAsset;
	
	import flash.display.Sprite;
	
	import ghostmonk.interactive.timeline.components.ui.FilterEffectButton;
	import ghostmonk.interactive.timeline.events.NavigationEvent;
	
	[Event (name="yearSelection", type="ghostmonk.interactive.timeline.events.NavigationEvent")]
	[Event (name="monthSelection", type="ghostmonk.interactive.timeline.events.NavigationEvent")]

	public class NavigationBar extends Sprite
	{
		private var _eventType:String;
		private var _buttons:Array;
		
		public function createBar( ids:Array, eventType:String ) : void
		{
			_eventType = eventType;
			var buttonType:Class = eventType == NavigationEvent.MONTH_SELECTION ? LargeTextBtnAsset : SmallTextBtnAsset;
			
			for( var i:int = 0; i < ids; i++ )
			{
				var button:FilterEffectButton = new FilterEffectButton( i, new buttonType() as Sprite );
				button.text = ids[ i ];
				button
			}
		}
		
		public function onClick( e:NavigationEvent ) : void
		{
			dispatchEvent( new NavigationEvent( _eventType, e.index ) );
		}
	}
}