package mvc.model.definition
{
    public class MapObjectDefinition
    {
        private var _type:String;
        private var _size:int;
        private var _limit:int;

        public function MapObjectDefinition(type:String, source:Object)
        {
            _type = type;
            _size = parseInt(source.size);
            _limit = parseInt(source.limit);
        }

        public function get type():String
        {
            return _type;
        }

        public function get size():int
        {
            return _size;
        }

        public function get limit():int
        {
            return _limit;
        }
    }
}
