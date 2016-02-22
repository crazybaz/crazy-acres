package ui.objects
{
    import core.*;

    import flash.display.DisplayObject;

    import mvc.model.MapObjectModel;

    public class MapObjectView extends AssetSprite
    {
        private var _model:MapObjectModel;

        public function MapObjectView(model:MapObjectModel)
        {
            _model = model;
            super(Manifest.MAP_OBJECTS[model.def.type]);
        }

        public function get model():MapObjectModel
        {
            return _model;
        }

        override protected function onReady(view:DisplayObject):void
        {
            view.x -= view.width * .5;
            super.onReady(view);
        }
    }
}
