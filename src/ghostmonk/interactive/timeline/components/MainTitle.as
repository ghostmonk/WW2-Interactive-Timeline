package ghostmonk.interactive.timeline.components
{
	import assets.main.MainTitleAsset;
	
	import flash.events.Event;
	
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

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
			
			Animator.delay = Tween.BUILD_IN_DELAY;
			Animator.tween( boat, Tween.ALPHA_IN );
			
			Animator.delay = Tween.BUILD_IN_DELAY+ 0.2;
			Animator.textTween( field, text );
			
			Animator.delay = Tween.BUILD_IN_DELAY + 0.4;
			Animator.tween( plane, Tween.ALPHA_IN );
		}
	}
}