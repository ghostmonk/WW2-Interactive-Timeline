package ghostmonk.interactive.timeline.components.timeline
{
	import assets.category.TimelineDividerAsset;
	
	import ghostmonk.interactive.timeline.utils.Animation;

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
			Animation.tween( this, { height:value, time:Animation.BASIC_TIME } );
		}
		
		public function buildIn() : void
		{
			Animation.tween( this, Animation.SCALE_IN );
		}
		
		public function buildOut() : void
		{
			Animation.tween( this, Animation.SCALE_Y_OUT );
		}
	}
}