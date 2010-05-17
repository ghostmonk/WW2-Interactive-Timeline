package ghostmonk.interactive.timeline.components.timeline
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ghostmonk.interactive.timeline.utils.Animation;
	
	public class Timeline extends Sprite
	{
		private static const PADDING:int = 40;
		private static const BUILDIN_DELAY:Number = 300;
		
		private var _divider:TimelineDivider;
		private var _header:CategoryHeader;
		
		public function set divider( value:TimelineDivider ) : void
		{
			_divider = value;
			if( _header ) positionAssets();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		public function set header( value:CategoryHeader ) : void
		{
			_header = value;
			if( _divider ) positionAssets();
		}
		
		public function get header() : CategoryHeader
		{
			return _header;
		}
		
		public function buildIn() : void
		{
			_divider.buildIn();
			_header.enable();
		}
		
		public function buildOut() : void
		{
			_divider.buildOut();
			_header.disable();
		}
		
		public function fullMode() : void
		{
			
		}
		
		public function normalMode() : void
		{
			_divider.viewHeight = _divider.baseHeight;
		}
		
		private function positionAssets() : void
		{
			_header.y = -( _header.height * 0.5 );
			_divider.x = _header.width + PADDING;
			addChild( _header );
			addChild( _divider );
		}
		
		private function onAddedToStage( e:Event ) : void
		{
			
			var timer:Timer = new Timer( Animation.BUILD_IN_DELAY * 1000, 1 )
			timer.addEventListener( TimerEvent.TIMER, 
				function( e:TimerEvent ) : void
				{
					buildIn();
					timer = null;
				}
			);
			timer.start();
		}
	}
}