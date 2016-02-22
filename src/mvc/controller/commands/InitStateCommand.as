package mvc.controller.commands
{
    import core.Api;
    import core.DefinitionManager;

    import mvc.model.MapObjectModel;

    import org.robotlegs.mvcs.Command;

    public class InitStateCommand extends Command
    {
        [Inject]
        public var api:Api;

        [Inject]
        public var definitions:DefinitionManager;

        override public function execute():void
        {
            for each (var mapObject:Object in AppSettings.STATE_DATA.field)
            {
                var model:MapObjectModel = new MapObjectModel(mapObject, definitions.getMapObject(mapObject.type));
                api.addMapObject(model);
            }
        }
    }
}
