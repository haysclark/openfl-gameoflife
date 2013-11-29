/*
 * Created by IntelliJ IDEA.
 * User: hays
 * Date: 11/28/13
 * Time: 4:27 PM
 */
package gameoflife.model.simulation;

/**
List of Todo items.

@see model.simulation.Simulation
@see mcore.data.ArrayList
*/
import mcore.data.ArrayList;

class SimulationList extends ArrayList<Simulation>
{
    public function new(?values:Array<Simulation> = null)
    {
        super(values);
    }

    public function addSim( sim:Simulation ):Void
    {
        var exists = getById( sim.id );
        if( exists == null )
        {
            //update
        }else
        {
            add( sim );
        }
    }

    /**
	gets simulation by id
	*/
    public function getById( id:String ):Simulation
    {
        for( sim in source )
        {
            if(sim.id == id)
            {
               return sim;
            }
        }

        return null;
    }
}