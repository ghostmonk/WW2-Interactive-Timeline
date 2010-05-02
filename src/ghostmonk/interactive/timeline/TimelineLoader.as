package ghostmonk.interactive.timeline 
{	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.ghostmonk.utils.SiteLoader;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * 
	 * @author ghostmonk 16/08/2009
	 * 
	 */
	public class TimelineLoader extends SiteLoader 
	{
		private var _preloader:PreloaderAsset;
		private var _currentPercent:Number;
		private var _targetPercent:Number;
		
		public function TimelineLoader() 
		{	
			super( "WW2Timeline" );
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_preloader = new PreloaderAsset();
			addChild( _preloader );
			
			_preloader.alpha = 0;
			Tweener.addTween( _preloader, { alpha:1, time:0.3, transition:Equations.easeNone } );
			
			_preloader.x = stage.stageWidth * 0.5;
			_preloader.y = stage.stageHeight * 0.5;
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			_targetPercent = 100;
			_currentPercent = 100;
		}
		
		override protected function updateLoader( percent:Number ) : void 
		{	
			_targetPercent = Math.ceil( 100 * ( 1 - percent ) );
		}
		
		override protected function cleanUp() : void 
		{
			_preloader.label.text = "0";
			removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			Tweener.addTween( _preloader, { alpha:0, time:0.3, transition:Equations.easeNone, onComplete:removeChild, onCompleteParams:[ _preloader ] } );
		}
		
		private function onEnterFrame( e:Event ) : void
		{
			if( _targetPercent < _currentPercent )
			{
				_preloader.label.text = Math.max( 0, ( _currentPercent -= 3 ) ).toString();
			}
		}
	}
}