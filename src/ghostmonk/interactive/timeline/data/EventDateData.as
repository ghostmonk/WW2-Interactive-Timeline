package ghostmonk.interactive.timeline.data
{
	public class EventDateData
	{
		private var _vetrans:Array;
		private var _date:Date;
		private var _text:String;
		private var _imgID:String;
		
		public function set date( value:Date ) : void
		{
			_date = value;
		}
		
		public function get formattedDate() : String
		{
			return _date.toDateString();
		}
		
		public function set text( value:String ) : void
		{
			_text = value;
		}
		
		public function get text() : String
		{
			return _text;
		}
		
		public function set imgID( value:String ) : void
		{
			_imgID = value;
		}
		
		public function get imgID() : String
		{
			return _imgID;
		}
		
		public function set vetrans( value:Array ) : void
		{
			_vetrans = value;
		}
		
		public function get vetrans() : Array
		{
			return _vetrans;
		}
		
		public function toString() : String
		{
			return "Vetrans: " + _vetrans + "\n" +
					"Date: " + _date.toLocaleDateString() + "\n" +
					"IMG ID: " + _imgID + "\n" +
					"Text: " + _text;
		}
	}
}