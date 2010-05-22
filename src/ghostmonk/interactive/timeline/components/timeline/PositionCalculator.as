package ghostmonk.interactive.timeline.components.timeline
{
	import flash.geom.Point;
	
	import ghostmonk.interactive.timeline.components.ui.Icon;
	
	public class PositionCalculator
	{
		private static const CORRECTION:Number = 0;
		private static const FULL:int = 0;
		private static const EMPTY:int = 1;
		
		private var _numYears:int;
		private var _minYear:int;
		private var _yearDiv:Number;
		private var _monthDiv:Number;
		private var _dayDiv:Number;
		
		private var _fullMonthDiv:Number;
		private var _fullDayDiv:Number;
		
		private var _positionTracker:Array = [];
		
		private var _width:int;
		private var _height:int;
		private var _xDiv:Number;
		private var _yDiv:Number;
		
		public function setDimensions( divider:TimelineDivider, icon:Icon ) : void
		{
			_xDiv = icon.view.width;
			_yDiv = icon.view.height;
			_width = divider.baseWidth;
			_height = divider.baseHeight;
			reset();
			if( _width ) setDivisionWidth();
		}
		
		public function reset() : void
		{
			_positionTracker = [];
			
			var xMax:int = Math.ceil( _width / _xDiv );
			var yMax:int = Math.ceil( _height / _yDiv );
			
			for( var x:int = 0; x < xMax; x++ )
			{
				_positionTracker[ x ] = [];
				for( var y:int = 0; y < yMax; y++ ) _positionTracker[ x ][ y ] = EMPTY;
			}
		}
		
		public function setDateRange( minYear:int, maxYear:int ) : void
		{
			_minYear = minYear;
			_numYears = maxYear - minYear;
			if( _width ) setDivisionWidth();
		}
		
		public function fullViewPoint( date:Date ) : Point
		{
			var yearValue:Number = _yearDiv * ( date.fullYear - _minYear );
			var monthValue:Number = _monthDiv * ( date.month - 1 );
			var dayValue:Number = _dayDiv * ( date.date );
			
			var output:Number = yearValue + monthValue + dayValue;
			
			return getTranslatedPoint( output + CORRECTION );
		}
		
		public function yearViewPoint( date:Date ) : Point
		{
			var monthValue:Number = _fullMonthDiv * ( date.month );
			var dayValue:Number = _fullDayDiv * ( date.date );
			
			var output:Number = monthValue + dayValue;
			
			return getTranslatedPoint( output );
		}
		
		private function getTranslatedPoint( xPos:Number ) : Point
		{
			var xNode:int = Math.ceil( xPos / _xDiv );	 
			var yNode:int = testYColumn( xNode );
			
			if( yNode == -1 ) 
			{
				var iters:int = 0;
				/*while( iters < 5 )
				{
					xNode += 1;
					yNode = testYColumn( xNode );
					iters++;
				}*/
			}
			return new Point( xNode * _xDiv, yNode * _yDiv );
		}
		
		private function testYColumn( xNode:int ) : int
		{
			var iterations:int = Math.floor( _positionTracker[ 0 ].length * 0.5 );
			var up:int = iterations - 1;
			var down:int = up;
			
			if( _positionTracker[ 0 ].length % 2 != 0 )
			{
				if( isEmpty( xNode, down ) ) return down;
				++down;
			}
			
			for( var i:int = 0; i < iterations; i++ )
			{
				if( isEmpty( xNode, up ) ) return up;
				if( isEmpty( xNode, down ) ) return down;
				up--;
				down++;
			}
			
			return -1;
		}
		
		private function isEmpty( x:int, y:int ) : Boolean
		{
			x = Math.min( _positionTracker.length - 1, x );
			y = Math.min( _positionTracker[ x ].length - 1, y );
			var output:Boolean = _positionTracker[ x ][ y ] == EMPTY;
			_positionTracker[ x ][ y ] = FULL;
			return output;
		}
		
		private function setDivisionWidth() : void
		{
			_yearDiv = _width / ( _numYears + 1 );
			_monthDiv = _yearDiv / 12;
			_dayDiv = _monthDiv / 31;
			_fullMonthDiv = _width / 12;
			_fullDayDiv = _fullMonthDiv / 31;
		}
	}
}