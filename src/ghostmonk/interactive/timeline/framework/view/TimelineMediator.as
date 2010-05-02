package ghostmonk.interactive.timeline.framework.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class TimelineMediator extends Mediator
	{
		public static const NAME:String = "CategoryMediator";
		
		public function TimelineMediator()
		{
			super( NAME );
		}
		
	}
}