package ;

import dst.EnvMain;
import dst.Global;
import dst.EnvWorldGenMain;
import dst.components.PlayerController;
import lua.Lua;
import lua.MyPairTools;
import lua.MyStringTools;
import lua.Table;

@:keep
class PickMeatFirstGlobals
{
	static public function test():Void
	{
		Main.log(Global.debuglocals(2));
	}
}

class Main
{
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
			Global.require("debugtools");
			Global.require("debughelpers");
		#end

		untyped __lua__("rawset(GLOBAL, \"PickMeatFirstGlobals\", PickMeatFirstGlobals)");

		var CONES = lua.Table.create({ pinecone: 1, acorn: 1, twiggy_nut: 1 });
		var isMaster : Bool = false;
		var playerController : PlayerController;

		EnvWorldGenMain.AddClassPostConstruct("components/playercontroller", function(ctrl : PlayerController)
		{
			log("woot! AddClassPostConstruct()");

			if (null == Global.ThePlayer) return; // if local player doesn't exist yet
			if (Global.ThePlayer.userid != ctrl.inst.userid) return; // if player controller is not for local player
			//if ("woodie" != ctrl.inst.prefab) return; // must be a Woodie // not anymore! credit: Cordae
			isMaster = Global.ThePlayer.ismastersim; // if not hosting, we must send RPCs
			playerController = ctrl;

			var getActionButtonAction;
			// TODO: solve problem with generator losing self definition    local getActionButtonAction = _hx_bind(ctrl,ctrl.GetActionButtonAction);   
			//= ctrl.GetActionButtonAction;
			untyped __lua__("getActionButtonAction = ctrl.GetActionButtonAction");

			var interceptAction = function(self : PlayerController, bufferedAction : IBufferedAction) : Bool
			{
				log("interceptAction()");
				log("  self: " + Lua.tostring(self));
				log("  bufferedAction: " + Lua.tostring(bufferedAction));
				if (null == bufferedAction) return false; // don't intercept
				log("  bufferedAction.action: " + Lua.tostring(bufferedAction.action));
				if (Global.ACTIONS.PICKUP != bufferedAction.action) return false;  // don't intercept
				// TODO: difference between PICKUP and PICK? PROBABLY SUPPORT BOTH
				var playerWorldPos = Global.ThePlayer.Transform.GetWorldPosition();
				log("x: " + playerWorldPos.x + ", y: " + playerWorldPos.y +", z: " + playerWorldPos.z);
				var items = Global.TheSim.FindEntities(playerWorldPos.x, playerWorldPos.y, playerWorldPos.z, self.directwalking ? 3 : 6, null, [Tags.INLIMBO]);

				for (p1 in new PairsIterator(CONES))
				{
					var target = p1.index;
					for (p2 in new PairsIterator(items))
					{
						var item = p2.value;
						var itemWorldPos = item.Transform.GetWorldPosition();
						if (target == item.prefab)
						{
							log(MyStringTools.format("%s {%2.2f, %2.2f, %2.2f}", Lua.tostring(item), itemWorldPos.x, itemWorldPos.y, itemWorldPos.z));
							//Global.DumpEntity(item);
							log("  item found!");
							return true;
						}
					}

				}
				return false;
			};

			log("replacing GetActionButtonAction");
			var wrapper = function(self : Dynamic, forceTarget : Dynamic) : Dynamic
			{
				log("replacement GetActionButtonAction");
				log("  self: " + Lua.tostring(self));
				log("  forceTarget: " + Lua.tostring(forceTarget));
				var bufferedAction = getActionButtonAction(self, forceTarget);
				var result : Bool = interceptAction(self, bufferedAction);
				if (!result)
				{
					return bufferedAction;
				}
				return null;
			};
			// TODO: solve problem with generator losing self definition      ctrl.GetActionButtonAction = _hx_funcToField(wrapper);
			untyped __lua__("ctrl.GetActionButtonAction = wrapper");
		});
	}

	public static function log(s : String)
	{
		#if debug
		trace("MikesPlugin: " + s);
		#end
	}
}