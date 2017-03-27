package lua;

import haxe.extern.Rest;

@:native("string")
extern class MyStringTools
{
	static public function format(str : String, fillers : Rest<Dynamic>) : String;
}