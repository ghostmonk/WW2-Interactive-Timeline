package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import ghostmonk.interactive.timeline.AppFacade;
	import ghostmonk.interactive.timeline.data.BootStrapData;
	import ghostmonk.interactive.timeline.utils.Animator;
	
	[SWF ( backgroundColor=0x000000, frameRate=31, width=850, height=550, pageTitle="World War II Timeline" ) ]
	[Frame ( factoryClass="ghostmonk.interactive.timeline.TimelineLoader" ) ]

	public class WW2Timeline extends MovieClip
	{
		public function WW2Timeline() 
		{
			Animator.init();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			new AppFacade().bootStrap( new BootStrapData( stage, root.loaderInfo.parameters.configURL || "data/local_en.xml" ) );
		}
	}
}