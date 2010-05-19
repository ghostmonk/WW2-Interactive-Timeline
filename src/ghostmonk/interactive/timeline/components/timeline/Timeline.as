package ghostmonk.interactive.timeline.components.timeline
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ghostmonk.interactive.timeline.components.ui.Icon;
	import ghostmonk.interactive.timeline.data.EventDateData;
	import ghostmonk.interactive.timeline.utils.Tween;
	
	public class Timeline extends Sprite
	{
		private static const PADDING:int = 25;
		private static const BUILDIN_DELAY:Number = 300;
		
		private var _divider:TimelineDivider;
		private var _header:CategoryHeader;
		private var _positionCalc:PositionCalculator;
		
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
		
		public function set positionCalculator( value:PositionCalculator ) : void
		{
			_positionCalc = value;
		}
		
		public function createDateIcon( value:EventDateData ) : void
		{
			_positionCalc.yPos( value.date );
		}
		
		public function buildIn() : void
		{
			_divider.buildIn();
			_header.enable();
			fillGrid();
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
			_header.y = ( _divider.baseHeight - _header.height ) * 0.5;
			_divider.x = _header.width + PADDING;
			addChild( _header );
			addChild( _divider );
		}
		
		private function fillGrid() : void
		{
			var isFull:Boolean = false;
			var currentX:Number = _divider.x;
			var currentY:Number = _divider.y;
			var xOver:Number = currentX + _divider.baseWidth;
			var yOver:Number = currentY + _divider.baseHeight;
			
			var type:String = _header.image.currentFrame == 1 ? Icon.EVENT : Icon.VET;
			
			while( !isFull ) 
			{
				var marker:Icon = new Icon( type );
				marker.icon.stop();
				marker.x = currentX;
				marker.y = currentY;
				currentX += marker.width;
				if( currentX >= xOver )
				{
					currentY += marker.height;
					currentX = _divider.x;
				}
				addChild( marker );
				isFull = currentY >= yOver;
			}
		}
		
		private function onAddedToStage( e:Event ) : void
		{
			var timer:Timer = new Timer( Tween.BUILD_IN_DELAY * 1000, 1 )
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