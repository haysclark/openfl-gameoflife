/*
 * Created by IntelliJ IDEA.
 * User: hays
 * Date: 11/26/13
 * Time: 11:43 PM
 */
package app;

import gameoflife.view.simulation.SimulationOpenGLViewMediator;
import gameoflife.view.simulation.SimulationOpenGLView;
import gameoflife.model.simulation.SimulationModel;
import mmvc.api.IViewContainer;

class GameOfLifeContext extends mmvc.impl.Context
{
    public function new( ?contextView:IViewContainer = null )
    {
        super( contextView );
    }

    override public function startup():Void
    {
        mapCommands();

        mapModels();

        mapViews();

        super.startup();
    }

    override public function shutdown():Void
    {

    }

    private function mapCommands():Void
    {
        //commandMap.mapSignalClass( CommandEvent, CommandClass);
    }

    private function mapModels():Void
    {
        injector.mapSingleton(SimulationModel);
    }

    private function mapViews():Void
    {
        mediatorMap.mapView(SimulationOpenGLView, SimulationOpenGLViewMediator);

        // wiring for main application module
        mediatorMap.mapView(GameOfLifeView, GameOfLifeViewMediator);
    }

}