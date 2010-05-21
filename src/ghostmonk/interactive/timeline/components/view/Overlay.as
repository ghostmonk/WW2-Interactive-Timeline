package ghostmonk.interactive.timeline.components.view
{
	import assets.view.OverlayAsset;
	
	import com.ghostmonk.net.AssetLoader;
	import com.ghostmonk.ui.RotatingBufferIcon;
	import com.ghostmonk.ui.graveyard.buttons.SimpleMovieClipButton;
	import com.ghostmonk.utils.StringUtils;
	
	import flash.display.Bitmap;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.system.LoaderContext;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	
	import ghostmonk.interactive.timeline.data.collections.Vetran;
	import ghostmonk.interactive.timeline.data.collections.WarEventData;
	import ghostmonk.interactive.timeline.events.OverlayEvent;
	import ghostmonk.interactive.timeline.utils.Animator;
	import ghostmonk.interactive.timeline.utils.Tween;
	
	[Event (name="close", type="ghostmonk.interactive.timeline.events.OverlayEvent")]

	public class Overlay extends OverlayAsset
	{
		private static const IMG_HEIGHT:Number = 145;
		private static const PADDING:Number = 10;
		private var _closeBtn:SimpleMovieClipButton;
		private var _rotatingBuffer:RotatingBufferIcon;
		private var _currentBitmap:Bitmap;
		private var _vetsTitle:String;
		private var _vetLink:String;
		private var _imgLink:String;
		
		public function Overlay()
		{
			super();
			bg.alpha = 0.9;
			_closeBtn = new SimpleMovieClipButton( closeButton, onClick );
			alpha = 0;
			_rotatingBuffer = new RotatingBufferIcon( 0x2E3A76 );

			bodyField.styleSheet = new StyleSheet();
			bodyField.styleSheet.setStyle( "a:link", { color:"#5870e3", textDecoration:"none" } );
			bodyField.styleSheet.setStyle( "a:hover", { textDecoration:"underline" } );
		}
		
		public function set vetransTitle( value:String ) : void
		{
			_vetsTitle = value;
		}
		
		public function set imgLink( value:String ) : void
		{
			_imgLink = value;
		}
		
		public function set vetLink( value:String ) : void
		{
			_vetLink = value;	
		}
		
		public function buildIn() : void
		{
			failedImg.visible = false;
			Animator.tween( this, Tween.ALPHA_IN );
		}
		
		public function buildOut() : void
		{
			Animator.setCallback( parent.removeChild, [ this ] );
			Animator.tween( this, Tween.ALPHA_OUT );	
		}
		
		public function setContent( data:WarEventData, vetrans:Array, vetName:String = null ) : void
		{
			titleText = vetName ? vetName : data.title;
			var bodyContent:String = data.text.substr( 0, 1 ).toUpperCase() + data.text.substr( 1 );
			bodyText( data.date.toDateString() + "\n" + bodyContent, vetrans );
			loadImg( _imgLink + data.img );
		}
		
		private function set titleText( value:String ) : void
		{
			title.autoSize = TextFieldAutoSize.CENTER;
			title.visible = value != null && value != "";
			title.text = value;
		}
		
		private function bodyText( value:String, vetrans:Array ) : void
		{
			var vetLinks:String = "\n" + _vetsTitle + "\n";
			for each( var vet:Vetran in vetrans )
				vetLinks += "<a href='" + _vetLink + vet.id + "' target='_blank'>" + vet.name + "</a>, ";
			vetLinks = StringUtils.trimEnd( vetLinks, ", " );
			
			bodyField.autoSize = TextFieldAutoSize.LEFT;
			bodyField.htmlText = value + "\n" + vetLinks;
			var fieldHeight:Number = bodyField.height;
			bodyField.autoSize = TextFieldAutoSize.NONE;
			bodyField.height = fieldHeight + 2;
			bg.height = getContentHeight();
			bodyField.y = bg.height - bodyField.height - PADDING;
		}
		
		private function loadImg( src:String ) : void
		{
			if( _currentBitmap ) 
			{
				removeChild( _currentBitmap );
				_currentBitmap.bitmapData.dispose();
				_currentBitmap = null;
			}
			failedImg.visible = false;
			_rotatingBuffer.x = ( width - _rotatingBuffer.width ) * 0.5;
			var titleHeight:Number = title.visible ? title.height + PADDING : 0;
			_rotatingBuffer.y = ( ( PADDING * 2 + IMG_HEIGHT + titleHeight ) - _rotatingBuffer.height ) * 0.5;
			var loader:AssetLoader = new AssetLoader( src, onImgLoaded, onLoadFail, null, new LoaderContext( true ) );
			addChild( _rotatingBuffer );
			_rotatingBuffer.buildIn();
		}
		
		private function onClick( e:MouseEvent ) : void
		{
			dispatchEvent( new OverlayEvent( OverlayEvent.CLOSE ) );
		}
		
		private function onLoadFail( e:IOErrorEvent ) : void
		{
			_rotatingBuffer.buildOut();
			failedImg.visible = true;
			failedImg.alpha = 0;
			Animator.tween( failedImg, Tween.ALPHA_IN );
		}
		
		private function onImgLoaded( bitmap:Bitmap ) : void
		{
			addChild( bitmap );
			_currentBitmap = bitmap;
			_currentBitmap.alpha = 0;
			Animator.tween( _currentBitmap, Tween.ALPHA_IN );
			_rotatingBuffer.buildOut();
			_currentBitmap.x = ( width - _currentBitmap.width ) * 0.5;
			_currentBitmap.y = ( IMG_HEIGHT - _currentBitmap.height ) * 0.5 + PADDING;
			if( title.visible ) _currentBitmap.y += title.height + PADDING;
		}
		
		private function getContentHeight() : Number
		{
			var output:Number = PADDING;
			output += ( IMG_HEIGHT + PADDING );
			output += bodyField.height + PADDING;
			if( title.visible ) output += title.height + PADDING;
			return output;
		}
	}
}