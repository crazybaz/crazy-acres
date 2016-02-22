package ui
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;

    public class MainView extends Sprite
    {
        private var _mapView:MapView;
        private var _cursorLayer:DisplayObjectContainer;

        public function MainView()
        {
        }

        public function get mapView():MapView
        {
            return _mapView;
        }

        public function get cursorLayer():DisplayObjectContainer
        {
            return _cursorLayer;
        }

        public function buildLayout():void
        {
            _mapView = new MapView();
            addChild(_mapView);
            addChild(new ScreenPanel());
            addChild(new NotificationView);
            _cursorLayer = new Sprite();
            addChild(_cursorLayer);
        }
    }
}
