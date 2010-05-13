package ghostmonk.interactive.timeline.data
{
	import com.ghostmonk.utils.XMLUtils;
	
	public class ConfigData
	{
		private var _data:XML;
		
		public function ConfigData( data:XML )
		{
			_data = data;
		}
		
		public function get timelineDataURL() : String 
		{
			return _data.timelineData.toString();
		}
		
		public function get mainTitle() : String
		{
			return _data.mainTitle.toString();
		}
		
		public function get categories() : Array
		{
			 return XMLUtils.XMLListToArray( _data.categories.category );
		}
		
		public function get months() : Array 
		{
			return _data.months.toString().split( " " );
		}
		
		public function get years() : Array 
		{
			return _data.years.toString().split( " " );
		}
	}
}