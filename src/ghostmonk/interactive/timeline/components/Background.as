package ghostmonk.interactive.timeline.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

	public class Background
	{
		private var _view:Bitmap;
		
		public function Background( viewData:BitmapData )
		{
			_view = new Bitmap( viewData );
			_view.alpha = 0.3;
			//_view.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		public function get view() : Bitmap
		{
			return _view;
		}
		
		public function onAddedToStage( e:Event ) : void
		{
			_view.removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			Animator.tween( _view, Tween.BACKGROUND_BUILD_IN );
		}
	}
}