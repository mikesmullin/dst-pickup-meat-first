package dst;

import dst.Types.IAllRecipes;

@:native("GLOBAL")
extern class Global
{
	// Debug and utility helper functions
	static public var CHEATS_ENABLED : Bool; // = false;
	static public function require(file : String) : Void;
	static public function debuglocals(level : Int) : String;

	// Asset Definitions
	static public var AllRecipes : IAllRecipes;
}