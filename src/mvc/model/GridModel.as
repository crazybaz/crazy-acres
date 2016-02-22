package mvc.model
{
    import flash.utils.Dictionary;

    import lib.IsoTools;

    import org.robotlegs.mvcs.Actor;

    public class GridModel extends Actor
    {
        private var _grid:Vector.<MapObjectModel>;
        private var _mapObjects:Dictionary;

        public function GridModel()
        {
            _grid = new Vector.<MapObjectModel>(AppSettings.GRID_SIZE);
            _mapObjects = new Dictionary();
        }

        public function isRegionClean(isoX:int, isoY:int, size:int):Boolean
        {
            var endX:int = isoX + size;
            var endY:int = isoY + size;

            for (var y:int = isoY; y < endY; y++)
            {
                for (var x:int = isoX; x < endX; x++)
                {
                    if (getCell(x, y, true))
                    {
                        return false;
                    }
                }
            }
            return true;
        }

        public function addMapObject(mapObject:MapObjectModel):void
        {
            var endX:int = mapObject.isoX + mapObject.def.size;
            var endY:int = mapObject.isoY + mapObject.def.size;

            for (var y:int = mapObject.isoY; y < endY; y++)
            {
                for (var x:int = mapObject.isoX; x < endX; x++)
                {
                    if (getCell(x, y, true))
                    {
                        throw new Error("Error cell is busy");
                    }

                    setCell(x, y, mapObject);
                }
            }

            _mapObjects[mapObject.def.type] ||= new Vector.<MapObjectModel>();
            _mapObjects[mapObject.def.type].push(mapObject);
        }

        public function getMapObjectsByType(objectType:String):Vector.<MapObjectModel>
        {
            return _mapObjects[objectType];
        }

        public function getCell(x:int, y:int, unsafe:Boolean = false):MapObjectModel
        {
            var index:int = IsoTools.getIndex(x, y);
            if (IsoTools.isValidIndex(index))
            {
                return _grid[index];
            }

            if (unsafe)
            {
                return null;
            }

            throw new Error("Error: wrong index");
        }

        private function setCell(x:int, y:int, mapObject:MapObjectModel):void
        {
            var index:int = IsoTools.getIndex(x, y);
            if (IsoTools.isValidIndex(index))
            {
                _grid[index] = mapObject;
            }
            else
            {
                throw new Error("Error: wrong index");
            }
        }
    }
}
