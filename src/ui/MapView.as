package ui
{
    import core.DefinitionManager;
    import core.Manifest;

    import event.GameEvent;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;

    import lib.IsoTools;

    import mvc.model.MapObjectModel;

    import ui.objects.AssetSprite;
    import ui.objects.MapObjectView;
    import ui.objects.PhantomObjectView;
    import ui.objects.PlotView;

    public class MapView extends Sprite
    {
        private var _viewList:Vector.<MapObjectView>;
        private var _gridLayer:DisplayObjectContainer;
        private var _overGgridLayer:DisplayObjectContainer;
        private var _debugLayer:DisplayObjectContainer;

        private var _phantomObject:PhantomObjectView;


        public function MapView()
        {
            // bg
            var bgView:AssetSprite = new AssetSprite(Manifest.BG);
            bgView.addEventListener(GameEvent.VIEW_READY, centerPosition);
            addChild(bgView);

            // debug
            _debugLayer = new Sprite();
            _debugLayer.x = AppSettings.GRID_ORIGIN_POINT.x;
            _debugLayer.y = AppSettings.GRID_ORIGIN_POINT.y;
            addChild(_debugLayer);

            // iso view
            _gridLayer = new Sprite();
            _gridLayer.x = AppSettings.GRID_ORIGIN_POINT.x;
            _gridLayer.y = AppSettings.GRID_ORIGIN_POINT.y;
            addChild(_gridLayer);

            _overGgridLayer = new Sprite();
            _overGgridLayer.x = AppSettings.GRID_ORIGIN_POINT.x;
            _overGgridLayer.y = AppSettings.GRID_ORIGIN_POINT.y;
            addChild(_overGgridLayer);

            // seed menu
            addChild(new SeedMenuView());

            _viewList = new <MapObjectView>[];
        }

        public function get gridLayer():DisplayObject
        {
            return _gridLayer;
        }

        private function centerPosition(e:Event):void
        {
            var asset:AssetSprite = AssetSprite(e.target);
            asset.removeEventListener(GameEvent.VIEW_READY, centerPosition);
            this.x -= asset.width * .5;
            this.y -= asset.height * .5;
        }

        public function addMapObject(model:MapObjectModel):void
        {
            var view:MapObjectView = getView(model);
            var viewPos:Point = IsoTools.isoToStage(model.isoX, model.isoY);
            view.x = viewPos.x;
            view.y = viewPos.y;

            _viewList.push(view);
            _viewList.sort(sortByIsoDepth);

            for each (var view:MapObjectView in _viewList)
                _gridLayer.addChild(view);
        }

        private function sortByIsoDepth(a:MapObjectView, b:MapObjectView):int
        {
            if (a.model.isoDepth > b.model.isoDepth)
                return 1;
            else if (a.model.isoDepth < b.model.isoDepth)
                return -1;
            return 0;
        }

        private function getView(model:MapObjectModel):MapObjectView
        {
            if (model.def.type == DefinitionManager.MAP_OBJECT_PLOT)
                return new PlotView(model);

            return new MapObjectView(model);
        }

        public function get phantomObject():PhantomObjectView
        {
            return _phantomObject;
        }

        public function createPhantomObject(objectType:String):void
        {
            _phantomObject = new PhantomObjectView(objectType);
            _overGgridLayer.addChild(_phantomObject);
        }

        public function removePhantomObject():void
        {
            _phantomObject.destroy();
            _overGgridLayer.removeChild(_phantomObject);
            _phantomObject = null;
        }

        public function buildLayout():void
        {
            for (var i:int = 0; i < AppSettings.GRID_SIZE; i++)
            {
                var isoPoint:Point = IsoTools.getIsoPoint(i);
                var cellTile:CellTile = new CellTile(isoPoint.x, isoPoint.y);
                _debugLayer.addChild(cellTile);

                cellTile.showDebugView();
            }
        }
    }
}
