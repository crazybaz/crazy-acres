package core
{
    import mvc.model.GridModel;
    import mvc.model.MapObjectModel;
    import mvc.model.definition.MapObjectDefinition;

    public class RequirementsModule
    {
        [Inject]
        public var grid:GridModel;

        public function checkLimit(def:MapObjectDefinition):Boolean
        {
            var mapObjects:Vector.<MapObjectModel> = grid.getMapObjectsByType(def.type);
            return mapObjects && mapObjects.length < def.limit;
        }
    }
}
