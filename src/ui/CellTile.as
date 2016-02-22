package ui
{
    import flash.display.Shape;
    import flash.display.Sprite;

    import lib.IsoTools;

    public class CellTile extends Sprite
    {
        private var _selection:Shape;
        private var _debugView:Shape;

        public function CellTile(isoX:int, isoY:int):void
        {
            x = (isoX - isoY) * AppSettings.CELL_WIDTH / 2;
            y = (isoX + isoY) * AppSettings.CELL_WIDTH / 4;

            scaleY = 0.5;
        }

        public function showSelection():void
        {
            if (!_selection)
            {
                _selection = new Shape();
                //_selection.graphics.lineStyle(1, 0xff00ff, 0.3);
                _selection.graphics.beginFill(0x000000, 0.1);
                _selection.graphics.drawRect(0, 0, IsoTools.ISO_RECT_SIZE, IsoTools.ISO_RECT_SIZE);
                _selection.graphics.endFill();
                _selection.rotation = 45;
                addChild(_selection);
            }
            _selection.visible = true;
        }

        public function cleanSelection():void
        {
            _selection.visible = false;
        }

        public function showDebugView():void
        {
            if (!_debugView)
            {
                _debugView = new Shape();
                _debugView.graphics.lineStyle(1, 0x000000, 0.1);
                //_debugView.graphics.beginFill(0xff00ff, 0.15);
                _debugView.graphics.drawRect(0, 0, IsoTools.ISO_RECT_SIZE, IsoTools.ISO_RECT_SIZE);
                _debugView.graphics.endFill();
                _debugView.rotation = 45;
                addChild(_debugView);
            }
            _debugView.visible = true;
        }

        public function hideDebugView():void
        {
            _debugView.visible = false;
        }
    }
}
