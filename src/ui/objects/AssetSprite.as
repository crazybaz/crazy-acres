package ui.objects
{
    import core.*;

    import event.GameEvent;

    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import ui.IDestroyable;

    public class AssetSprite extends Sprite implements IDestroyable
    {
        public function AssetSprite(path:String)
        {
            ResourceManager.getImage(path, onReady);
        }

        protected function onReady(view:DisplayObject):void
        {
            addChildAt(view, 0);
            dispatchEvent(new GameEvent(GameEvent.VIEW_READY));
        }

        public function destroy():void
        {
        }
    }
}
