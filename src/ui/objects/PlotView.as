package ui.objects
{
    import core.Manifest;

    import event.GameEvent;

    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;

    import mvc.model.MapObjectModel;

    public class PlotView extends MapObjectView
    {
        private var _viewState:DisplayObjectContainer;

        public function PlotView(model:MapObjectModel)
        {
            super(model);

            _viewState = new Sprite();
            _viewState.x -= AppSettings.CELL_WIDTH;

            addChild(_viewState);
        }

        public function setIdleState():void
        {
            _viewState.removeChildren();
        }

        public function setWaterState():void
        {
            setState(0);
        }

        public function setStartGrowState():void
        {
            setState(1);
        }

        public function setMiddleGrowState():void
        {
            setState(2);
        }

        public function setReadyState():void
        {
            setState(3);
        }

        private function setState(index:int):void
        {
            _viewState.removeChildren();
            var asset:AssetSprite = new AssetSprite(Manifest.CROP[model.cropType].states[index]);
            asset.addEventListener(GameEvent.VIEW_READY, buildLayout);
            _viewState.addChild(asset);
            buildLayout();
        }

        private function buildLayout(e:GameEvent = null):void
        {
            _viewState.x = -_viewState.width * .5;
            _viewState.y = AppSettings.CELL_WIDTH - _viewState.height - 15;
        }
    }
}
