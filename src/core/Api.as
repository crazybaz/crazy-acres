package core
{
    import event.GameEvent;

    import flash.geom.Point;

    import mvc.controller.commands.AddMapObjectCommand;
    import mvc.controller.commands.MakeActionCommand;
    import mvc.model.CursorManager;
    import mvc.model.MapObjectModel;
    import mvc.model.definition.MapObjectDefinition;

    import org.robotlegs.core.ICommandMap;
    import org.robotlegs.mvcs.Actor;

    public class Api extends Actor
    {
        [Inject]
        public var commandMap:ICommandMap;

        [Inject]
        public var definitions:DefinitionManager;

        [Inject]
        public var requirements:RequirementsModule;

        [Inject]
        public var cursorManager:CursorManager;

        public function addMapObject(model:MapObjectModel):void
        {
            commandMap.execute(AddMapObjectCommand, model, MapObjectModel);
        }

        public function addMapObjectFromPhantom(isoPos:Point, def:MapObjectDefinition):void
        {
            var model:MapObjectModel = new MapObjectModel({
                x: isoPos.x,
                y: isoPos.y
            }, def);

            addMapObject(model);
        }

        public function createPhantomObject(type:String):void
        {
            var def:MapObjectDefinition = definitions.getMapObject(type);
            if (requirements.checkLimit(def))
            {
                cursorManager.removeSeedType();
                dispatch(new GameEvent(GameEvent.CREATE_PHANTOM_OBJECT, def));
            }
            else
            {
                showNotification("Достигнут лимит построек данного типа");
            }
        }

        public function removePhantomObject():void
        {
            dispatch(new GameEvent(GameEvent.REMOVE_PHANTOM_OBJECT));
        }

        public function showNotification(message:String):void
        {
            dispatch(new GameEvent(GameEvent.SHOW_NOTIFICATION, message));
        }

        public function plant(seedType:String, model:MapObjectModel):void
        {
            if (model.state == MapObjectModel.STATE_IDLE)
            {
                model.cropType = seedType;
                model.setState(MapObjectModel.STATE_WATER);
            }
        }

        public function makeAction(model:MapObjectModel):void
        {
            commandMap.execute(MakeActionCommand, model);
        }
    }
}
