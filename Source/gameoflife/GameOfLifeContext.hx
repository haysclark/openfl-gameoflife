/*
 * Created by IntelliJ IDEA.
 * User: hays
 * Date: 11/26/13
 * Time: 11:43 PM
 */
package gameoflife;

import mmvc.api.IViewContainer;

class GameOfLifeContext extends mmvc.impl.Context
{
    public function new( ?contextView:IViewContainer = null )
    {
        super( contextView );
    }

    override public function startup()
    {
        trace( "startup!");
    }

    override public function shutdown()
    {

    }
}