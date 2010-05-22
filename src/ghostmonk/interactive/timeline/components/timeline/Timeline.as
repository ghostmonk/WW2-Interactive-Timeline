package ghostmonk.interactive.timeline.components.timeline
{
	import assets.category.IconAsset;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import ghostmonk.interactive.timeline.components.ui.Icon;
	import ghostmonk.interactive.timeline.data.collections.Vetran;
	import ghostmonk.interactive.timeline.data.collections.VetranCollection;
	import ghostmonk.interactive.timeline.data.collections.WarEventCollection;
	import ghostmonk.interactive.timeline.data.collections.WarEventData;
	import ghostmonk.interactive.timeline.events.TimelineEvent;
	import ghostmonk.interactive.timeline.utils.Tween;
	
	[Event ( name="iconClick", type="ghostmonk.interactive.timeline.events.TimelineEvent")]
	
	public class Timeline extends Sprite
	{
		private static const PADDING:int = 30;
		private static const BUILDIN_DELAY:Number = 300;
		
		private var _divider:TimelineDivider;
		private var _header:CategoryHeader;
		private var _positionCalc:PositionCalculator;
		private var _visibleIcons:Array = [];
		private var _icons:Object = {};
		
		public function set divider( value:TimelineDivider ) : void
		{
			_divider = value;
			if( _header ) positionAssets();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		public function set header( value:CategoryHeader ) : void
		{
			_header = value;
			if( _divider ) positionAssets();
		}
		
		public function get header() : CategoryHeader
		{
			return _header;
		}
		
		public function set positionCalculator( value:PositionCalculator ) : void
		{
			_positionCalc = value;
		}
		
		public function buildIn() : void
		{
			_divider.buildIn();
			_header.enable();
		}
		
		public function buildOut() : void
		{
			_divider.buildOut();
			_header.disable();
		}
		
		public function removeAll() : void
		{
			_positionCalc.reset();
			for each( var icon:Icon in _visibleIcons )
				icon.buildOut();
			_visibleIcons = [];
		}
		
		public function showAll() : void
		{
			for each( var icon:Icon in _icons ) showIcon( icon.uid, true );
		}
		
		public function createWarEventIcons( value:WarEventCollection ) : void
		{
			for each( var eventData:WarEventData in value.totalList )
			{
				var label:String = eventData.date.toDateString().substr( 4 ) + " \n " + eventData.shortDescription;
				createMarker( eventData.guid, Icon.WAR_EVENT, label, eventData.date );
			}
			_positionCalc.setDimensions( _divider, _icons[ eventData.guid ] );
		}
		
		public function createVetranIcons( vetData:VetranCollection ) : void
		{
			for each( var data:Vetran in vetData.totalList )
			{
				var randDate:Date = data.dates[ Math.floor( data.dates.length * Math.random() ) ];		
				createMarker( data.id, Icon.VET, data.name, randDate );
			}
			_positionCalc.setDimensions( _divider, _icons[ data.id ] );
		}
		
		public function showIcon( id:String, isFullView:Boolean ) : void
		{
			var marker:Icon = _icons[ id ] as Icon;
			var point:Point = isFullView ? _positionCalc.fullViewPoint( marker.date ) : _positionCalc.yearViewPoint( marker.date ); 
			marker.view.x = point.x;
			marker.view.x  += _divider.x;
			marker.view.y = point.y;
			marker.labelDirection = getLabelDirection( marker.view.x, marker.view.y );
			addChild( marker.view );
			marker.buildIn();
			_visibleIcons.push( marker );
		}
		
		private function createMarker( id:String, type:String, label:String, date:Date ) : void
		{
			var marker:Icon = new Icon( new IconAsset(), type );
			marker.uid = id;
			marker.labelText = label;
			marker.date = date;
			marker.clickCallback = onMarkerClick;
			_icons[ id ] = marker;
		}
		
		private function getLabelDirection( xPos:Number, yPos:Number ) : int
		{
			var isTop:Boolean = yPos >= _divider.y + _divider.baseHeight * 0.5;
			var isLeft:Boolean = xPos >= _divider.x + _divider.baseWidth * 0.5;
			
			if( isTop && !isLeft ) return 1;
			if( !isTop && !isLeft ) return 2;
			if( !isTop && isLeft ) return 3;
			return 4;
		}
		
		private function onAddedToStage( e:Event ) : void
		{
			var timer:Timer = new Timer( Tween.BUILD_IN_DELAY * 1000, 1 )
			timer.addEventListener( TimerEvent.TIMER, 
				function( e:TimerEvent ) : void
				{
					buildIn();
					timer = null;
				}
			);
			timer.start();
		}
		
		private function positionAssets() : void
		{
			_header.y = ( _divider.baseHeight - _header.height ) * 0.5;
			_divider.x = _header.width + PADDING;
			addChild( _header );
			addChild( _divider );
		}
		
		private function onMarkerClick( id:String ) : void
		{
			dispatchEvent( new TimelineEvent( TimelineEvent.ICON_CLICK, id ) );
		}
	}
}