package gameoflife.model.simulation;

import massive.munit.Assert;

/**
 * author hclark
 */
class GridTest
{
    private var _instance:Grid;

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
    public function testInitShouldSetCorrectSize():Void
    {
        var width:Int = 5;
        var height:Int = 7;

        _instance.init(width, height);

        Assert.areEqual(width, _instance.cells[0].length);
        Assert.areEqual(height, _instance.cells.length);
    }

    @Test
    public function testIsValidLocationShouldReturnExpected():Void
    {
        var width:Int = 3;
        var height:Int = 3;

        _instance.init(width, height);

        Assert.isFalse(_instance.isValidLocation( -1, -1 ));
        Assert.isFalse(_instance.isValidLocation( 1, -1 ));
        Assert.isFalse(_instance.isValidLocation( -1, 1 ));
        Assert.isFalse(_instance.isValidLocation( 3, 1 ));
        Assert.isFalse(_instance.isValidLocation( 1, 3 ));
        Assert.isFalse(_instance.isValidLocation( 3, 3 ));
        Assert.isTrue(_instance.isValidLocation( 0, 0 ));
        Assert.isTrue(_instance.isValidLocation( 1, 1 ));
        Assert.isTrue(_instance.isValidLocation( 2, 2 ));
    }

}