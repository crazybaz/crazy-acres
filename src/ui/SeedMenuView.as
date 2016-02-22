package ui
{
    import core.Manifest;

    import event.GameEvent;

    import flash.display.Sprite;

    import ru.crabscrew.nano.core.group.NanoGroup;
    import ru.crabscrew.nano.core.group.layout.NanoHorizontalLayout;

    import ui.objects.AssetSprite;

    public class SeedMenuView extends NanoGroup
    {
        public var tomatoSeedButton:Sprite;
        public var pumpkinSeedButton:Sprite;

        public function SeedMenuView()
        {
            super(new NanoHorizontalLayout(5));

            tomatoSeedButton = new AssetSprite(Manifest.TOMATO_SEED);
            pumpkinSeedButton = new AssetSprite(Manifest.PUMPKIN_SEED);

            tomatoSeedButton.useHandCursor = true;
            pumpkinSeedButton.useHandCursor = true;

            add(tomatoSeedButton).add(pumpkinSeedButton);
            visible = false;

            tomatoSeedButton.addEventListener(GameEvent.VIEW_READY, buildLayout);
            pumpkinSeedButton.addEventListener(GameEvent.VIEW_READY, buildLayout);

            buildLayout();
        }

        private function buildLayout(e:GameEvent = null):void
        {
            build();
            graphics.clear();
            graphics.beginFill(0x777777, 0.5);
            graphics.lineStyle(1, 0x000000);
            graphics.drawRoundRect(0, 0, width, height, 5, 5);
            graphics.endFill();
        }

        public function set selected(value:Boolean):void
        {
            this.visible = value;
        }
    }
}
