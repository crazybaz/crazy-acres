package ui
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextFormat;

    import ru.crabscrew.nano.core.group.NanoGroup;
    import ru.crabscrew.nano.core.group.layout.NanoHorizontalLayout;
    import ru.crabscrew.nano.quick.button.QuickNanoButton;

    public class ScreenPanel extends Sprite
    {
        public var buyPlotButton:QuickNanoButton;
        public var cancelButton:QuickNanoButton;

        private var _buyState:NanoGroup;
        private var _cancelState:NanoGroup;

        public function ScreenPanel()
        {
            var tf:TextFormat = new TextFormat("Arial", "18", 0x444444, true);
            buyPlotButton = new QuickNanoButton().suFormat(tf).suLabel("Новая грядка");
            cancelButton = new QuickNanoButton().suFormat(tf).suLabel("Отменить");
            cancelButton.mouseChildren = false;

            _buyState = new NanoGroup(new NanoHorizontalLayout(3));
            _buyState.add(buyPlotButton);
            _buyState.build();

            _cancelState = new NanoGroup(new NanoHorizontalLayout(3));
            _cancelState.add(cancelButton);
            _cancelState.build();

            addChild(_buyState);
            addChild(_cancelState);
        }

        public function buildLayout(e:Event = null):void
        {
            _buyState.x = (stage.stageWidth - _buyState.width) * .5;
            _buyState.y = stage.stageHeight - _buyState.height - 10;

            _cancelState.x = (stage.stageWidth - _cancelState.width) * .5;
            _cancelState.y = stage.stageHeight - _cancelState.height - 10;
        }

        public function setBuildState():void
        {
            _buyState.visible = true;
            _cancelState.visible = false;
        }

        public function setCancelState():void
        {
            _buyState.visible = false;
            _cancelState.visible = true;
        }
    }
}
