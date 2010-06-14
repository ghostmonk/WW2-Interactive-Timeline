package ghostmonk.interactive.timeline.data.collections
{
	public class Vetran
	{
		private var _name:String;
		private var _id:String;
		private var _dates:Array;
		private var _warEventIDs:Array;
		private var _seedDate:Date;
		
		public function Vetran( id:String, name:String )
		{
			_name = name;
			_id = id;
			_dates = [];
			_warEventIDs = [];
		}
		
		public function get seedDate() : Date
		{
			return _seedDate;
		}
		
		public function get warEventIDs() : Array
		{
			return _warEventIDs;
		}
		
		public function get name() : String
		{
			return _name;
		}
		
		public function get id() : String
		{
			return _id;
		}
		
		public function get dates() : Array
		{
			return _dates;
		}
		
		public function get randomDate() : Date
		{
			_seedDate = _dates[ Math.floor( _dates.length * Math.random() ) ] as Date;
			return _seedDate;
		}
		
		public function getRandDateByYear( year:int ) : Date
		{
			var targetYears:Array = [];
			for each( var date:Date in _dates )
			{
				if( date.fullYear == year ) targetYears.push( date );
			} 
			
			if( targetYears.length == 0 ) return null;
			
			
			return targetYears[ Math.floor( Math.random() * targetYears.length ) ] as Date;;
		}
		
		public function addWarEventID( value:String ) : void
		{
			_warEventIDs.push( value );
		}
		
		public function addDate( date:Date ) : void
		{
			var insert:Boolean = true;
			
			for each( var dateInfo:Date in _dates )
				insert = dateInfo.toDateString() != date.toDateString();
				
			if( insert ) _dates.push( date );
		}
		
		public function toString() : String
		{
			return "Name: " + _name + " ID: " + _id + " Dates: " + getDatesAsString()
		}
		
		private function getDatesAsString() : String
		{
			var output:String = "";
			for each( var date:Date in _dates ) 
				output += date.fullYear + "/" + date.month + "/" +date.date + ", ";
			return output
		}
	}
}