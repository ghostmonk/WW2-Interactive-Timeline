package ghostmonk.interactive.timeline.components.timeline
{
	import com.ghostmonk.display.graphics.shapes.Circle;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	
	import ghostmonk.interactive.timeline.components.ui.Icon;
	import ghostmonk.interactive.timeline.data.EventDateData;
	import ghostmonk.interactive.timeline.utils.Tween;
	
	public class Timeline extends Sprite
	{
		private static const PADDING:int = 30;
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
		
		private function fillGrid() : void
		{
			var isFull:Boolean = false;
			var currentX:Number = _divider.x - 10;
			var currentY:Number = _divider.y - 10;
			var xOver:Number = currentX + _divider.baseWidth + 10;
			var yOver:Number = currentY + _divider.baseHeight + 10;
			
			var type:String = _header.image.currentFrame == 1 ? Icon.EVENT : Icon.VET;
			var count:int = 0;
			while( !isFull ) 
			{
				count++;
				var marker:Sprite = getMarker( type, getLabelDirection( currentX, currentY ) );
				marker.x = currentX;
				marker.y = currentY;
				currentX += marker.width;
				if( currentX >= xOver )
				{
					currentY += marker.height;
					currentX = _divider.x - 10;
				}
				addChild( marker );
				isFull = currentY >= yOver;
			}
			trace( count );
		}
		
		private function getLabelDirection( xPos:Number, yPos:Number ) : int
		{
			var isTop:Boolean = yPos >= _divider.y + _divider.baseHeight * 0.5;
			var isLeft:Boolean = xPos >= _divider.x + _divider.baseWidth * 0.5;
			
			if( isTop && !isLeft ) return 1;
			if( !isTop && !isLeft ) return 2;
			if( !isTop && isLeft ) return 3;
			return 4;
		}
		
		private function getMarker( type:String, labelDirection:int, isCircle:Boolean = false ) : Sprite
		{
			if( isCircle )
			{
				var color:uint = type == Icon.EVENT ? 0xCF0202 : 0x2E3A76
				var circle:Circle = new Circle( color, 3, false );
				circle.filters = [ new BlurFilter() ]
				return circle;
			}
			
			var marker:Icon = new Icon( type, labelDirection );
			marker.scaleX = marker.scaleY = 0.9;
			marker.icon.stop();
			return marker;
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
		
		private function positionAssets() : void
		{
			_header.y = ( _divider.baseHeight - _header.height ) * 0.5;
			_divider.x = _header.width + PADDING;
			addChild( _header );
			addChild( _divider );
		}
	}
}