package ghostmonk.interactive.timeline.components.timeline
{
	import com.ghostmonk.ui.interactive.buttons.NavigationButton;
	import com.ghostmonk.ui.navigation.NavButtonCollection;
	import com.ghostmonk.ui.navigation.NavigationBar;
	
	import flash.events.Event;
	
	import ghostmonk.interactive.timeline.utils.Animation;

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
				delay += 0.1;
			}
		}
		
		private function hideBtn( btn:NavigationButton ) : void
		{
			btn.view.alpha = 0;
			btn.disable();
		}
		
		private function showBtn( btn:NavigationButton, delay:Number ) : void
		{
			Animation.delay = delay;
			Animation.tween( btn.view, Animation.ALPHA_IN, false );
			Animation.offsetTween( btn.view, 0, -20 );
			btn.enable();
		}
		
		private function onAddedToStage( e:Event ) : void
		{
			buildIn();
		}
	}
}