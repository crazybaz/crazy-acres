package mvc.view.mediator
{
    import core.Api;
    import core.DefinitionManager;

    import event.GameEvent;

    import flash.events.MouseEvent;

    import org.robotlegs.mvcs.Mediator;

    import ui.ScreenPanel;

    public class ScreenPanelMediator extends Mediator
    {
        [Inject]
        public var api:Api;

        [Inject]
        public var view:ScreenPanel;

        override public function onRegister():void
        {
            eventMap.mapListener(view.buyPlotButton, MouseEvent.CLICK, onBuyPlotClick);
            eventMap.mapListener(view.cancelButton, MouseEvent.CLICK, onCancelClick);

            eventMap.mapListener(api.eventDispatcher, GameEvent.CREATE_PHANTOM_OBJECT, setCancelState);
            eventMap.mapListener(api.eventDispatcher, GameEvent.REMOVE_PHANTOM_OBJECT, setBuildState);

            view.buildLayout();
            view.setBuildState();
        }

        private function onBuyPlotClick(e:MouseEvent):void
        {
            e.stopImmediatePropagation();
            api.createPhantomObject(DefinitionManager.MAP_OBJECT_PLOT);
        }

        private function onCancelClick(e:MouseEvent):void
        {
            e.stopImmediatePropagation();
            api.removePhantomObject();
        }

        private function setCancelState(e:GameEvent):void
        {
            view.setCancelState();
        }

        private function setBuildState(e:GameEvent):void
        {
            view.setBuildState();
        }
    }
}
