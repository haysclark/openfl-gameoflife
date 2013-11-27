package gameoflife;

/**
 * Created by hclark on 11/22/13.
 */
import massive.munit.Assert;
class SimulationTest
{
    public var _instance:Simulation;

    public function new()
    {}

    @Before
    public function setup():Void
    {
        _instance = new Simulation();
    }

    @After
    public function tearDown():Void
    {
        _instance = null;
    }

    @Test
    public function testGetNumAliveNeighborsShouldBeZero():Void
    {
        _instance.build(3, 3);

        Assert.areEqual( 0, _instance.getNumAliveNeighbors(1, 1) );
    }

    @Test
    public function testGetNumAliveNeighborsShouldBeZeroForSelf():Void
    {
        _instance.build(3, 3);
        _instance.now.cells[1][1] = true;

        Assert.areEqual( 0, _instance.getNumAliveNeighbors(1, 1) );
    }

    @Test
    public function testGetNumAliveNeighborsShouldWorkForAll():Void
    {
        _instance.build(3, 3);
        _instance.now.cells[0][0] = true;
        _instance.now.cells[1][0] = true;
        _instance.now.cells[2][0] = true;
        _instance.now.cells[0][1] = true;
        _instance.now.cells[1][1] = true;
        _instance.now.cells[2][1] = true;
        _instance.now.cells[0][2] = true;
        _instance.now.cells[1][2] = true;
        _instance.now.cells[2][2] = true;

        Assert.areEqual( 8, _instance.getNumAliveNeighbors(1, 1) );
    }

    @Test
    public function testTickShouldObeyUnderPopulationRule():Void
    {
        // Rule 1: Any live cell with fewer than two live
        // neighbours dies, as if caused by under-population.

        _instance.build(3, 3);
        _instance.now.cells[1][1] = true;

        _instance.tick();

        Assert.isFalse(_instance.now.cells[1][1]);
    }

    @Test
    public function testTickShouldObeyNextGenerationRuleFor2():Void
    {
        // Rule 2: Any live cell with two or three live
        // neighbours lives on to the next generation.

        _instance.build(3, 3);
        _instance.now.cells[0][1] = true;
        _instance.now.cells[1][1] = true;
        _instance.now.cells[2][1] = true;

        _instance.tick();

        Assert.isTrue(_instance.now.cells[1][1]);
    }

    @Test
    public function testTickShouldObeyNextGenerationRuleFor3():Void
    {
        // Rule 2: Any live cell with two or three live
        // neighbours lives on to the next generation.

        _instance.build(3, 3);
        _instance.now.cells[0][1] = true;
        _instance.now.cells[1][1] = true;
        _instance.now.cells[2][1] = true;
        _instance.now.cells[1][0] = true;

        _instance.tick();

        Assert.isTrue(_instance.now.cells[1][1]);
    }

    @Test
    public function testTickShouldObeyOvercrowdingRule():Void
    {
        // Rule 3: Any live cell with more than three live
        // neighbours dies, as if by overcrowding.

        _instance.build(3, 3);
        _instance.now.cells[0][1] = true;
        _instance.now.cells[0][2] = true;
        _instance.now.cells[1][0] = true;
        _instance.now.cells[1][1] = true;
        _instance.now.cells[1][2] = true;

        _instance.tick();

        Assert.isFalse(_instance.now.cells[1][1]);
    }

    @Test
    public function testTickShouldObeyReproductionRule():Void
    {
        // Rule 4: Any dead cell with exactly three live
        // neighbours becomes a live cell, as if by reproduction.

        _instance.build(3, 3);
        _instance.now.cells[0][1] = true;
        _instance.now.cells[0][2] = true;
        _instance.now.cells[1][0] = true;

        _instance.tick();

        Assert.isTrue(_instance.now.cells[1][1]);
    }
}
