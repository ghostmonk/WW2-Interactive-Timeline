package ghostmonk.interactive.timeline.components.timeline
{
	import com.ghostmonk.ui.interactive.buttons.NavigationButton;
	import com.ghostmonk.ui.navigation.NavButtonCollection;
	import com.ghostmonk.ui.navigation.NavigationBar;
	
	import flash.events.Event;
	
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

	public class TimelineFilter extends NavigationBar
	{
		override public function init( btns:NavButtonCollection ) : void
		{
			super.init( btns );
			collection.iterator.apply( hideBtn );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		public function buildIn() : void
		{
			var delay:Number = 0.5;
			collection.iterator.reset();
			while( collection.iterator.hasNext )
			{
				var btn:NavigationButton = collection.iterator.next as NavigationButton;
				showBtn( btn, delay );
				delay += 0.05;
			}
		}
		
		public function activateButton( id:Number ) : void
		{
			collection.getButtonByID( id ).activate();
			collection.getButtonByID( id ).disable();
		}
		
		private function hideBtn( btn:NavigationButton ) : void
		{
			btn.view.alpha = 0;
			btn.disable();
		}
		
		private function showBtn( btn:NavigationButton, delay:Number ) : void
		{
			Animator.delay = delay;
			Animator.tween( btn.view, Tween.ALPHA_IN, false );
			var offset:int = Math.random() > 0.5 ? -20 : 20;
			Animator.offsetTween( btn.view, 0, offset );
		}
		
		private function onAddedToStage( e:Event ) : void
		{
			buildIn();
		}
	}
}