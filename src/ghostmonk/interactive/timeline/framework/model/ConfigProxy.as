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
		
		public function get allString() : String
		{
			return config.allString;
		}
	}
}