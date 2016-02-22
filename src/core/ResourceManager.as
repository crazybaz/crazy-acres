package core
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;

    public class ResourceManager
    {
        // Список загруженных ресурсов
        private static var assetList:Dictionary = new Dictionary();

        public function ResourceManager()
        {
        }

        public static function getImage(path:String, onComplete:Function):void
        {
            if (assetList[path])
            {
                // Берём из кэша
                onComplete(new Bitmap(assetList[path] as BitmapData));
            }
            else
            {
                // Загружаем
                var loader:Loader = new Loader();
                var context:LoaderContext = new LoaderContext();
                context.checkPolicyFile = true;
                loader.load(new URLRequest(AppSettings.ASSETS_PATH + path), context);
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadingComplete);
            }

            // Кэшируем
            function onLoadingComplete(e:Event):void
            {
                loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
                var bitmap:Bitmap = Bitmap(e.target.content);
                assetList[path] = bitmap.bitmapData;
                onComplete(bitmap);
            }
        }
    }
}
