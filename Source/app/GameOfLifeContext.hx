/*
 * Created by IntelliJ IDEA.
 * User: hays
 * Date: 11/26/13
 * Time: 11:43 PM
 */
package app;

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
        //injector.mapSingleton(ModelClass);
    }

    private function mapViews():Void
    {
        //mediatorMap.mapView(ViewClass, ViewClassMediator);

        // wiring for main application module
        mediatorMap.mapView(GameOfLifeView, GameOfLifeViewMediator);
    }

}