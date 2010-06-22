package ghostmonk.interactive.timeline.components
{
	import assets.main.MainTitleAsset;
	
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextFieldAutoSize;
	
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

	public class MainTitle extends MainTitleAsset
	{	
		private static const GLOW:GlowFilter = new GlowFilter( 0x990101, 0.7, 15, 15, 4, 3 );
		
		public function MainTitle()
		{
			//date.filters = [GLOW];
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			plane.alpha = boat.alpha = 0;
		}
		
		/* public function set dateText( value:String  ) : void
		{
			date.alpha = 0;
			date.text = value;
			Animator.transition = "easeNone";
			Animator.tween( date, { alpha:1, time:0.5 } );
		} */
		
		public function set text( value:String ) : void
		{
			field.autoSize = TextFieldAutoSize.LEFT;
			field.text = value;
			//date.width = field.width;
			//date.x = field.x;
			plane.x = field.x + field.width + 10;
		}	
		
		private function onAddedToStage( e:Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			Animator.delay = Tween.BUILD_IN_DELAY;
			Animator.tween( boat, Tween.ALPHA_IN );
			
			field.alpha = 0;
			
			Animator.delay = Tween.BUILD_IN_DELAY+ 0.2;
			Animator.tween( field, Tween.ALPHA_IN );
			
			Animator.delay = Tween.BUILD_IN_DELAY + 0.4;
			Animator.tween( plane, Tween.ALPHA_IN );
		}
	}
}