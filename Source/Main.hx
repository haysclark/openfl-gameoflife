package;

import mmvc.api.IViewContainer;
import gameoflife.GameOfLifeContext;
import flash.display.Sprite;

class Main extends Sprite implements IViewContainer
{
    public var viewAdded:Dynamic -> Void;
    public var viewRemoved:Dynamic -> Void;

    public function new()
    {
        super();

        var contect = new GameOfLifeContext(this);
    }

    public function isAdded(view:Dynamic):Bool
    {
        return true;
    }
}