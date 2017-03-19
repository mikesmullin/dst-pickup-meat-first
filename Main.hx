package;

extern class GLOBAL {
	static public var CHEATS_ENABLED : Bool; // = false;
	static public function require(file : String) : Void;
}

@:native("GLOBAL")
extern class Placeholder {
	static public function debuglocals(level : Int) : String;
}

@:keep
class PickMeatFirstGlobals {
	static public function test():Void {
		trace(Placeholder.debuglocals(2)); 
	}
}

class Main 
{
	private static var isMaster : Bool = false;
	//private static var PlayerController;

	public static function log(s : String)
	{
		untyped __lua__("GLOBAL.PickMeatFirstGlobals = PickMeatFirstGlobals");
		#if debug
			trace("MikesPlugin: " + s);
		#end
	}
	
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
	}
}