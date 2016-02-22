package event
{
    import flash.events.Event;

    public class GameEvent extends Event
    {
        public static const VIEW_READY:String = "VIEW_READY";
        public static const MAP_OBJECT_ADDED:String = "MAP_OBJECT_ADDED";
        public static const CREATE_PHANTOM_OBJECT:String = "PHANTOM_OBJECT_ADDED";
        public static const REMOVE_PHANTOM_OBJECT:String = "REMOVE_PHANTOM_OBJECT";
        public static const SHOW_NOTIFICATION:String = "SHOW_NOTIFICATION";
        public static const SHOW_CROP_MENU:String = "SHOW_SEED_MENU";
        public static const HIDE_CROP_MENU:String = "HIDE_SEED_MENU";

        public static const STATE_CHANGED:String = "STATE_CHANGED";

        private var _data:Object;

        public function GameEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            _data = data;
            super(type, bubbles, cancelable);
        }

        public function get data():Object
        {
            return _data;
        }

        override public function clone():Event
        {
            return new GameEvent(type, data, bubbles, cancelable);
        }
    }
}
