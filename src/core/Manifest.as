package core
{
    public class Manifest
    {
        public static const BG:String = "bg.png";

        public static const PUMPKIN_SEED:String = "pumpkin_seed.png";
        public static const TOMATO_SEED:String = "tomato_seed.png";

        public static const DROP:String = "drop.png";

        public static const MAP_OBJECTS:Object =
        {
            plot: "plot.png"
        };

        public static const CROP:Object =
        {
            tomato: {
                states: [
                    "drop.png",
                    "tomato_state_1.png",
                    "tomato_state_2.png",
                    "tomato_state_3.png"
                ]
            },
            pumpkin: {
                states: [
                    "drop.png",
                    "pumpkin_state_1.png",
                    "pumpkin_state_2.png",
                    "pumpkin_state_3.png"
                ]
            }
        };

        public static const SEED_TYPE:Object =
        {
            tomato: "tomato.png",
            pumpkin: "pumpkin.png"
        }
    }
}
