package core
{
    import flash.utils.Dictionary;

    import mvc.model.definition.CropDefinition;
    import mvc.model.definition.MapObjectDefinition;

    public class DefinitionManager
    {
        private var _mapObjects:Dictionary;
        private var _cropObjects:Dictionary;

        public function initMapObjects(source:Object):void
        {
            _mapObjects = new Dictionary();
            for (var type:String in source)
            {
                _mapObjects[type] = new MapObjectDefinition(type, source[type]);
            }
        }

        public function initCropObjects(source):void
        {
            _cropObjects = new Dictionary();
            for (var type:String in source)
            {
                _cropObjects[type] = new CropDefinition(type, source[type]);
            }
        }

        public static const MAP_OBJECT_PLOT:String = "plot";

        public static const SEED_TYPE_TOMATO:String = "tomato";
        public static const SEED_TYPE_PUMPKIN:String = "pumpkin";

        public function getMapObject(type:String):MapObjectDefinition
        {
            if (_mapObjects[type])
                return _mapObjects[type];

            throw new Error("Error invalid map object type");
        }

        public function getCropObject(type:String):CropDefinition
        {
            if (_cropObjects[type])
                return _cropObjects[type];

            throw new Error("Error invalid crop object type");
        }
    }
}
