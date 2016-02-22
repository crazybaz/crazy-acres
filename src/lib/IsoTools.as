package lib
{
    import flash.geom.Point;

    public class IsoTools
    {
        public static const ISO_RECT_SIZE:int = Math.sqrt(2 * Math.pow(AppSettings.CELL_WIDTH / 2, 2));

        public static function getIsoPoint(index:int):Point
        {
            var isoX:int = index % AppSettings.GRID_WIDTH;
            var isoY:int = int(index / AppSettings.GRID_WIDTH);

            return new Point(isoX, isoY);
        }

        public static function getIndex(isoX:int, isoY:int):int
        {
            return isoX + isoY * AppSettings.GRID_WIDTH;
        }

        public static function isValidIndex(index:int):Boolean
        {
            return index >= 0 && index < AppSettings.GRID_SIZE;
        }

        public static function stageToIso(viewX:int, viewY:int):Point
        {
            viewY *= 2;
            var isoX:int = Math.floor((viewY + viewX) / AppSettings.CELL_WIDTH);
            var isoY:int = Math.floor((viewY - viewX) / AppSettings.CELL_WIDTH);

            return new Point(isoX, isoY);
        }

        public static function isoToStage(isoX:int, isoY:int):Point
        {
            var viewX = (isoX - isoY) * AppSettings.CELL_WIDTH / 2;
            var viewY = (isoX + isoY) * AppSettings.CELL_WIDTH / 4;

            return new Point(viewX, viewY);
        }

        public static function stageToStage(viewX:int, viewY:int):Point
        {
            var isoPoint:Point = stageToIso(viewX, viewY);
            return isoToStage(isoPoint.x, isoPoint.y);
        }
    }
}
