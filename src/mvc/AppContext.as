package mvc
{
    import core.Api;
    import core.DefinitionManager;
    import core.RequirementsModule;

    import flash.display.Stage;

    import mvc.controller.commands.StartupCommand;
    import mvc.model.CursorManager;
    import mvc.model.GridModel;
    import mvc.view.mediator.MainViewMediator;
    import mvc.view.mediator.MapMediator;
    import mvc.view.mediator.NotificationViewMediator;
    import mvc.view.mediator.PlotViewMediator;
    import mvc.view.mediator.ScreenPanelMediator;
    import mvc.view.mediator.SeedMenuViewMediator;

    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.mvcs.Context;

    import ui.MainView;
    import ui.MapView;
    import ui.NotificationView;
    import ui.ScreenPanel;
    import ui.SeedMenuView;
    import ui.objects.PlotView;

    public class AppContext extends Context
    {
        private var stage:Stage;

        public function AppContext(appMain:AppMain)
        {
            stage = appMain.stage;
            super(appMain);
        }

        override public function startup():void
        {
            // ============= События =============
            commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent, true);

            // ============= Переменные =============
            injector.mapValue(Stage, stage);

            // ============= Медиаторы =============
            mediatorMap.mapView(MainView, MainViewMediator);
            mediatorMap.mapView(MapView, MapMediator);
            mediatorMap.mapView(ScreenPanel, ScreenPanelMediator);
            mediatorMap.mapView(NotificationView, NotificationViewMediator);
            mediatorMap.mapView(PlotView, PlotViewMediator);
            mediatorMap.mapView(SeedMenuView, SeedMenuViewMediator);

            // ============= Синглтоны =============
            injector.mapSingleton(Api);
            injector.mapSingleton(GridModel);
            injector.mapSingleton(DefinitionManager);
            injector.mapSingleton(RequirementsModule);
            injector.mapSingleton(CursorManager);

            super.startup();
        }
    }
}