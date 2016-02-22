package mvc.view.mediator
{
    import event.GameEvent;

    import mvc.model.MapObjectModel;

    import org.robotlegs.mvcs.Mediator;

    import ui.objects.PlotView;

    public class PlotViewMediator extends Mediator
    {
        [Inject]
        public var view:PlotView;

        override public function onRegister():void
        {
            eventMap.mapListener(view.model, GameEvent.STATE_CHANGED, onStateChanged);
        }

        private function onStateChanged(e:GameEvent):void
        {
            switch (view.model.state)
            {
                case MapObjectModel.STATE_IDLE:
                    view.setIdleState();
                    break;
                case MapObjectModel.STATE_WATER:
                    view.setWaterState();
                    break;
                case MapObjectModel.STATE_START_GROW:
                    view.setStartGrowState();
                    break;
                case MapObjectModel.STATE_MIDDLE_GROW:
                    view.setMiddleGrowState();
                    break;
                case MapObjectModel.STATE_READY:
                    view.setReadyState()
                    break;
            }
        }
    }
}
