package ghostmonk.interactive.timeline.data
{
	import flash.display.Stage;
	
	public class BootStrapData
	{
		private var _stage:Stage;
		private var _configURL:String;
		
		public function BootStrapData( stage:Stage, configURL:String )
		{
			_stage = stage;
			_configURL = configURL;
		}
		
		public function get stage() : Stage
		{
			return _stage;
		}
		
		public function get congfigURL() : String 
		{
			return _configURL;
		}
	}
}