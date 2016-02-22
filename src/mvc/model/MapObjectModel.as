package mvc.model
{
    import event.GameEvent;

    import flash.events.EventDispatcher;

    import mvc.model.definition.MapObjectDefinition;

    public class MapObjectModel extends EventDispatcher
    {
        private var _isoX:int;
        private var _isoY:int;
        private var _isoDepth:int;

        private var _def:MapObjectDefinition;

        private var _state:String;
        public static const STATE_IDLE:String = "STATE_IDLE";
        public static const STATE_WATER:String = "STATE_WATER";
        public static const STATE_START_GROW:String = "STATE_START_GROW";
        public static const STATE_MIDDLE_GROW:String = "STATE_MIDDLE_GROW";
        public static const STATE_READY:String = "STATE_READY";

        public var cropType:String;

        public function MapObjectModel(source:Object, def:MapObjectDefinition)
        {
            _isoX = parseInt(source.x);
            _isoY = parseInt(source.y);

            _def = def;
            _state = STATE_IDLE;
            _isoDepth = _isoX + _isoY;
        }

        public function get state():String
        {
            return _state;
        }

        public function get isoDepth():int
        {
            return _isoDepth;
        }

        public function setState(value:String):void
        {
            _state = value;
            dispatchEvent(new GameEvent(GameEvent.STATE_CHANGED));
        }

        public function get isoX():int
        {
            return _isoX;
        }

        public function get isoY():int
        {
            return _isoY;
        }

        public function get def():MapObjectDefinition
        {
            return _def;
        }
    }
}
