package ghostmonk.interactive.timeline.components.ui
{
	import assets.category.IconLabelAsset;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextFieldAutoSize;
	
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;

	public class IconLabel extends IconLabelAsset
	{
		private var _parent:DisplayObjectContainer;
		private var _labelWidth:Number;
		private var _dir:int;
		
		public function IconLabel( parent:DisplayObjectContainer )
		{
			_parent = parent;
			field.autoSize = TextFieldAutoSize.LEFT;
			_dir = 1;
		}
		
		public function set direction( value:int ) : void
		{
			_dir = value;
		}
		
		public function set text( value:String ) : void
		{
			field.text = value;
			if( field.numLines == 1 ) 
			{
				field.autoSize = TextFieldAutoSize.LEFT;
				field.multiline = false;
				field.wordWrap = false;
				field.text = value;
			}
			_labelWidth = field.width + 10;
			bg.height = field.height;
			position();
		}
		
		public function buildIn() : void
		{
			position();
			bg.scaleX = 0;
			field.alpha = 0;
			Animator.delay = 0.25;
			
			if( _dir > 2 ) 
			{
				var dest:Number = x;
				x = 0;
				Animator.tween( this, { time:Tween.BASE_TIME, x:dest }, false );
			}
			
			Animator.tween( bg, { time:Tween.BASE_TIME, width:_labelWidth }, false );
			Animator.tween( field, Tween.ALPHA_IN );
			_parent.addChild( this );
		}
		
		public function buildOut() : void
		{
			Animator.destroyTweens( bg );
			Animator.destroyTweens( field );
			_parent.removeChild( this );
		}
		
		private function position() : void
		{
			x = _dir <= 2 ? _parent.width + 3 : -( _labelWidth + 3 );
			y = ( _dir == 2 || _dir == 3 ) ? _parent.height + 3 : - ( height + 3 );
		}
	}
}