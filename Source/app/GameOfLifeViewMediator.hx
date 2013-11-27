package app;

/**
Main application view mediator.

Responsible for triggering sub view creation once application is wired up to the context

@see GameOfLifeView
*/
class GameOfLifeViewMediator extends mmvc.impl.Mediator<GameOfLifeView>
{
	public function new()
	{
		super();
	}

	/**
	Context has now been initialized. Time to create the rest of the main views in the application
	@see mmvc.impl.Mediator.onRegister()
	*/
	override function onRegister()
	{
		super.onRegister();
		view.createViews();
	}

	/**
	@see mmvc.impl.Mediator
	*/
	override public function onRemove():Void
	{
		super.onRemove();
	}
}