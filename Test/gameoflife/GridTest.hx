package gameoflife;

import massive.munit.Assert;

/**
 * author hclark
 */
class GridTest
{
    public var _instance:Grid;

    public function new()
    {}

    @Before
    public function setup():Void
    {
        _instance = new Grid();
    }

    @After
    public function tearDown():Void
    {
        _instance = null;
    }

    @Test
    public function testBuildGridShouldSetCorrectSize():Void
    {
        var width:Int = 5;
        var height:Int = 7;

        _instance.buildGrid(5, 7);

        Assert.areEqual(width, _instance.grid[0].length);
        Assert.areEqual(height, _instance.grid.length);
    }

    @Test
    public function testTickShouldObeyUnderPopulationRule():Void
    {
        // Rule 1: Any live cell with fewer than two live
        // neighbours dies, as if caused by under-population.

        _instance.buildGrid(3, 3);
        _instance.grid[1][1] = true;

        _instance.tick();

        Assert.isFalse(_instance.grid[1][1]);
    }
}