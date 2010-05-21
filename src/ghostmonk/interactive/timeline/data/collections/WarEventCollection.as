package ghostmonk.interactive.timeline.data.collections
{
	import com.ghostmonk.utils.Iterator;
	
	public class WarEventCollection
	{
		private var _yearList:Array = [];
		private var _yearIDs:Array = [];
		private var _totalList:Array = [];
		private var _iterator:Iterator;
		private var _isValidIterator:Boolean = true;
		
		public function addEvent( value:WarEventData ) : void
		{
			var year:int = value.date.fullYear;
			if( !_yearList[ year ] ) _yearList[ year ] = [];
			
			_yearList[ year ].push( value );
			_totalList.push( value );
			
			_isValidIterator = false;
		}
		
		public function getDataByID( id:String ) : WarEventData
		{
			for each( var data:WarEventData in _totalList )
				if( data.guid == id ) return data;
				
			return null;
		}
		
		public function getListByYear( year:Number ) : Array
		{
			return _yearList[ year ];
		}
		
		public function getListByIDs( idList:Array ) : Array
		{
			var output:Array = [];
			for each( var eventID:String in idList )
			{
				output.push( getDataByID( eventID ) );
			}
			
			return output;
		}
		
		public function get totalList() : Array
		{
			return _totalList;
		}
		
		public function getIDsByYear( year:int ) : Array
		{
			var output:Array = _yearIDs[ year ];
			if( !output ) 
			{
				output = [];
				
				for each( var data:WarEventData in _yearList[ year ] )
					output.push( data.guid );
				
				_yearIDs[ output ];
			}
			
			return output;
		}
		
		public function get iterator() : Iterator
		{
			if( !_isValidIterator ) 
			{
				_iterator = new Iterator( _totalList ); 
				_isValidIterator = true;
			}
			return _iterator;
		}
	}
}