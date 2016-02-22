package mvc.controller.commands
{
    import core.DefinitionManager;

    import mvc.model.GridModel;

    import org.robotlegs.mvcs.Command;

    import ui.MainView;

    public class StartupCommand extends Command
    {
        [Inject]
        public var gridModel:GridModel;

        [Inject]
        public var definitions:DefinitionManager;

        override public function execute():void
        {
            definitions.initMapObjects(AppSettings.DEFINITIONS.mapObjects);
            definitions.initCropObjects(AppSettings.DEFINITIONS.crop);

            var mainView:MainView = new MainView();
            injector.mapValue(MainView, mainView);
            contextView.addChild(mainView);

            commandMap.execute(InitStateCommand);
        }
    }
}
