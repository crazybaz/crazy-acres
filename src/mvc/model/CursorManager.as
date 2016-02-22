package mvc.model
{
    import core.Manifest;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import org.robotlegs.mvcs.Actor;

    import ui.MainView;
    import ui.objects.AssetSprite;

    public class CursorManager extends Actor
    {
        [Inject]
        public var mainView:MainView;

        private var _icon:DisplayObject;
        private var _layer:DisplayObjectContainer;
        private var _cropType:String;

        public function init():void
        {
            _layer = mainView.cursorLayer;
            eventMap.mapListener(mainView.stage, MouseEvent.MOUSE_MOVE, onMouseMove);
        }

        public function get cropType():String
        {
            return _cropType;
        }

        public function setSeedType(seedType:String, mousePoint:Point):void
        {
            _layer.removeChildren();

            _cropType = seedType;
            _icon = new AssetSprite(Manifest.SEED_TYPE[seedType]);
            _layer.addChild(_icon);

            updateIconPosition(mousePoint.x, mousePoint.y);
        }

        public function removeSeedType():void
        {
            _layer.removeChildren();
            _icon = null;
            _cropType = null;
        }

        private function onMouseMove(e:MouseEvent):void
        {
            if (_icon)
            {
                var globalPoint:Point = DisplayObject(e.target).localToGlobal(new Point(e.localX, e.localY));
                var localPoint:Point = mainView.stage.globalToLocal(globalPoint);
                updateIconPosition(localPoint.x, localPoint.y);
            }
        }

        private function updateIconPosition(mousePointX:Number, mousePointY:Number):void
        {
            _icon.x = mousePointX + 10;
            _icon.y = mousePointY + 10;
        }
    }
}
