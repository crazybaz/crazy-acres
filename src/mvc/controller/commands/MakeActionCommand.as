package mvc.controller.commands
{
    import core.Api;
    import core.DefinitionManager;

    import event.GameEvent;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import mvc.model.MapObjectModel;
    import mvc.model.definition.CropDefinition;

    import org.robotlegs.mvcs.Command;

    public class MakeActionCommand extends Command
    {
        [Inject]
        public var api:Api;

        [Inject]
        public var model:MapObjectModel;

        [Inject]
        public var definitions:DefinitionManager;

        private var _timer:Timer;

        override public function execute():void
        {
            if (model.state == MapObjectModel.STATE_IDLE)
            {
                api.eventDispatcher.dispatchEvent(new GameEvent(GameEvent.SHOW_CROP_MENU, model));
            }
            else if (model.state == MapObjectModel.STATE_WATER)
            {
                model.setState(MapObjectModel.STATE_START_GROW);

                var cropDef:CropDefinition = definitions.getCropObject(model.cropType);
                _timer = new Timer(cropDef.growTime * 0.5);
                _timer.addEventListener(TimerEvent.TIMER, setMiddleGrowState);
                _timer.start();
            }
            else if (model.state == MapObjectModel.STATE_READY)
            {
                model.setState(MapObjectModel.STATE_IDLE);
            }
        }

        private function setMiddleGrowState(e:TimerEvent):void
        {
            model.setState(MapObjectModel.STATE_MIDDLE_GROW);

            _timer.removeEventListener(TimerEvent.TIMER, setMiddleGrowState);
            _timer.addEventListener(TimerEvent.TIMER, setReadyState);
            _timer.reset();
            _timer.start();
        }

        private function setReadyState(e:TimerEvent):void
        {
            model.setState(MapObjectModel.STATE_READY);

            _timer.removeEventListener(TimerEvent.TIMER, setReadyState);
            _timer.stop();
        }
    }
}
