package gameoflife.model.simulation;

/**
 * author hclark
 */
class Grid
{
    public var cells:Array<Array<Bool>>;

    public function new():Void
    {
    }

    public function init(cellsWide:Int, cellHeight:Int):Void
    {
        cells = new Array<Array<Bool>>();
        for( i in 0...cellHeight)
        {
            var row = new Array<Bool>();
            for( j in 0...cellsWide)
            {
                row.push(false);
            }

            cells.push(row);
        }
    }

    public function isValidLocation(x:Int, y:Int):Bool
    {
        return ( x >= 0 && x < cells.length && y >= 0 && y < cells[0].length );
    }

}