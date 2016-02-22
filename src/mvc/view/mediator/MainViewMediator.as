package mvc.view.mediator
{
    import mvc.model.CursorManager;

    import org.robotlegs.mvcs.Mediator;

    import ui.MainView;

    public class MainViewMediator extends Mediator
    {
        [Inject]
        public var view:MainView;

        [Inject]
        public var cursorManager:CursorManager;

        override public function onRegister():void
        {
            view.buildLayout();
            cursorManager.init();
        }
    }
}
