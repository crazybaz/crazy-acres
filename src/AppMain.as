package
{
    import flash.display.Sprite;
    import flash.display.StageDisplayState;
    import flash.display.StageScaleMode;
    import flash.system.Security;

    import mvc.AppContext;

    [SWF(width='1024', height='768', backgroundColor=0xffffff, frameRate=24)]
    public class AppMain extends Sprite
    {
        protected var context:AppContext;

        public function AppMain()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.displayState = StageDisplayState.NORMAL;
            stage.focus = stage;

            Security.allowDomain("*");
            Security.allowInsecureDomain("*");

            context = new AppContext(this);
        }
    }
}
