package ghostmonk.interactive.timeline.components.timeline
{
	import assets.category.HeaderAsset;
	
	import ghostmonk.interactive.timeline.utils.Animation;

	public class CategoryHeader extends HeaderAsset
	{
		public function CategoryHeader()
		{
			image.stop();
			alpha = 0;
		}
		
		public function disable() : void
		{
			Animation.tween( this, { alpha:0.3, time:Animation.BASIC_TIME } );
		}
		
		public function enable() : void
		{
			Animation.tween( this, Animation.ALPHA_IN );
		}
	}
}