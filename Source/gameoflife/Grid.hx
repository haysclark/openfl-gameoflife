package gameoflife;

/**
 * author hclark
 */
class Grid
{
    public var grid:Array<Array<Bool>>;
    private var next:Array<Array<Bool>>;

    public function new():Void
    {
    }

    public function buildGrid(cellsWide:Int, cellHeight:Int):Void
    {
        grid = new Array<Array<Bool>>();
        next = new Array<Array<Bool>>();

        initArray(grid, cellsWide, cellHeight);
        initArray(next, cellsWide, cellHeight);
    }

    public function tick():Void
    {
        for (x in 0...grid.length)
        {
            var col = grid[x];
            for (y in 0...col.length)
            {
                next[x][y] = processCell(x, y);
            }
        }
    }

    public function processCell(x:Int, y:Int):Bool
    {
        var alive:Bool = grid[x][y];
        return alive;
    }

    private function initArray(target:Array<Array<Bool>>, cellsWide:Int, cellHeight:Int):Void
    {
        var i = 0;

        while (i < cellHeight)
        {
            var row = new Array<Bool>();
            var j = 0;

            while (j < cellsWide)
            {
                row.push(false);
                j++;
            }

            target.push(row);
            i++;
        }
    }
}