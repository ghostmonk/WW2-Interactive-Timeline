package ghostmonk.interactive.timeline.framework.model
{
	import ghostmonk.interactive.timeline.data.ConfigData;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class ConfigProxy extends Proxy
	{
		public static const NAME:String = "ConfigProxy";
		
		public function ConfigProxy( data:ConfigData )
		{
			super( NAME, data );
		}
		
		public function get config() : ConfigData
		{
			return data as ConfigData;
		}
		
		public function get vetransTitle() : String
		{
			return config.vetransTitle;
		}
		
		public function get timelineDataURL() : String 
		{
			return config.timelineDataURL;
		}
		
		public function get mainTitle() : String
		{
			return config.mainTitle;
		}
		
		public function get categories() : Array
		{
			 return config.categories;
		}
		
		public function get months() : Array 
		{
			return config.months;
		}
		
		public function get years() : Array 
		{
			return config.years;
		}
	}
}