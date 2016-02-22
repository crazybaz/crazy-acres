package mvc.model.definition
{
    public class CropDefinition
    {
        private var _type:String;
        private var _growTime:int;

        public function CropDefinition(type:String, source:Object)
        {
            _type = type;
            _growTime = parseInt(source.grow_time);
        }

        public function get type():String
        {
            return _type;
        }

        public function get growTime():int
        {
            return _growTime;
        }
    }
}
