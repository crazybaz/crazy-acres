package
{
    import flash.geom.Point;

    public class AppSettings
    {
        // Грид
        public static const CELL_WIDTH:int = 100;

        public static const GRID_WIDTH:int = 48;
        public static const GRID_SIZE:int = GRID_WIDTH * GRID_WIDTH;

        public static const GRID_ORIGIN_POINT:Point = new Point(2600, 710);

        public static function get ASSETS_PATH():String
        {
            return CONFIG::ASSETS_PATH;
        }

        public static const STATE_DATA:Object =
        {
            field:
            [
                {
                    type: "plot",
                    x: 34,
                    y: 22
                },
                {
                    type: "plot",
                    x: 34,
                    y: 18
                },
                {
                    type: "plot",
                    x: 32,
                    y: 20
                },
                {
                    type: "plot",
                    x: 34,
                    y: 20
                },
                {
                    type: "plot",
                    x: 36,
                    y: 20
                }
            ]
        };

        public static const DEFINITIONS:Object =
        {
            mapObjects: {
                plot: {
                    size: 2,
                    limit: 12
                }
            },
            crop: {
                tomato: {
                    grow_time: 60000
                },
                pumpkin: {
                    grow_time: 30000
                }
            }
        }
    }
}
