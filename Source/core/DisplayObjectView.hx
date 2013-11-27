package core;

import flash.display.DisplayObjectContainer;
import flash.display.DisplayObject;
import flash.display.Sprite;

import msignal.Signal;

/**
Simple implementation of a Sprite View class that composes a
sprite and adds needed signals. Based on View in MMVC example.

Contains a basic display lifecycle (initialize, update, remove)
Contains a basic display heirachy (addChild, removeChild)
Contains basic dispatching and bubbling via a Signal (dispatch)

Each target has a platform specific element for accessing the raw display API (flash: sprite)

@see msignal.Signal
*/
class DisplayObjectView
{
	/**
	Event type dispatched when view is added to stage
	@see SpriteView.addChild()
	*/
	inline public static var ADDED:String = "added";

	/**
	Event type dispatched when view is removed from stage
	@see SpriteView.removeChild()
	*/
	inline public static var REMOVED:String = "removed";

	/**
	Event type dispatched when view is actioned (e.g. clicked)
	*/
	inline public static var ACTIONED:String = "actioned";

	/**
	private counter to maintain unique identifieds for created views
	*/
	static var idCounter:Int = 0;

	/**
	Unique identifier (viewXXX);
	*/
	public var id(default, null):String;
	
	/**
	reference to parent view (if available)
	@see SpriteView.addChild()
	@see SpriteView.removeChild()
	*/
	public var parent(default, null):DisplayObjectView;

	/**
	reference to the index relative to siblings
	defaults to -1 when view has no parent 
	@see SpriteView.addChild()
	*/
	public var index(default, set_index):Int;

	/**
	Signal used for dispatching view events
	Usage:
		SpriteView.addListener(viewHandler);
		...
		function viewHandler(event:String, view:View);
	*/
	public var signal(default, null):Signal2<String, DisplayObjectView>;

	/**
	native flash sprite representing this view in the display list
	*/
	public var sprite(default, null):DisplayObject;

	/**
	Contains all children currently added to view
	*/
	var children:Array<DisplayObjectView>;

	/**
	String representation of unqualified class name
	(e.g. example.core.SpriteView.className == "View");
	*/
	var className:String;

	public function new()
	{
		//create unique identifier for this view
		id = "view" + (idCounter ++);

		//set default index without triggering setter
		Reflect.setField(this, "index", -1);

		className = Type.getClassName(Type.getClass(this)).split(".").pop();
		
		children = [];
		signal = new Signal2<String, DisplayObjectView>();
		
		initialize();
	}

	public function toString():String
	{
		return className + "(" + id + ")";
	}

	/**
	dispatches a view event via the signal
	@param event 	string event type
	@param view 	originating view object
	*/
	public function dispatch(event:String, view:DisplayObjectView)
	{
		if(view == null)
        {
            view = this;
        }
		signal.dispatch(event, view);
	}

	/**
	Adds a child view to the display heirachy.
	
	Dispatches an ADDED event on completion.

	@param view 	child to add
	*/
	public function addChild(view:DisplayObjectView)
	{
        if (!Std.is (sprite, DisplayObjectContainer)) {
            //Parent is not a DisplayObjectContainer
            return;
        }

		view.signal.add(this.dispatch);
		view.parent = this;
		view.index = children.length;

		children.push(view);

        var doc = cast (sprite, DisplayObjectContainer);
        doc.addChild(view.sprite);

		dispatch(ADDED, view);
	}


	/**
	Removes an existing child view from the display heirachy.
	
	Dispatches an REMOVED event on completion.

	@param view 	child to remove
	*/
	public function removeChild(view:DisplayObjectView)
	{
		var removed = children.remove(view);
		if(removed && Std.is (sprite, DisplayObjectContainer))
		{
			var oldIndex = view.index;

			view.remove();
			view.signal.remove(this.dispatch);
			view.parent = null;
			view.index = -1;

            var doc = cast (sprite, DisplayObjectContainer);
            doc.removeChild(view.sprite);

			for(i in oldIndex...children.length)
			{
				var view = children[i];
				view.index = i;
			}

			dispatch(REMOVED, view);
		}
	}

	///// internal //////

	/**
	Initializes platform specific properties and state
	*/
	function initialize()
	{
		sprite = new Sprite();
	}

	/**
	Removes platform specific properties and state
	*/
	function remove()
	{
		//override in sub class
	}

	/**
	Updates platform specific properties and state
	*/
	function update()
	{
		//override in sub class
	}

	/**
	Sets index and triggers an update when index changes
	@param value 	target index
	*/
	function set_index(value:Int):Int
	{
		if(index != value)
		{
			index = value;
			update();
		}
		
		return index;
	}

}
