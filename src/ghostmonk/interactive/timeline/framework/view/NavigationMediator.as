
package ghostmonk.interactive.timeline.framework.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class NavigationMediator extends Mediator
	{
		public static const NAME:String = "TimelineMediator";
		
		public function NavigationMediator()
		{
			super( NAME );
		}
		
	}
}