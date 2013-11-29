/**
* SimulationListTest
* Description:
* ...
* 
* @author hays
* Copyright © 2013 All rights reserved.
**/
package gameoflife.model.simulation;

import flash.display.SimpleButton;
import massive.munit.Assert;

class SimulationListTest
{
    var _instance:SimulationList;

    @BeforeClass
    public function beforeClass():Void
    {
    }

    @AfterClass
    public function afterClass():Void
    {
    }

    @Before
    public function setup():Void
    {
        _instance = new SimulationList();
    }

    @After
    public function tearDown():Void
    {
        _instance = null;
    }

    @Test
    public function testAddShouldAddSimulation():Void
    {
        var randId = TestHelper.randomString();
        var expected = new Simulation();
        expected.id = randId;

        _instance.addSim(expected);

        Assert.isTrue( _instance.indexOf(expected) == -1 );

        //var recieved = _instance.getById(randId);
        //Assert.areEqual( recieved, expected );
    }
}