package mvc.controller.commands
{
    import event.GameEvent;

    import mvc.model.GridModel;
    import mvc.model.definition.MapObjectDefinition;

    import org.robotlegs.mvcs.Command;

    public class CreatePhantomObjectCommand extends Command
    {
        [Inject]
        public var def:MapObjectDefinition;

        [Inject]
        public var grid:GridModel;

        public function CreatePhantomObjectCommand()
        {
            grid.eventDispatcher.dispatchEvent(new GameEvent(GameEvent.CREATE_PHANTOM_OBJECT));

        }
    }
}
