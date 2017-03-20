package ;

import dst.Global;
import dst.Env;
import dst.Types;

@:keep
//@:native("_G.PickMeatFirstGlobals")
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
		
		Env.AddSimPostInit(function()
		{
			log("woot!");
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