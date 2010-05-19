package ghostmonk.interactive.timeline.components.timeline
{
	import assets.category.HeaderAsset;
	
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

	public class CategoryHeader extends HeaderAsset
	{
		public function CategoryHeader()
		{
			image.stop();
			alpha = 0;
		}
		
		public function disable() : void
		{
			Animator.tween( this, { alpha:0.3, time:Tween.BASE_TIME } );
		}
		
		public function enable() : void
		{
			Animator.tween( this, Tween.ALPHA_IN );
		}
	}
}