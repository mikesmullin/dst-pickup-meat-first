local pcall = GLOBAL.pcall
local getmetatable = GLOBAL.getmetatable
local setmetatable = GLOBAL.setmetatable
local rawset = GLOBAL.rawset
local select = GLOBAL.select
local debug = GLOBAL.debug
local _G = GLOBAL

-- Generated by Haxe 3.4.2 (git build master @ 890f8c7)
local _hx_array_mt = {
  __newindex = function(t,k,v)
    local len = t.length
    t.length =  k >= len and (k + 1) or len
    rawset(t,k,v)
  end
}

local function _hx_tab_array(tab,length)
  tab.length = length
  return setmetatable(tab, _hx_array_mt)
end

local function _hx_anon_newindex(t,k,v) t.__fields__[k] = true; rawset(t,k,v); end
local _hx_anon_mt = {__newindex=_hx_anon_newindex}
local function _hx_a(...)
  local __fields__ = {};
  local ret = {__fields__ = __fields__};
  local max = select('#',...);
  local tab = {...};
  local cur = 1;
  while cur < max do
    local v = tab[cur];
    __fields__[v] = true;
    ret[v] = tab[cur+1];
    cur = cur + 2
  end
  return setmetatable(ret, _hx_anon_mt)
end

local function _hx_e()
  return setmetatable({__fields__ = {}}, _hx_anon_mt)
end

local function _hx_o(obj)
  return setmetatable(obj, _hx_anon_mt)
end

local function _hx_new(prototype)
  return setmetatable({__fields__ = {}}, {__newindex=_hx_anon_newindex, __index=prototype})
end

local _hxClasses = {}
Int = (function() _hxClasses.Int = _hx_o({__fields__={__name__=true},__name__={"Int"}}); return _hxClasses.Int end)();
Dynamic = (function() 
_hxClasses.Dynamic = _hx_o({__fields__={__name__=true},__name__={"Dynamic"}}); return _hxClasses.Dynamic end)();
Float = (function() 
_hxClasses.Float = _hx_e(); return _hxClasses.Float end)();
Float.__name__ = {"Float"}
Bool = (function() 
_hxClasses.Bool = _hx_e(); return _hxClasses.Bool end)();
Bool.__ename__ = {"Bool"}
Class = (function() 
_hxClasses.Class = _hx_o({__fields__={__name__=true},__name__={"Class"}}); return _hxClasses.Class end)();
Enum = _hx_e();

local Array = _hx_e()
local PickMeatFirstGlobals = _hx_e()
local Main = _hx_e()
local String = _hx_e()
local Std = _hx_e()
local dst = {}
dst.ITheSim = _hx_e()
dst.IInst = _hx_e()
dst.Entity = _hx_e()
dst.IThePlayer = _hx_e()
dst.IThePlayerComponents = _hx_e()
dst.ILocomotor = _hx_e()
dst.ITransform = _hx_e()
dst.IActions = _hx_e()
dst.Tags = _hx_e()
dst.components = {}
dst.components.PlayerController = _hx_e()
dst.components.IPlayerControllerInst = _hx_e()
dst.components.IBufferedAction = _hx_e()
local haxe = {}
haxe.io = {}
haxe.io.Eof = _hx_e()
local lua = {}
lua.Boot = _hx_e()
lua.PairsIterator = _hx_e()
lua.PairsNextResult = _hx_e()

local _hx_bind, _hx_bit, _hx_staticToInstance, _hx_funcToField, _hx_maxn, _hx_print, _hx_apply_self, _hx_box_mr, _hx_bit_clamp, _hx_table, _hx_bit_raw

Array.new = {}
Array.prototype = _hx_a(
  'join', function(self,sep) 
    local tbl = ({});
    local _gthis = self;
    local cur_length = 0;
    local i = _hx_o({__fields__={hasNext=true,next=true},hasNext=function(self) 
      do return cur_length < _gthis.length end;
    end,next=function(self) 
      cur_length = cur_length + 1;
      do return _gthis[cur_length - 1] end;
    end});
    while (i:hasNext()) do 
      local i1 = i:next();
      _G.table.insert(tbl,Std.string(i1));
      end;
    do return _G.table.concat(tbl,sep) end
  end,
  'push', function(self,x) 
    _G.rawset(self,self.length,x);
    _G.rawset(self,"length",self.length + 1);
    do return _G.rawget(self,"length") end
  end,
  'iterator', function(self) 
    local _gthis = self;
    local cur_length = 0;
    do return _hx_o({__fields__={hasNext=true,next=true},hasNext=function(self) 
      do return cur_length < _gthis.length end;
    end,next=function(self) 
      cur_length = cur_length + 1;
      do return _gthis[cur_length - 1] end;
    end}) end
  end
)

PickMeatFirstGlobals.new = {}
PickMeatFirstGlobals.test = function() 
  Main.log(GLOBAL.debuglocals(2));
end

Main.new = {}
Main.main = function() 
  Main.log("main() starting up...");
  rawset(GLOBAL, "PickMeatFirstGlobals", PickMeatFirstGlobals);
  local isMaster = false;
  local playerController;
  env.AddClassPostConstruct("components/playercontroller",function(ctrl) 
    if (nil == GLOBAL.ThePlayer) then 
      do return end;
    end;
    if (GLOBAL.ThePlayer.userid ~= ctrl.inst.userid) then 
      do return end;
    end;
    if ("webber" ~= ctrl.inst.prefab) then 
      do return end;
    end;
    isMaster = GLOBAL.ThePlayer.ismastersim;
    playerController = ctrl;
    local getActionButtonAction;
    getActionButtonAction = ctrl.GetActionButtonAction;
    local interceptAction = function(_self,bufferedAction) 
      Main.log("interceptAction()");
      Main.log("  bufferedAction: " .. _G.tostring(bufferedAction));
      if (nil == bufferedAction) then 
        do return false end;
      end;
      if (GLOBAL.ACTIONS.PICKUP ~= bufferedAction.action) then 
        do return false end;
      end;
      local _hx_1_playerWorldPos_x, _hx_1_playerWorldPos_y, _hx_1_playerWorldPos_z = GLOBAL.ThePlayer.Transform:GetWorldPosition();
      Main.log("x: " .. _hx_1_playerWorldPos_x .. ", y: " .. _hx_1_playerWorldPos_y .. ", z: " .. _hx_1_playerWorldPos_z);
      local items = GLOBAL.TheSim:FindEntities(_hx_1_playerWorldPos_x,_hx_1_playerWorldPos_y,_hx_1_playerWorldPos_z,40,_hx_tab_array({[0]=dst.Tags.EDIBLE_MEAT }, 1),_hx_tab_array({[0]=dst.Tags.INLIMBO }, 1));
      local p = lua.PairsIterator.new(items);
      while (p:hasNext()) do 
        local p1 = p:next();
        local item = _hx_tab_array({[0]=p1.value }, 1);
        local itemWorldPos = _hx_tab_array({[0]=_hx_box_mr(_hx_table.pack(item[0].Transform:GetWorldPosition()), {"x", "y", "z"}) }, 1);
        Main.log(string.format("%s {%2.2f, %2.2f, %2.2f}",_G.tostring(item[0]),itemWorldPos[0].x,itemWorldPos[0].y,itemWorldPos[0].z));
        Main.log("  item found!");
        local act = _hx_tab_array({[0]=GLOBAL.BufferedAction(GLOBAL.ThePlayer,item[0],GLOBAL.ACTIONS.PICKUP) }, 1);
        if (isMaster) then 
          GLOBAL.ThePlayer.components.locomotor:PushAction(act[0],true);
        else
          act[0].preview_cb = (function(act1,itemWorldPos1,item1) 
            do return function() 
              GLOBAL.SendRPCToServer(GLOBAL.RPC.LeftClick,act1[0].action.code,itemWorldPos1[0].x,itemWorldPos1[0].z,item1[0],nil,false);
            end end;
          end)(act,itemWorldPos,item);
          ctrl:DoAction(act[0]);
        end;
        do return true end;
        end;
      do return false end;
    end;
    local wrapper = function(self1,forceTarget) 
      local bufferedAction1 = getActionButtonAction(self1,forceTarget);
      local result = interceptAction(self1,bufferedAction1);
      if (not result) then 
        do return bufferedAction1 end;
      end;
      do return nil end;
    end;
    ctrl.GetActionButtonAction = wrapper;
  end);
end
Main.log = function(s) 
end

String.new = {}
String.__index = function(s,k) 
  if (k == "length") then 
    do return _G.string.len(s) end;
  else
    local o = String.prototype;
    local field = k;
    if ((function() 
      local _hx_1
      if (o.__fields__ ~= nil) then 
      _hx_1 = o.__fields__[field] ~= nil; else 
      _hx_1 = o[field] ~= nil; end
      return _hx_1
    end )()) then 
      do return String.prototype[k] end;
    else
      if (String.__oldindex ~= nil) then 
        do return String.__oldindex[k] end;
      else
        do return nil end;
      end;
    end;
  end;
end
String.fromCharCode = function(code) 
  do return _G.string.char(code) end;
end
String.prototype = _hx_a(
  'toString', function(self) 
    do return self end
  end
)

Std.new = {}
Std.string = function(s) 
  do return lua.Boot.__string_rec(s) end;
end

dst.ITheSim.new = {}

dst.IInst.new = {}

dst.Entity.new = {}
dst.Entity.__interfaces__ = {dst.IInst}

dst.IThePlayer.new = {}
dst.IThePlayer.__interfaces__ = {dst.Entity}

dst.IThePlayerComponents.new = {}

dst.ILocomotor.new = {}

dst.ITransform.new = {}

dst.IActions.new = {}

dst.Tags.new = {}

dst.components.PlayerController.new = {}

dst.components.IPlayerControllerInst.new = {}

dst.components.IBufferedAction.new = {}

haxe.io.Eof.new = {}
haxe.io.Eof.prototype = _hx_a(
  'toString', function(self) 
    do return "Eof" end
  end
)

lua.Boot.new = {}
lua.Boot.isArray = function(o) 
  if (_G.type(o) == "table") then 
    if ((o.__enum__ == nil) and (_G.getmetatable(o) ~= nil)) then 
      do return _G.getmetatable(o).__index == Array.prototype end;
    else
      do return false end;
    end;
  else
    do return false end;
  end;
end
lua.Boot.printEnum = function(o,s) 
  if (o.length == 2) then 
    do return o[0] end;
  else
    local str = Std.string(o[0]) .. "(";
    s = s .. "\t";
    local _g1 = 2;
    local _g = o.length;
    while (_g1 < _g) do 
      _g1 = _g1 + 1;
      local i = _g1 - 1;
      if (i ~= 2) then 
        str = str .. ("," .. lua.Boot.__string_rec(o[i],s));
      else
        str = str .. lua.Boot.__string_rec(o[i],s);
      end;
      end;
    do return str .. ")" end;
  end;
end
lua.Boot.printClassRec = function(c,result,s) 
  if (result == nil) then 
    result = "";
  end;
  local f = lua.Boot.__string_rec;
  for k,v in pairs(c) do if result ~= '' then result = result .. ', ' end result = result .. k .. ':' .. f(v, s.. '	') end;
  do return result end;
end
lua.Boot.__string_rec = function(o,s) 
  if (s == nil) then 
    s = "";
  end;
  local _g = type(o);
  local _g1 = _g;
  if (_g1) == "boolean" then 
    do return tostring(o) end;
  elseif (_g1) == "function" then 
    do return "<function>" end;
  elseif (_g1) == "nil" then 
    do return "null" end;
  elseif (_g1) == "number" then 
    if (o == _G.math.huge) then 
      do return "Infinity" end;
    else
      if (o == -_G.math.huge) then 
        do return "-Infinity" end;
      else
        if (o ~= o) then 
          do return "NaN" end;
        else
          do return tostring(o) end;
        end;
      end;
    end;
  elseif (_g1) == "string" then 
    do return o end;
  elseif (_g1) == "table" then 
    if (o.__enum__ ~= nil) then 
      do return lua.Boot.printEnum(o,s) end;
    else
      if ((o.toString ~= nil) and not lua.Boot.isArray(o)) then 
        do return o:toString() end;
      else
        if (lua.Boot.isArray(o)) then 
          local o2 = o;
          if (s.length > 5) then 
            do return "[...]" end;
          else
            local _g2 = _hx_tab_array({ }, 0);
            local _g11 = 0;
            while (_g11 < o2.length) do 
              local i = o2[_g11];
              _g11 = _g11 + 1;
              _g2:push(lua.Boot.__string_rec(i,s .. 1));
              end;
            do return "[" .. _g2:join(",") .. "]" end;
          end;
        else
          if (o.__class__ ~= nil) then 
            do return "{" .. lua.Boot.printClassRec(o,"",s .. "\t") .. "}" end;
          else
            local fields = lua.Boot.fieldIterator(o);
            local buffer = ({});
            local first = true;
            _G.table.insert(buffer,"{ ");
            local f = fields;
            while (f:hasNext()) do 
              local f1 = f:next();
              if (first) then 
                first = false;
              else
                _G.table.insert(buffer,", ");
              end;
              _G.table.insert(buffer,"" .. Std.string(f1) .. " : " .. Std.string(o[f1]));
              end;
            _G.table.insert(buffer," }");
            do return _G.table.concat(buffer,"") end;
          end;
        end;
      end;
    end;
  elseif (_g1) == "thread" then 
    do return "<thread>" end;
  elseif (_g1) == "userdata" then 
    do return "<userdata>" end;else
  _G.error("Unknown Lua type",0); end;
end
lua.Boot.fieldIterator = function(o) 
  local tbl = (function() 
    local _hx_1
    if (o.__fields__ ~= nil) then 
    _hx_1 = o.__fields__; else 
    _hx_1 = o; end
    return _hx_1
  end )();
  local cur = _G.pairs(tbl);
  local next_valid = function(tbl1,val) 
    while (lua.Boot.hiddenFields[val] ~= nil) do 
      val = cur(tbl1,val);
      end;
    do return val end;
  end;
  local cur_val = next_valid(tbl,cur(tbl,nil));
  do return _hx_o({__fields__={next=true,hasNext=true},next=function(self) 
    local ret = cur_val;
    cur_val = next_valid(tbl,cur(tbl,cur_val));
    do return ret end;
  end,hasNext=function(self) 
    do return cur_val ~= nil end;
  end}) end;
end

lua.PairsIterator.new = function(table) 
  local self = _hx_new(lua.PairsIterator.prototype)
  lua.PairsIterator.super(self,table)
  return self
end
lua.PairsIterator.super = function(self,table) 
  self.table = table;
end
lua.PairsIterator.prototype = _hx_a(
  'hasNext', function(self) 
    self.result = _hx_box_mr(_hx_table.pack(_G.next(self.table,(function() 
      local _hx_1
      if (nil == self.result) then 
      _hx_1 = nil; else 
      _hx_1 = self.result.index; end
      return _hx_1
    end )())), {"index", "value"});
    do return nil ~= self.result.index end
  end,
  'next', function(self) 
    do return lua.PairsNextResult.new(self.result.index,self.result.value) end
  end
)

lua.PairsNextResult.new = function(index,value) 
  local self = _hx_new()
  lua.PairsNextResult.super(self,index,value)
  return self
end
lua.PairsNextResult.super = function(self,index,value) 
  self.index = index;
  self.value = value;
end
local _hx_string_mt = _G.getmetatable('');
String.__oldindex = _hx_string_mt.__index;
_hx_string_mt.__index = String.__index;
_hx_string_mt.__add = function(a,b) return Std.string(a)..Std.string(b) end;
_hx_string_mt.__concat = _hx_string_mt.__add
_hx_array_mt.__index = Array.prototype

local _hx_static_init = function()
  dst.Tags.INLIMBO = "INLIMBO"
  dst.Tags.EDIBLE_MEAT = "edible_MEAT"
  lua.Boot.hiddenFields = {__id__=true, hx__closures=true, super=true, prototype=true, __fields__=true, __ifields__=true, __class__=true, __properties__=true}
  
end

_hx_box_mr = function(x,nt)
   res = _hx_o({__fields__={}})
   for i,v in ipairs(nt) do
     res[v] = x[i]
   end
   return res
end
_hx_table = {}
_hx_table.pack = _G.table.pack or function(...)
    return {...}
end
_hx_table.unpack = _G.table.unpack or _G.unpack
_hx_table.maxn = _G.table.maxn or function(t)
  local maxn=0;
  for i in pairs(t) do
    maxn=type(i)=='number'and i>maxn and i or maxn
  end
  return maxn
end;
_hx_static_init();
Main.main()
return _hx_exports
