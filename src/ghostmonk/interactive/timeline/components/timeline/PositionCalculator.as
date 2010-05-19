package ghostmonk.interactive.timeline.components.timeline
{
	public class PositionCalculator
	{
		private var _numYears:int;
		private var _minYear:int;
		private var _width:int;
		private var _yearDiv:Number;
		private var _monthDiv:Number;
		
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
		
		public function yPos( date:Date ) : Number
		{
			var division:Number = date.fullYear - _minYear;
			var monthDiv:Number = _yearDiv / date.month;
			
			var day:int = date.date;
			return Math.round( division * _yearDiv );
		}
		
		private function setDivisionWidth() : void
		{
			_yearDiv = _width / ( _numYears + 1 );
			_monthDiv = _yearDiv / 12;
		}
	}
}