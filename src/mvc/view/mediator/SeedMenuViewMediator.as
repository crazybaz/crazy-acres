package mvc.view.mediator
{
    import core.Api;
    import core.DefinitionManager;

    import event.GameEvent;

    import flash.events.MouseEvent;
    import flash.geom.Point;

    import lib.IsoTools;

    import mvc.model.CursorManager;
    import mvc.model.MapObjectModel;

    import org.robotlegs.mvcs.Mediator;

    import ui.MainView;
    import ui.SeedMenuView;

    public class SeedMenuViewMediator extends Mediator
    {
        [Inject]
        public var api:Api;

        [Inject]
        public var view:SeedMenuView;

        [Inject]
        public var mainView:MainView;

        [Inject]
        public var cursorManager:CursorManager;

        private var _selectedModel:MapObjectModel;

        override public function onRegister():void
        {
            eventMap.mapListener(api.eventDispatcher, GameEvent.SHOW_CROP_MENU, showCropMenu);
            eventMap.mapListener(api.eventDispatcher, GameEvent.HIDE_CROP_MENU, hideCropMenu);
            eventMap.mapListener(view.tomatoSeedButton, MouseEvent.CLICK, onTomatoClick);
            eventMap.mapListener(view.pumpkinSeedButton, MouseEvent.CLICK, onPumpkinClick);
        }

        private function showCropMenu(e:GameEvent):void
        {
            _selectedModel = MapObjectModel(e.data);
            var point:Point = IsoTools.isoToStage(_selectedModel.isoX, _selectedModel.isoY);

            //var globalPoint:Point = mainView.mapView.localToGlobal(point);
            //var localPoint:Point = view.parent.globalToLocal(globalPoint);

            view.x = AppSettings.GRID_ORIGIN_POINT.x + point.x - view.width * .5;
            view.y = AppSettings.GRID_ORIGIN_POINT.y + point.y + AppSettings.CELL_WIDTH;
            view.visible = true;
        }

        private function hideCropMenu(e:GameEvent = null):void
        {
            view.visible = false;
        }

        private function onTomatoClick(e:MouseEvent):void
        {
            e.stopImmediatePropagation();
            api.plant(DefinitionManager.SEED_TYPE_TOMATO, _selectedModel);
            //_selectedModel.dispatchEvent(new GameEvent(GameEvent.START_SEED, DefinitionManager.SEED_TYPE_TOMATO));
            cursorManager.setSeedType(DefinitionManager.SEED_TYPE_TOMATO, new Point(e.stageX, e.stageY));
            hideCropMenu();
        }

        private function onPumpkinClick(e:MouseEvent):void
        {
            e.stopImmediatePropagation();
            api.plant(DefinitionManager.SEED_TYPE_PUMPKIN, _selectedModel);
            //_selectedModel.dispatchEvent(new GameEvent(GameEvent.START_SEED, DefinitionManager.SEED_TYPE_PUMPKIN));
            cursorManager.setSeedType(DefinitionManager.SEED_TYPE_PUMPKIN, new Point(e.stageX, e.stageY));
            hideCropMenu();
        }
    }
}
