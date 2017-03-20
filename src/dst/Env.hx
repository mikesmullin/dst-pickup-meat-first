package dst;

@:native("env")
extern class Env
{
	
	// Events

	/**
	 * Appends a handler for your action (or an existing action!) to an
	 * existing stategraph.
	 */
	static public function AddStategraphActionHandler(stateGraphName : String, newActionHandler : Void -> Void) : Void;

	/**
	 * Use this to modify and mangle existing stategraphs, such as digging
	 * into existing states or appending new functionality to existing
	 * handlers.
	 */
	static public function AddStategraphPostInit(stateGraphName : String, initFn : Void -> Void) : Void;

	/**
	 * Lets you modify a brain after it's been initialized. The most useful
	 * part is probably adding or removing nodes from brain.bt, which is the
	 * brain's behaviour tree.
	 *
	 * Note that "brainname" is the name of the lua file in scripts/brains/.
	 */
	static public function AddBrainPostInit(brainName : String, initFn : Void->Void) : Void;

	/**
	 * Use this to modify a component's properties or behavior
	 */
	static public function AddComponentPostInit(componentName : String, initFn : Void->Void) : Void;

	/**
	 * Use this to modify a prefab by adding, removing, or editing its properties
	 * and components.
	 */
	static public function AddPrefabPostInit(prefabName : String, initFn : Void->Void) : Void;

	/**
	 * Use this to run a function after a class's constructor runs. The initFn
	 * should have the same signature as the class's constructor.
	 * Use this to run a function after a class's constructor runs, when that
	 * class is returned directly from the file. The initFn should have the
	 * same signature as the class's constructor.
	 */
	 static public function AddClassPostConstruct(pathToFile : String, initFn : Void->Void) : Void;

	/**
	 * Use this to run a function after a class's constructor runs, when that
	 * class is placed into the global table. The initFn should have the same
	 * signature as the class's constructor.
	 */
	 static public function AddGlobalClassPostConstruct(pathToFile : String, className : String, initFn : Void->Void) : Void;

	/**
	 * This returns the player charcter once the game has loaded. Use this to
	 * modify and player character on startup, or to play with the game state
	 * and world state.
	 */
	static public function AddSimPostInit(initFn : Void->Void) : Void;
}