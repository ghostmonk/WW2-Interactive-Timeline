package ghostmonk.interactive.timeline.components.view
{
	import assets.view.OverlayAsset;
	
	import com.ghostmonk.net.AssetLoader;
	import com.ghostmonk.ui.RotatingBufferIcon;
	import com.ghostmonk.ui.interactive.buttons.InteractiveSprite;
	
	import flash.display.Bitmap;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.system.LoaderContext;
	
	import ghostmonk.interactive.timeline.events.OverlayEvent;
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;
	
	[Event (name="close", type="ghostmonk.interactive.timeline.events.OverlayEvent")]

	public class Overlay extends OverlayAsset
	{
		private var _closeBtn:InteractiveSprite;
		private var _rotatingBuffer:RotatingBufferIcon;
		private var _currentBitmap:Bitmap;
		
		public function Overlay()
		{
			super();
			bg.alpha = 0.9;
			_closeBtn = new InteractiveSprite( closeButton );
			_closeBtn.setCallbacks( onClick );
			_closeBtn.enable();
			alpha = 0;
			_rotatingBuffer = new RotatingBufferIcon( 0x2E3A76 );
			_rotatingBuffer.x = ( width - _rotatingBuffer.width ) * 0.5;
			_rotatingBuffer.y = ( bodyField.y - _rotatingBuffer.height ) * 0.5;
		}
		
		public function loadImg( src:String ) : void
		{
			if( _currentBitmap ) removeChild( _currentBitmap );
			var loader:AssetLoader = new AssetLoader( src, onImgLoaded, onLoadFail, null, new LoaderContext( true ) );
			addChild( _rotatingBuffer );
			_rotatingBuffer.buildIn();
		}
		
		public function buildIn() : void
		{
			Animator.tween( this, Tween.ALPHA_IN );
		}
		
		public function buildOut() : void
		{
			Animator.setCallback( parent.removeChild, [ this ] );
			Animator.tween( this, Tween.ALPHA_OUT );	
		}
		 
		private function onClick( e:MouseEvent ) : void
		{
			dispatchEvent( new OverlayEvent( OverlayEvent.CLOSE ) );
		}
		
		private function onLoadFail( e:IOErrorEvent ) : void
		{
			_rotatingBuffer.buildOut();
			trace( "error" );
		}
		
		private function onImgLoaded( bitmap:Bitmap ) : void
		{
			addChild( bitmap );
			_currentBitmap = bitmap;
			_currentBitmap.alpha = 0;
			_currentBitmap.x = ( width - bitmap.width ) * 0.5;
			_currentBitmap.y = ( bodyField.y - bitmap.height ) * 0.5;
			Animator.tween( _currentBitmap, Tween.ALPHA_IN );
			_rotatingBuffer.buildOut();
		}
	}
}