package mvc.controller.commands
{
    import event.GameEvent;

    import mvc.model.GridModel;
    import mvc.model.MapObjectModel;

    import org.robotlegs.mvcs.Command;

    public class AddMapObjectCommand extends Command
    {
        [Inject]
        public var model:MapObjectModel;

        [Inject]
        public var grid:GridModel;

        override public function execute():void
        {
            grid.addMapObject(model);
            grid.eventDispatcher.dispatchEvent(new GameEvent(GameEvent.MAP_OBJECT_ADDED, model));
        }
    }
}
