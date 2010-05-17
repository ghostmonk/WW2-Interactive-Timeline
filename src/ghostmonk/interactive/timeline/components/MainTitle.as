package ghostmonk.interactive.timeline.components
{
	import assets.main.MainTitleAsset;
	
	import flash.events.Event;
	
	import ghostmonk.interactive.timeline.utils.Animation;

	public class MainTitle extends MainTitleAsset
	{	
		public function MainTitle()
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			plane.alpha = boat.alpha = 0;
		}
		
		public function set text( value:String ) : void
		{
			field.text = value;
		}	
		
		private function onAddedToStage( e:Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			var text:String = field.text;
			field.text = "";
			
			Animation.delay = Animation.BUILD_IN_DELAY;
			Animation.tween( boat, Animation.ALPHA_IN );
			
			Animation.delay = Animation.BUILD_IN_DELAY+ 0.2;
			Animation.textTween( field, text );
			
			Animation.delay = Animation.BUILD_IN_DELAY + 0.4;
			Animation.tween( plane, Animation.ALPHA_IN );
		}
	}
}