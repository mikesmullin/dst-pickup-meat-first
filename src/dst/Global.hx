package dst;

import dst.Global.IInst;
import dst.Global.ITransform;
import dst.Types.IAllRecipes;
import haxe.extern.Rest;

@:native("GLOBAL")
extern class Global
{
	// Debug and utility helper functions
	static public var CHEATS_ENABLED : Bool; // = false;
	static public function require(file : String) : Void;
	static public function debuglocals(level : Int) : String;

	// Asset Definitions
	static public var AllRecipes : IAllRecipes;
	static public var ThePlayer : IThePlayer;
	static public var TheSim : ITheSim;
	static public var ACTIONS : IActions;
}

interface ITheSim
{
	public function FindEntities(x : Float, y : Float, z : Float, radius : Float, /* filterFn : IInst -> Bool, maxCount : Int, */ ? andTags : Array<String>, ? notTags : Array<String>, ? orTags : Array<String>) : lua.Table<Dynamic, Entity>;
}

interface IThePlayer extends Entity
{
	public var userid : Int;
	public var ismastersim : Bool;
}

interface IInst
{
	public var prefab : String;
}

interface Entity extends IInst
{
	public var Transform : ITransform;
}

interface ITransform
{
	public function GetWorldPosition() : Position;
}

@:multiReturn
extern class Position
{
	var x : Int;
	var y : Int;
	var z : Int;
}

interface IActions
{
	public var PICKUP : Dynamic;
}

class Tags
{
	static public var INLIMBO : String = "INLIMBO";
}