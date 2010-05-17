package ghostmonk.interactive.timeline.data
{
	public class TimelineData
	{
		private var _thumbLink:String;
		private var _vetProfileLink:String;
		private var _eventDataCollection:Array;
		private var _vetrans:Object;
 		
		public function TimelineData( data:XML )
		{
			_thumbLink = data.links.smallThumb.@url.toString();
			_vetProfileLink = data.links.vetProfile.@url.toString();
			
			_eventDataCollection = getEventData( data.events.event );
			_vetrans = getVetrans( data.vetrans.vet );
			data = null;
		}
		
		public function get thumbLink() : String
		{
			return _thumbLink;
		}
		
		public function get vetProfileLink() : String
		{
			return _vetProfileLink;
		}
		
		public function get eventCollection() : Array
		{
			return _eventDataCollection;
		}
		
		public function getVetranName( id:String ) : String
		{
			return _vetrans[ id ];
		}
		
		private function getEventData( list:XMLList ) : Array
		{
			var output:Array = [];
			
			for each( var rawData:XML in list ) 
			{
				var eventData:EventDateData = new EventDateData();
				eventData.imgID = rawData.@imgID.toString();
				eventData.text = rawData.text.toString();
				eventData.vetrans = rawData.vets.toString().split( " " );
				var dateArray:Array = rawData.@date.toString().split( "-" );
				eventData.date = new Date( int( dateArray[ 0 ] ), int( dateArray[ 1 ] ), int( dateArray[ 2 ] ) );
				output.push( eventData );
			}
			
			return output;
		}
		
		private function getVetrans( list:XMLList ) : Object
		{
			var output:Object = {};
			
			for each( var vet:XML in list )
			{
				output[ vet.@id.toString() ] = vet.toString();
			}
			
			return output;
		}
	}
}