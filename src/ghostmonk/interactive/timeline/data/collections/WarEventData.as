package ghostmonk.interactive.timeline.data.collections
{
	import com.ghostmonk.utils.Guid;
	
	public class WarEventData
	{
		private var _vetIDs:Array;
		private var _date:Date;
		private var _text:String;
		private var _title:String;
		private var _shortDesc:String;
		private var _imgID:String;
		private var _guid:String;
		
		public function WarEventData()
		{
			_guid = Guid.create( Math.random().toString() );
		}
		
		public function get guid() : String
		{
			return _guid;
		}
		
		public function set date( value:Date ) : void
		{
			_date = value;
		}
		
		public function get date() : Date
		{
			return _date;
		}
		
		public function get formattedDate() : String
		{
			return _date.toDateString();
		}
		
		public function set title( value:String ) : void
		{
			_title = value;
		}
		
		public function get title() : String
		{
			return _title;
		}
		
		public function set shortDescription( value:String ) : void
		{
			_shortDesc = value;
		}
		
		public function get shortDescription() : String
		{
			var output:String = _shortDesc ? _shortDesc : _text.substr( 0, 50 )+ "...";
			return output;
		}
		
		public function set text( value:String ) : void
		{
			_text = value;
		}
		
		public function get text() : String
		{
			return _text;
		}
		
		public function set img( value:String ) : void
		{
			_imgID = value;
		}
		
		public function get img() : String
		{
			return _imgID;
		}
		
		public function set vetIDs( value:Array ) : void
		{
			_vetIDs = value;
		}
		
		public function get vetIDs() : Array
		{
			return _vetIDs;
		}
		
		public function toString() : String
		{
			return "Vetrans: " + _vetIDs + "\n" +
					"Date: " + _date.toLocaleDateString() + "\n" +
					"IMG ID: " + _imgID + "\n" +
					"Text: " + _text;
		}
	}
}