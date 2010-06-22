package ghostmonk.interactive.timeline.data
{
	import ghostmonk.interactive.timeline.data.collections.Vetran;
	import ghostmonk.interactive.timeline.data.collections.VetranCollection;
	import ghostmonk.interactive.timeline.data.collections.WarEventCollection;
	import ghostmonk.interactive.timeline.data.collections.WarEventData;
	
	public class TimelineData
	{
		private var _thumbLink:String;
		private var _vetProfileLink:String;
		private var _eventDataCollection:WarEventCollection;
		private var _vetEventCollection:WarEventCollection;
		private var _vetrans:VetranCollection;
 		
		public function TimelineData( data:XML )
		{
			_vetrans = new VetranCollection();
			_thumbLink = data.links.smallThumb.@url.toString();
			_vetProfileLink = data.links.vetProfile.@url.toString();
			
			_vetEventCollection = getEventData( data.veterans.veteran, true );
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
		
		public function get vetEventCollection() : WarEventCollection
		{
			return _vetEventCollection;
		}
		
		public function get vetranCollection() : VetranCollection
		{
			return _vetrans;
		}
		
		public function getVetranName( id:String ) : String
		{
			return _vetrans.getVetranByID( id ).name;
		}
		
		private function getEventData( list:XMLList, isVeteran:Boolean = false ) : WarEventCollection
		{
			var output:WarEventCollection = new WarEventCollection();
			
			for each( var rawData:XML in list ) 
			{
				var eventData:WarEventData = new WarEventData();
				eventData.img = rawData.@img.toString();
				eventData.shortDescription = rawData.shortDesc;
				eventData.title = isVeteran ? rawData.vet[0].toString() : rawData.title;
				eventData.text = rawData.text.toString();
				eventData.vetIDs = getVetIDs( rawData.vet );
				addVetrans( rawData.vet, eventData.guid );
				eventData.date = getDate( rawData.@date.toString() );
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
				vet.addDate( getDate( vetData.parent().@date.toString() ) );
			}
		}
		
		private function getDate( dateString:String ) : Date
		{
			if( dateString.length != 10 ) trace( dateString );
			var dateArray:Array = dateString.split( "/" );
			return new Date( int( dateArray[ 2 ] ), int( dateArray[ 1 ] ) - 1, int( dateArray[ 0 ] ) )
		}
	}
}