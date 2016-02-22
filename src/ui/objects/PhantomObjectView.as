package ui.objects
{
    import core.Manifest;

    import flash.display.DisplayObject;
    import flash.filters.GlowFilter;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class PhantomObjectView extends AssetSprite
    {
        private var _info:TextField;

        public function PhantomObjectView(objectType:String)
        {
            _info = new TextField();
            _info.defaultTextFormat = new TextFormat("Arial", 16, 0x000000, true);
            _info.filters = [new GlowFilter(0xffffff, .8, 5, 5, 3)];
            _info.text = "5/12";

            super(Manifest.MAP_OBJECTS[objectType]);
        }

        override protected function onReady(view:DisplayObject):void
        {
            super.onReady(view);

            view.x -= view.width * .5;
            view.alpha = .6;

            _info.x += view.width * .25;
            addChild(_info);
        }

        public function updateLimit(currentValue:int, maxValue:int):void
        {
            _info.text = currentValue + "/" + maxValue;
        }
    }
}
