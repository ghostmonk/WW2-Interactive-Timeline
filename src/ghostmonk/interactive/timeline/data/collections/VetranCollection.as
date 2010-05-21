package ghostmonk.interactive.timeline.data.collections
{
	import com.ghostmonk.utils.Iterator;
	import com.ghostmonk.utils.ObjectFuncs;
	
	public class VetranCollection
	{
		private var _vetTable:Object = {};
		private var _yearIDs:Array = [];
		private var _isValidIterator:Boolean = true;
		private var _iterator:Iterator;
		
		public function addVetran( value:Vetran ) : void
		{
			_isValidIterator = false;
			_vetTable[ value.id ] = value;
		}
		
		public function createVetran( id:String, name:String ) : Vetran
		{
			if( getVetranByID( id ) == null ) addVetran( new Vetran( id, name ) );
			return getVetranByID( id );
		}
		
		public function getVetranByID( id:String ) : Vetran
		{
			return _vetTable[ id ];
		}
		
		public function getIDsByYear( year:int ) : Array
		{
			var output:Array = _yearIDs[ year ];
			if( !output ) 
			{
				output = [];
				
				for each( var data:Vetran in _vetTable )
					for each( var date:Date in data.dates )
						if( date.fullYear == year ) output.push( data.id ) ;
				
				_yearIDs[ output ];
			}
			
			return output;
		}
		
		public function get totalList() : Array
		{
			return ObjectFuncs.toArray( _vetTable );
		}
		
		public function get iterator() : Iterator
		{
			if( !_isValidIterator ) 
			{
				_iterator = new Iterator( ObjectFuncs.toArray( _vetTable ) ); 
				_isValidIterator = true;
			}
			return _iterator;
		}
	}
}