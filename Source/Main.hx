/*
 * Created by IntelliJ IDEA.
 * User: hays
 * Date: 11/26/13
 * Time: 11:43 PM
 */
package;

import app.GameOfLifeContext;
import app.GameOfLifeView;
import flash.display.Sprite;

class Main extends Sprite
{
    public function new()
    {
        super();

        var view = new GameOfLifeView(this);
        var contect = new GameOfLifeContext(view);
    }
}