package ghostmonk.interactive.timeline.components
{
	import assets.main.BackgroundAsset;
	
	import flash.events.Event;
	
	import ghostmonk.interactive.timeline.utils.Animation;

	public class Background extends BackgroundAsset
	{
		public function Background()
		{
			alpha = 0;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		public function onAddedToStage( e:Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			Animation.tween( this, Animation.ALPHA_IN );
		}
	}
}