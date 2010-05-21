package ghostmonk.interactive.timeline.components.timeline
{
	public class PositionCalculator
	{
		private static const CORRECTION:Number = 0;
		
		private var _numYears:int;
		private var _minYear:int;
		private var _width:int;
		private var _yearDiv:Number;
		private var _monthDiv:Number;
		private var _dayDiv:Number;
		
		private var _fullMonthDiv:Number;
		private var _fullDayDiv:Number;
		
		public function set graphWidth( value:Number ) : void
		{
			_width = value;
			if( _width ) setDivisionWidth();
		}
		
		public function setDateRange( minYear:int, maxYear:int ) : void
		{
			_minYear = minYear;
			_numYears = maxYear - minYear;
			if( _width ) setDivisionWidth();
		}
		
		public function fullViewX( date:Date ) : Number
		{
			var yearValue:Number = _yearDiv * ( date.fullYear - _minYear );
			var monthValue:Number = _monthDiv * ( date.month - 1 );
			var dayValue:Number = _dayDiv * ( date.date );
			
			var output:int = Math.floor( yearValue + monthValue + dayValue );
			
			return output + CORRECTION;
		}
		
		public function yearViewX( date:Date ) : Number
		{
			var monthValue:Number = _fullMonthDiv * ( date.month );
			var dayValue:Number = _fullDayDiv * ( date.date );
			
			var output:Number = monthValue + dayValue;
			
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