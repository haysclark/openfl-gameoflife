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
            for (y in 0...grid[x].length)
            {
                next[x][y] = processCell(x, y);
            }
        }

        var old = grid;
        grid = next;
        next = old;
    }

    public function processCell(x:Int, y:Int):Bool
    {
        var alive:Bool = grid[x][y];
        if( alive )
        {
            var neighbors:Int = getNumAliveNeighbors(x, y);
            if( neighbors < 2 )
            {
                alive = !alive;
            }
        }
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

    private function getNumAliveNeighbors(x:Int, y:Int):Int
    {
        var neighbors:Int = 0;
        for( col in x-1...x+2 )
        {
            for( row in y-1...y+2 )
            {
                if( (col == x && row == y) || !isValidLocation(col, row) || !grid[col][row] )
                {
                    continue;
                }

                neighbors++;
            }
        }

        return neighbors;
    }

    private function isValidLocation(x:Int, y:Int):Bool
    {
        return ( x >= 0 && x < grid.length && y >= 0 && y < grid[0].length );
    }
}