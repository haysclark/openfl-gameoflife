package app;

import core.SpriteView;

/**
Main Application View.

Implements IViewContainer to provide view added/removed events back to the Context.mediatorMap

Extends core view class for basic event bubbling across platforms

@see mmvc.api.IViewContainer
*/
class GameOfLifeView extends SpriteView implements mmvc.api.IViewContainer
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
		//var childView = new ChildView();
		//addChild(childView);
	}

	/**
	Overrides signal bubbling to trigger view added/removed handlers for IViewContainer
	@param event 	a string event type
	@param view 	instance of view that originally dispatched the event
	*/
	override public function dispatch(event:String, view:SpriteView)
	{
		switch(event)
		{
			case SpriteView.ADDED:
			{
				viewAdded(view);
			}
			case SpriteView.REMOVED:
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

	/**
	Overrides View.initialize to add to top level platform specific sprite/element
	*/
	override function initialize()
	{
		super.initialize();
	}
}