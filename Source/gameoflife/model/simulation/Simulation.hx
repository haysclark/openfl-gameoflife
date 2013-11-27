package gameoflife.model.simulation;

/**
 * Created by hclark on 11/22/13.
 */
class Simulation
{
    public var now:Grid;
    private var next:Grid;

    public function new()
    {
    }

    public function build(cellsWide:Int, cellHeight:Int):Void
    {
        now = new Grid();
        now.init(cellsWide, cellHeight);

        next = new Grid();
        next.init(cellsWide, cellHeight);
    }

    public function getNumAliveNeighbors(x:Int, y:Int):Int
    {
        var neighbors:Int = 0;
        for( col in x-1...x+2 )
        {
            for( row in y-1...y+2 )
            {
                if( (col == x && row == y) || !now.isValidLocation(col, row) || !now.cells[col][row] )
                {
                    continue;
                }

                neighbors++;
            }
        }

        return neighbors;
    }

    public function tick():Void
    {
        for (x in 0...now.cells.length)
        {
            for (y in 0...now.cells[x].length)
            {
                next.cells[x][y] = processCell(x, y);
            }
        }

        var old = now;
        now = next;
        next = old;
    }

    public function processCell(x:Int, y:Int):Bool
    {
        var alive:Bool = now.cells[x][y];
        var neighbors:Int = getNumAliveNeighbors(x, y);
        if( alive )
        {
            if( neighbors < 2 )
            {
                alive = !alive;
            }else if( neighbors == 2 || neighbors == 3 )
            {
            }else if( neighbors > 3 )
            {
                alive = !alive;
            }
        }else
        {
            if( neighbors == 3 )
            {
                alive = !alive;
            }
        }
        return alive;
    }

}