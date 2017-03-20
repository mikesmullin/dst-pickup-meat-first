package;

extern class GLOBAL {
	static public var CHEATS_ENABLED : Bool; // = false;
	static public function require(file : String) : Void;
}

@:native("GLOBAL")
extern class DST
{

	// Debug and utility helper functions
	static public function debuglocals(level : Int) : String;

	// Asset Definitions
	static public var AllRecipes : AllRecipes;

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

class AllRecipes
{
	public var abigail_flower : Recipe;
}


@:keep
//@:native("_G.PickMeatFirstGlobals")
class PickMeatFirstGlobals {
	static public function test():Void {
		Main.log(DST.debuglocals(2)); 
	}
}

class Main
{
	private static var isMaster : Bool = false;
	//private static var PlayerController;

	public static function main() 
	{
		Macro.dontStarvePreInit();
		log("main() starting up...");
		
		#if debug
			log("debug mode is enabled.");
			// enable Debug Keys feature
			// - CTRL-R:  jumps from in game to the main menu and reloads all your scripts.
			// - Shift-Right: jumps from main menu into the first save slot.
			// - 0: jump to caves.
			GLOBAL.CHEATS_ENABLED = true;
			GLOBAL.require("debugkeys");
			
			// enable Debug Tools methods
			GLOBAL.require("debugtools");
		#end

		untyped __lua__("rawset(GLOBAL, \"PickMeatFirstGlobals\", PickMeatFirstGlobals)");
		
		DST.AddSimPostInit(function()
		{
			log("woot!");
			log(DST.AllRecipes.abigail_flower.atlas);
		});
	}
	
	public static function log(s : String)
	{
		#if debug
			trace("MikesPlugin: " + s);
		#end
	}
}

interface RecipeIngredient 
{
	public var amount: Int;
	public var atlas: String;
	public var type: String;
}

interface RecipeLevel
{
	public var ANCIENT: Int;
	public var CARTOGRAPHY: Int;
	public var MAGIC: Int;
	public var ORPHANAGE: Int;
	public var PERDOFFERING: Int;
	public var SCIENCE: Int;
	public var SCULPTING: Int;
	public var SHADOW: Int;
}

interface RecipeTab 
{
	public var icon : String;
	public var sort : Int;
	public var str : String;
}

interface Recipe 
{
	public var atlas : String;
	public var builder_tag : String;
	public var character_ingredients : Dynamic;
	public var image : String;
	public var ingredients : Array<RecipeIngredient>; 
	public var level : RecipeLevel;
	public var min_spacing : Float;
	public var name	 : String;
	public var nounlock : Bool;
	public var numtogive : Int;
	public var product : String;
	public var rpc_id : Int;
	public var sortkey : Int;
	public var tab : RecipeTab;
	public var tech_ingredients	: Dynamic;
}