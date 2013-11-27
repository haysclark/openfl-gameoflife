package app;

import gameoflife.view.simulation.SimulationOpenGLView;
import core.DisplayObjectView;

/**
Main Application View.

Implements IViewContainer to provide view added/removed events back to the Context.mediatorMap

Extends core view class for basic event bubbling across platforms

@see mmvc.api.IViewContainer
*/
class GameOfLifeView extends DisplayObjectView implements mmvc.api.IViewContainer
{
	public var viewAdded:Dynamic -> Void;
	public var viewRemoved:Dynamic -> Void;

	public function new(main:Main)
	{
		super();
        sprite = main;
	}

	/**
	Called by ApplicationViewMediator once application is wired up to the context
	@see ApplicationViewMediator.onRegister;
	*/
	public function createViews()
	{
		var childView = new SimulationOpenGLView();
		addChild(childView);
	}

	/**
	Overrides signal bubbling to trigger view added/removed handlers for IViewContainer
	@param event 	a string event type
	@param view 	instance of view that originally dispatched the event
	*/
	override public function dispatch(event:String, view:DisplayObjectView)
	{
		switch(event)
		{
			case DisplayObjectView.ADDED:
			{
				viewAdded(view);
			}
			case DisplayObjectView.REMOVED:
			{
				viewRemoved(view);
			}
			default:
			{
				super.dispatch(event, view);
			}
		}
	}

	/**
	Required by IViewContainer
	*/
	public function isAdded(view:Dynamic):Bool
	{
		return true;
	}
}