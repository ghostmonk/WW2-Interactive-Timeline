package ghostmonk.interactive.timeline.data
{
	import ghostmonk.interactive.timeline.data.collections.WarEventCollection;
	import ghostmonk.interactive.timeline.data.collections.WarEventData;
	import ghostmonk.interactive.timeline.data.collections.Vetran;
	import ghostmonk.interactive.timeline.data.collections.VetranCollection;
	
	public class TimelineData
	{
		private var _thumbLink:String;
		private var _vetProfileLink:String;
		private var _eventDataCollection:WarEventCollection;
		private var _vetrans:VetranCollection;
 		
		public function TimelineData( data:XML )
		{
			_vetrans = new VetranCollection();
			_thumbLink = data.links.smallThumb.@url.toString();
			_vetProfileLink = data.links.vetProfile.@url.toString();
			
			_eventDataCollection = getEventData( data.events.event );
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
		
		public function get eventCollection() : WarEventCollection
		{
			return _eventDataCollection;
		}
		
		public function get vetranCollection() : VetranCollection
		{
			return _vetrans;
		}
		
		public function getVetranName( id:String ) : String
		{
			return _vetrans.getVetranByID( id ).name;
		}
		
		private function getEventData( list:XMLList ) : WarEventCollection
		{
			var output:WarEventCollection = new WarEventCollection();
			
			for each( var rawData:XML in list ) 
			{
				var eventData:WarEventData = new WarEventData();
				eventData.img = rawData.@img.toString();
				eventData.shortDescription = rawData.shortDesc;
				eventData.title = rawData.title;
				eventData.text = rawData.text.toString();
				eventData.vetIDs = getVetIDs( rawData.vet );
				addVetrans( rawData.vet, eventData.guid );
				var dateArray:Array = rawData.@date.toString().split( "/" );
				eventData.date = new Date( int( dateArray[ 2 ] ), int( dateArray[ 1 ] ), int( dateArray[ 0 ] ) );
				output.addEvent( eventData );
			}
			return output;
		}
		
		private function getVetIDs( list:XMLList ) : Array
		{
			var output:Array = [];
			for each( var vet:XML in list ) 
				output.push( vet.@id.toString() );
			return output;
		}
		
		private function addVetrans( list:XMLList, warEventID:String ) : void
		{	
			for each( var vetData:XML in list )
			{
				var vet:Vetran = _vetrans.createVetran( vetData.@id.toString(), vetData.toString() );
				vet.addWarEventID( warEventID );
				var dateArray:Array = vetData.parent().@date.toString().split( "/" );
				vet.addDate( new Date( int( dateArray[ 2 ] ), int( dateArray[ 1 ] ), int( dateArray[ 0 ] ) ) );
			}
		}
	}
}