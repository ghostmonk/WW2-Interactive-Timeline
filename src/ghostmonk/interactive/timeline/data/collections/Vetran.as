package ghostmonk.interactive.timeline.data.collections
{
	public class Vetran
	{
		private var _name:String;
		private var _id:String;
		private var _dates:Array;
		
		public function Vetran( id:String, name:String )
		{
			_name = name;
			_id = id;
			_dates = [];
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