package ghostmonk.interactive.timeline.components
{
	import assets.main.MainTitleAsset;
	
	import flash.events.Event;
	
	import ghostmonk.interactive.timeline.utils.Animation;

	public class MainTitle extends MainTitleAsset
	{
		public function MainTitle()
		{
			alpha = 0;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		public function set text( value:String ) : void
		{
			field.text = value;
		}	
		
		private function onAddedToStage( e:Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			Animation.tween( this, Animation.TITLE_ANIMATE_IN );
			Animation.tween( this, Animation.ALPHA_IN );
		}
	}
}