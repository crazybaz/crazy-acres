package ui
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.filters.GlowFilter;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.Timer;

    public class NotificationView extends Sprite
    {
        private var _timer:Timer;
        private var _message:TextField;

        public function NotificationView()
        {
            _message = new TextField();
            _message.defaultTextFormat = new TextFormat("Arial", 22, 0xff0000, true);
            _message.autoSize = TextFieldAutoSize.CENTER;
            _message.selectable = false;
            _message.filters = [new GlowFilter(0xffffff, .8, 8, 8, 3)];
            addChild(_message);

            _timer = new Timer(100);
            _timer.addEventListener(TimerEvent.TIMER, onTimer);
        }

        public function updateLayout():void
        {
            _message.x = (stage.stageWidth - _message.textWidth) * .5
            _message.y = stage.stageHeight * .5 - _message.textHeight;
        }

        public function updateMessage(message:String):void
        {
            _message.text = message;
            _message.alpha = 1;

            _timer.reset();
            _timer.start();

            updateLayout();
        }

        private function onTimer(e:Event):void
        {
            _message.alpha -= 0.05;
            if (_message.alpha <= 0)
                _timer.stop();
        }
    }
}
