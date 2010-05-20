package ghostmonk.interactive.timeline.components.timeline
{
	import assets.category.TimelineDividerAsset;
	
	import com.ghostmonk.utils.GridMaker;
	
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

	public class TimelineDivider extends TimelineDividerAsset
	{
		private var _baseWidth:Number;
		private var _baseHeight:Number;
		
		public function TimelineDivider()
		{
			_baseWidth = width;
			_baseHeight = height;
			scaleY = 0;
		}
		
		public function get baseWidth() : Number 
		{
			return _baseWidth;
		}
		
		public function get baseHeight() : Number
		{
			return _baseHeight;
		}
		
		public function set viewHeight( value:Number ) : void
		{
			Animator.tween( this, { height:value, time:Tween.BASE_TIME } );
		}
		
		public function buildIn() : void
		{
			Animator.tween( this, Tween.SCALE_IN );
		}
		
		public function buildOut() : void
		{
			Animator.tween( this, Tween.SCALE_Y_OUT );
		}
	}
}