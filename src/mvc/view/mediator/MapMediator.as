package mvc.view.mediator
{
    import core.Api;
    import core.RequirementsModule;

    import event.GameEvent;

    import flash.events.MouseEvent;
    import flash.geom.Point;

    import lib.IsoTools;

    import mvc.model.CursorManager;
    import mvc.model.GridModel;
    import mvc.model.MapObjectModel;
    import mvc.model.definition.MapObjectDefinition;

    import org.robotlegs.mvcs.Mediator;

    import ui.MainView;
    import ui.MapView;

    public class MapMediator extends Mediator
    {
        [Inject]
        public var api:Api;

        [Inject]
        public var view:MapView;

        [Inject]
        public var grid:GridModel;

        [Inject]
        public var mainView:MainView;

        [Inject]
        public var requirements:RequirementsModule;

        [Inject]
        public var cursorManager:CursorManager;

        private var _mousePoint:Point;

        private var _phantomObjectDef:MapObjectDefinition;
        private var _phantomObjectIsoPosition:Point;

        private var _canDragMap:Boolean = true;

        override public function onRegister():void
        {
            view.buildLayout();

            eventMap.mapListener(grid.eventDispatcher, GameEvent.MAP_OBJECT_ADDED, onMapObjectAdded);
            eventMap.mapListener(api.eventDispatcher, GameEvent.CREATE_PHANTOM_OBJECT, createPhantomObject);
            eventMap.mapListener(api.eventDispatcher, GameEvent.REMOVE_PHANTOM_OBJECT, removePhantomObject);

            eventMap.mapListener(contextView, MouseEvent.MOUSE_UP, onMouseUp);
            eventMap.mapListener(contextView, MouseEvent.MOUSE_DOWN, onMouseDown);
            eventMap.mapListener(contextView, MouseEvent.MOUSE_MOVE, onMouseMove);
            eventMap.mapListener(contextView, MouseEvent.CLICK, onMouseClick);
        }

        private function onMapObjectAdded(e:GameEvent):void
        {
            var model:MapObjectModel = MapObjectModel(e.data);
            view.addMapObject(model);
            updatePhantomObject();
        }

        private function createPhantomObject(e:GameEvent):void
        {
            _phantomObjectDef = MapObjectDefinition(e.data);
            view.createPhantomObject(_phantomObjectDef.type);
            updatePhantomObject();
        }

        private function removePhantomObject(e:GameEvent):void
        {
            _phantomObjectDef = null;
            _phantomObjectIsoPosition = null;
            view.removePhantomObject();
        }

        private function updatePhantomObject():void
        {
            if (_phantomObjectDef)
            {
                var mapObjects:Vector.<MapObjectModel> = grid.getMapObjectsByType(_phantomObjectDef.type);
                view.phantomObject.updateLimit(mapObjects ? mapObjects.length : 0, _phantomObjectDef.limit)
            }
        }

        private function onMouseDown(e:MouseEvent):void
        {
            _mousePoint = new Point(e.stageX, e.stageY);
        }

        private function onMouseUp(e:MouseEvent):void
        {
            _mousePoint = null;
            _canDragMap = true;
        }

        private function onMouseMove(e:MouseEvent):void
        {
            if (_mousePoint)
            {
                var isoPoint:Point = getIsoPoint(e);
                var model:MapObjectModel = grid.getCell(isoPoint.x, isoPoint.y, true);

                if (model)
                    makeAction(model);
                else if (_canDragMap && !cursorManager.cropType)
                    moveIsoGrid(e.stageX, e.stageY);
            }

            else if (_phantomObjectDef)
                movePhantomObject(e);
        }

        private function onMouseClick(e:MouseEvent):void
        {
            if (_phantomObjectDef)
            {
                if (grid.isRegionClean(_phantomObjectIsoPosition.x, _phantomObjectIsoPosition.y, _phantomObjectDef.size))
                {
                    api.addMapObjectFromPhantom(_phantomObjectIsoPosition, _phantomObjectDef);

                    if (!requirements.checkLimit(_phantomObjectDef))
                    {
                        api.showNotification("Plot limit reached");
                        api.removePhantomObject();
                    }
                }
                else
                {
                    api.showNotification("Данное место занято");
                }
            }
            else
            {
                var isoPoint:Point = getIsoPoint(e);
                var model:MapObjectModel = grid.getCell(isoPoint.x, isoPoint.y, true);

                if (model)
                    makeAction(model);
                else
                {
                    cursorManager.removeSeedType();
                    api.eventDispatcher.dispatchEvent(new GameEvent(GameEvent.HIDE_CROP_MENU));
                }
            }
        }

        private function makeAction(model:MapObjectModel):void
        {
            _canDragMap = false;
            if (cursorManager.cropType)
                api.plant(cursorManager.cropType, model);
            else
                api.makeAction(model);
        }

        private function moveIsoGrid(stageX:Number, stageY:Number):void
        {
            mainView.mapView.x += (stageX - _mousePoint.x);
            mainView.mapView.y += (stageY - _mousePoint.y);

            // Не даём скролить карту дальше не видимой области
//            stage.x = Math.min(view.x, 0);
//            stage.x = Math.max(view.x, stage.stageWidth - view.width);
//            stage.y = Math.min(view.y, 0);
//            stage.y = Math.max(view.y, stage.stageHeight - view.height);

            _mousePoint.x = stageX;
            _mousePoint.y = stageY;
        }

        private function movePhantomObject(e:MouseEvent):void
        {
            _phantomObjectIsoPosition = getIsoPoint(e);
            var viewPoint:Point = IsoTools.isoToStage(_phantomObjectIsoPosition.x, _phantomObjectIsoPosition.y);
            view.phantomObject.x = viewPoint.x;
            view.phantomObject.y = viewPoint.y;
        }

        private function getIsoPoint(e:MouseEvent):Point
        {
            var viewPoint:Point = mainView.mapView.gridLayer.globalToLocal(new Point(e.stageX, e.stageY));
            return IsoTools.stageToIso(viewPoint.x, viewPoint.y);
        }
    }
}