package ghostmonk.interactive.timeline 
{	
	import assets.ui.PreloaderAsset;
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.display.graphics.shapes.Polygon;
	import com.ghostmonk.display.graphics.shapes.SimpleRectangle;
	import com.ghostmonk.utils.SiteLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class TimelineLoader extends SiteLoader 
	{
		private var _preloader:PreloaderAsset;
		private var _loadBar:SimpleRectangle;
		private var _currentPos:Point;
		private var _timer:Timer;
		
		public function TimelineLoader() 
		{	
			super( "WW2Timeline" );
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_preloader = new PreloaderAsset();
			_loadBar = new SimpleRectangle( 0x2E3A76, stage.stageWidth, 4 );
			_loadBar.y = stage.stageHeight * 0.5 - 2;
			_loadBar.scaleX = 0;
			addChild( _loadBar );
			_currentPos = new Point(  
				( stage.stageWidth - _preloader.width ) * 0.5 - 150,
				( stage.stageHeight - _preloader.height ) * 0.5 - 110
			)
			_timer = new Timer( 15, 1 );
		}
		
		override protected function updateLoader( percent:Number ) : void 
		{	
			_loadBar.scaleX = percent;
			_preloader.label.autoSize = TextFieldAutoSize.LEFT;
			_preloader.label.text = Math.ceil( 100 * ( 1 - percent ) ).toString();
			animateNumber();
		}
		
		private function animateNumber() : void
		{
			if( _timer.running ) return;
			
			var data:BitmapData = new BitmapData( _preloader.width, _preloader.height, true, 0x00000000 );
			data.draw( _preloader );
			
			var bitmap:Bitmap = new Bitmap( data );
			bitmap.alpha = 0;
			addChild( bitmap );
			
			bitmap.x = _currentPos.x;
			bitmap.y = _currentPos.y;
			_currentPos.x += bitmap.width + 10;
			
			if( _currentPos.x >= ( stage.stageWidth - bitmap.width ) * 0.5 + 200 )
			{
				_currentPos.x = ( stage.stageWidth - _preloader.width ) * 0.5 - 200;
				_currentPos.y += bitmap.height + 10;
				if( _currentPos.y >= ( stage.stageHeight - bitmap.height ) * 0.5 + 200 )
				{
					_currentPos.y = ( stage.stageHeight - bitmap.height ) * 0.5 - 110
				}
			}
			
			_timer.start();
			Tweener.addTween( bitmap, {  transition:Equations.easeNone, alpha:1, time:0.2, onComplete:tweenOut, onCompleteParams:[bitmap] } );
		}
		
		private function tweenOut( bitmap:Bitmap ) : void
		{
			Tweener.addTween( bitmap, {  transition:Equations.easeNone, alpha:0, time:0.3, onComplete:removeChild, onCompleteParams:[bitmap] } );
		}
		
		override protected function cleanUp() : void 
		{
			_preloader.label.text = "0";
			
			Tweener.addTween( _loadBar, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:removeChild, onCompleteParams:[ _loadBar ] } );
			_preloader = null;
			_currentPos = null;
			_timer = null;
		}
	}
}