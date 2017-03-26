package ;

import dst.EnvMain;
import dst.Global;
import dst.EnvWorldGenMain;

@:keep
class PickMeatFirstGlobals {
	static public function test():Void {
		Main.log(Global.debuglocals(2)); 
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
			Global.CHEATS_ENABLED = true;
			Global.require("debugkeys");
			
			// enable Debug Tools methods
			Global.require("debugtools");
		#end

		untyped __lua__("rawset(GLOBAL, \"PickMeatFirstGlobals\", PickMeatFirstGlobals)");

		EnvWorldGenMain.AddLevelPreInitAny(function()
		{
			log("woot! AddLevelPreInitAny()");
		});

		EnvWorldGenMain.AddTaskSetPreInitAny(function()
		{
			log("woot! AddTaskSetPreInitAny()");
		});

		EnvWorldGenMain.AddSimPostInit(function()
		{
			log("woot! AddSimPostInit()");
			log(Global.AllRecipes.abigail_flower.builder_tag);
		});

		EnvWorldGenMain.AddGamePostInit(function()
		{
			log("woot! AddGamePostInit()");
			log(Global.AllRecipes.abigail_flower.atlas);
		});
	}
	
	public static function log(s : String)
	{
		#if debug
			trace("MikesPlugin: " + s);
		#end
	}
}