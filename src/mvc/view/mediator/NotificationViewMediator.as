package mvc.view.mediator
{
    import core.Api;

    import event.GameEvent;

    import org.robotlegs.mvcs.Mediator;

    import ui.NotificationView;

    public class NotificationViewMediator extends Mediator
    {
        [Inject]
        public var api:Api;

        [Inject]
        public var view:NotificationView;

        override public function onRegister():void
        {
            view.updateLayout();
            api.eventDispatcher.addEventListener(GameEvent.SHOW_NOTIFICATION, showNotification);
        }

        private function showNotification(e:GameEvent):void
        {
            view.updateMessage(String(e.data));
        }
    }
}