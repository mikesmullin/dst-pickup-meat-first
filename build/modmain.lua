local pcall = GLOBAL.pcall
local getmetatable = GLOBAL.getmetatable
local setmetatable = GLOBAL.setmetatable
local rawset = GLOBAL.rawset
local select = GLOBAL.select
local debug = GLOBAL.debug
local _G = GLOBAL

local _hx_array_mt = {
  __newindex = function(t,k,v)
    if type(k) == 'number' and k >= t.length then
      t.length = k + 1
    end
    rawset(t,k,v)
  end
}

local function _hx_tabArray(tab,length)
  tab.length = length
  return setmetatable(tab, _hx_array_mt)
end

local _hx_print = print or (function()end)


table.pack=table.pack or pack or function(...) return { n=select('#',...),...} end
table.unpack=table.unpack or unpack or function(t, i) i = i or 1 if t[i] ~= nil then return t[i], table.unpack(t, i + 1) end end
table.maxn=table.maxn or function(t) local maxn=0 for i in pairs(t) do maxn=type(i)=='number'and i>maxn and i or maxn end return maxn end

local _hx_bit
pcall(require, 'bit32') pcall(require, 'bit')
local _hx_bit_raw = bit or bit32

local function _hx_bit_clamp(v) return _hx_bit_raw.band(v, 2147483647 ) - _hx_bit_raw.band(v, 2147483648) end

if type(jit) == 'table' then
  _hx_bit = setmetatable({},{__index = function(t,k) return function(...) return _hx_bit_clamp(rawget(_hx_bit_raw,k)(...)) end end})
else
  _hx_bit = setmetatable({}, { __index = _hx_bit_raw })
  _hx_bit.bnot = function(...) return _hx_bit_clamp(_hx_bit_raw.bnot(...)) end
end

local function _hx_functionToInstanceFunction(f)
  if type(f) == "function" then 
    return function(self,...) 
      return f(...) 
    end
  else 
    return f
  end
end
    

local function _hx_staticToInstance(tab)
  return setmetatable({}, {
    __index = function(t,k)
      if type(rawget(tab,k)) == 'function' then 
	return function(self,...)
	  return rawget(tab,k)(...)
	end
      else
	return rawget(tab,k)
      end
    end
  })
end

local function _hx_apply(f, ...)
  return f(...)
end
local function _hx_apply_self(self, f, ...)
  return self[f](self,...)
end

local function _hx_anon_newindex(t,k,v) t.__fields__[k] = true; rawset(t,k,v); end
local _hx_anon_mt = {__newindex=_hx_anon_newindex}
local function _hx_anon(...)
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

local function _hx_empty()
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
_hxClasses.Float = _hx_empty(); return _hxClasses.Float end)();
Float.__name__ = {"Float"}
Bool = (function() 
_hxClasses.Bool = _hx_empty(); return _hxClasses.Bool end)();
Bool.__ename__ = {"Bool"}
Class = (function() 
_hxClasses.Class = _hx_o({__fields__={__name__=true},__name__={"Class"}}); return _hxClasses.Class end)();
Enum = _hx_empty();

local Array = _hx_empty() local Date = _hx_empty() local PickMeatFirstGlobals = _hx_empty() local Main = _hx_empty() local Math = _hx_empty() local Reflect = _hx_empty() local String = _hx_empty() local Std = _hx_empty() local StringBuf = _hx_empty() local haxe = {}
haxe.Log = _hx_empty() haxe.ds = {}
haxe.ds.ArraySort = _hx_empty() haxe.io = {}
haxe.io.Eof = _hx_empty() local lua = {}
lua.Boot = _hx_empty() lua.UserData = _hx_empty() lua.PairTools = _hx_empty() lua.Thread = _hx_empty() 
local _hx_bind

Array.new = function() 
  local self = _hx_new(Array.prototype)
  Array.super(self)
  return self
end

Array.super = function(self) 
  local tab = self;
  
  local length = 0;
  if ((length) == (nil)) then 
    length = (_G.table.maxn(tab)) + (1);
  end;
  _hx_tabArray(tab,length);
end
Array.__name__ = true

Array.prototype = _hx_anon(
  'concat', function(self,a) 
    local _g = _hx_tabArray({ }, 0);
    
    local _g1 = 0;
    local _g2 = self;
    while ((_g1) < (_g2.length)) do 
      
      local i = _g2[_g1];
      _g1 = (_g1) + (1);
      _g:push(i);
    
    end;
    
    local _g3 = 0;
    while ((_g3) < (a.length)) do 
      
      local i1 = a[_g3];
      _g3 = (_g3) + (1);
      _g:push(i1);
    
    end;
    do return _g end
  end,
  'join', function(self,sep) 
    local sb = StringBuf.new();
    local first = true;
    
    local _gthis = self;
    local cur_length = 0;
    local tmp = _hx_o({__fields__={hasNext=true,next=true},hasNext=function() 
      do return (cur_length) < (_gthis.length) end;
    end,next=function() 
      cur_length = (cur_length) + (1);
      do return _gthis[(cur_length) - (1)] end;
    end});
    while (tmp:hasNext()) do 
      
      local i = tmp:next();
      if (first) then 
        first = false;
      else
        sb:add(sep);
      end;
      sb:add(Std.string(i));
    
    end;
    do return _G.table.concat(sb.b) end
  end,
  'pop', function(self) 
    if ((self.length) == (0)) then 
      do return nil end;
    else
      
      local tmp = ((function() 
      local _hx_obj = self;
      local _hx_fld = 'length';
      local _ = _hx_obj[_hx_fld];
      _hx_obj[_hx_fld] = _hx_obj[_hx_fld]  - 1;
       return _;
       end)()) - (1);
      do return self[tmp] end;
    end;
  end,
  'push', function(self,x) 
    self[(function() 
    local _hx_obj = self;
    local _hx_fld = 'length';
    local _ = _hx_obj[_hx_fld];
    _hx_obj[_hx_fld] = _hx_obj[_hx_fld]  + 1;
     return _;
     end)()] = x;
    do return self.length end
  end,
  'reverse', function(self) 
    local tmp
    local i = 0;
    while (true) do 
      
      local x = (self.length) / (2);
      if (not ((i) < (((function() 
        local _hx_1
        if ((x) > (0)) then 
        _hx_1 = _G.math.floor(x); else _hx_1 = _G.math.ceil(x); end
        return _hx_1
      end )())))) then 
        break;
      end;
      tmp = self[i];
      self[i] = self[((self.length) - (i)) - (1)];
      self[((self.length) - (i)) - (1)] = tmp;
      i = (i) + (1);
    
    end;
  end,
  'shift', function(self) 
    if ((self.length) == (0)) then 
      do return nil end;
    end;
    local ret = self[0];
    
    local _g1 = 0;
    local _g = self.length;
    while ((_g1) < (_g)) do 
      
      _g1 = (_g1) + (1);
      local i = (_g1) - (1);
      self[i] = self[(i) + (1)];
    
    end;
    (function() return (function() 
    local fld = 'length';
    local obj = self;
    obj[fld] = (obj.length) - (1);
    return obj[fld] end)() end)();
    do return ret end
  end,
  'slice', function(self,pos,_end) 
    if (((_end) == (nil)) or ((_end) > (self.length))) then 
      _end = self.length;
    else
      if ((_end) < (0)) then 
        _end = _G.math.fmod(((self.length) - (_G.math.fmod(-_end, self.length))), self.length);
      end;
    end;
    if ((pos) < (0)) then 
      pos = _G.math.fmod(((self.length) - (_G.math.fmod(-pos, self.length))), self.length);
    end;
    if (((pos) > (_end)) or ((pos) > (self.length))) then 
      do return _hx_tabArray({ }, 0) end;
    end;
    local ret = _hx_tabArray({ }, 0);
    
    local _g1 = pos;
    local _g = _end;
    while ((_g1) < (_g)) do 
      
      _g1 = (_g1) + (1);
      ret:push(self[(_g1) - (1)]);
    
    end;
    do return ret end
  end,
  'sort', function(self,f) 
    haxe.ds.ArraySort.sort(self,f);
    do return end
  end,
  'splice', function(self,pos,len) 
    if (((len) < (0)) or ((pos) > (self.length))) then 
      do return _hx_tabArray({ }, 0) end;
    else
      if ((pos) < (0)) then 
        pos = (self.length) - (_G.math.fmod(-pos, self.length));
      end;
    end;
    local b = (self.length) - (pos);
    len = (function() 
      local _hx_1
      if ((Math.isNaN(len)) or (Math.isNaN(b))) then 
      _hx_1 = 0/0; else _hx_1 = _G.math.min(len,b); end
      return _hx_1
    end )();
    local ret = _hx_tabArray({ }, 0);
    
    local _g1 = pos;
    local _g = (pos) + (len);
    while ((_g1) < (_g)) do 
      
      _g1 = (_g1) + (1);
      local i = (_g1) - (1);
      ret:push(self[i]);
      self[i] = self[(i) + (len)];
    
    end;
    
    local _g11 = (pos) + (len);
    local _g2 = self.length;
    while ((_g11) < (_g2)) do 
      
      _g11 = (_g11) + (1);
      local i1 = (_g11) - (1);
      self[i1] = self[(i1) + (len)];
    
    end;
    (function() return (function() 
    local fld = 'length';
    local obj = self;
    obj[fld] = (obj.length) - (len);
    return obj[fld] end)() end)();
    do return ret end
  end,
  'toString', function(self) 
    local sb_b = _hx_empty();
    _G.table.insert(sb_b,"[");
    _G.table.insert(sb_b,Std.string(self:join(",")));
    _G.table.insert(sb_b,"]");
    do return _G.table.concat(sb_b) end
  end,
  'unshift', function(self,x) 
    local len = self.length;
    
    local _g1 = 0;
    while ((_g1) < (len)) do 
      
      _g1 = (_g1) + (1);
      local i = (_g1) - (1);
      self[(len) - (i)] = self[((len) - (i)) - (1)];
    
    end;
    self[0] = x;
  end,
  'insert', function(self,pos,x) 
    if ((pos) > (self.length)) then 
      pos = self.length;
    end;
    if ((pos) < (0)) then 
      
      pos = (self.length) + (pos);
      if ((pos) < (0)) then 
        pos = 0;
      end;
    end;
    local cur_len = self.length;
    while ((cur_len) > (pos)) do 
      
      self[cur_len] = self[(cur_len) - (1)];
      cur_len = (cur_len) - (1);
    
    end;
    self[pos] = x;
  end,
  'remove', function(self,x) 
    
    local _g1 = 0;
    local _g = self.length;
    while ((_g1) < (_g)) do 
      
      _g1 = (_g1) + (1);
      local i = (_g1) - (1);
      if ((self[i]) == (x)) then 
        
        
        local _g3 = i;
        local _g2 = (self.length) - (1);
        while ((_g3) < (_g2)) do 
          
          _g3 = (_g3) + (1);
          local j = (_g3) - (1);
          self[j] = self[(j) + (1)];
        
        end;
        self[(self.length) - (1)] = nil;
        
        self.length = self.length - 1;
        do return true end;
      end;
    
    end;
    do return false end
  end,
  'indexOf', function(self,x,fromIndex) 
    local _end = self.length;
    if ((fromIndex) == (nil)) then 
      fromIndex = 0;
    else
      if ((fromIndex) < (0)) then 
        
        fromIndex = (self.length) + (fromIndex);
        if ((fromIndex) < (0)) then 
          fromIndex = 0;
        end;
      end;
    end;
    
    local _g1 = fromIndex;
    while ((_g1) < (_end)) do 
      
      _g1 = (_g1) + (1);
      local i = (_g1) - (1);
      if ((x) == (self[i])) then 
        do return i end;
      end;
    
    end;
    do return -1 end
  end,
  'lastIndexOf', function(self,x,fromIndex) 
    if (((fromIndex) == (nil)) or ((fromIndex) >= (self.length))) then 
      fromIndex = (self.length) - (1);
    else
      if ((fromIndex) < (0)) then 
        
        fromIndex = (self.length) + (fromIndex);
        if ((fromIndex) < (0)) then 
          do return -1 end;
        end;
      end;
    end;
    local i = fromIndex;
    while ((i) >= (0)) do 
      if ((self[i]) == (x)) then 
        do return i end;
      else
        i = (i) - (1);
      end;
    
    end;
    do return -1 end
  end,
  'copy', function(self) 
    local _g = _hx_tabArray({ }, 0);
    
    local _g1 = 0;
    local _g2 = self;
    while ((_g1) < (_g2.length)) do 
      
      local i = _g2[_g1];
      _g1 = (_g1) + (1);
      _g:push(i);
    
    end;
    do return _g end
  end,
  'map', function(self,f) 
    local _g = _hx_tabArray({ }, 0);
    
    local _g1 = 0;
    local _g2 = self;
    while ((_g1) < (_g2.length)) do 
      
      local i = _g2[_g1];
      _g1 = (_g1) + (1);
      _g:push(f(i));
    
    end;
    do return _g end
  end,
  'filter', function(self,f) 
    local _g = _hx_tabArray({ }, 0);
    
    local _g1 = 0;
    local _g2 = self;
    while ((_g1) < (_g2.length)) do 
      
      local i = _g2[_g1];
      _g1 = (_g1) + (1);
      if (f(i)) then 
        _g:push(i);
      end;
    
    end;
    do return _g end
  end,
  'iterator', function(self) 
    local _gthis = self;
    local cur_length = 0;
    do return _hx_o({__fields__={hasNext=true,next=true},hasNext=function() 
      do return (cur_length) < (_gthis.length) end;
    end,next=function() 
      cur_length = (cur_length) + (1);
      do return _gthis[(cur_length) - (1)] end;
    end}) end
  end
  ,'__class__',  Array
)

Date.new = {}
Date.__name__ = true

Date.prototype = _hx_anon(
  'getHours', function(self) 
    do return self.d.hour end
  end,
  'getMinutes', function(self) 
    do return self.d.min end
  end,
  'getSeconds', function(self) 
    do return self.d.sec end
  end,
  'getFullYear', function(self) 
    do return self.d.year end
  end,
  'getMonth', function(self) 
    do return (self.d.month) - (1) end
  end,
  'getDate', function(self) 
    do return self.d.day end
  end,
  'toString', function(self) 
    do return lua.Boot.dateStr(self) end
  end
  ,'__class__',  Date
)

PickMeatFirstGlobals.new = {}
PickMeatFirstGlobals.__name__ = true
PickMeatFirstGlobals.test = function() 
  haxe.Log.trace(GLOBAL.debuglocals(2),_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=16,className="PickMeatFirstGlobals",methodName="test"}));
end


Main.new = {}
Main.__name__ = true
Main.log = function(s) 
  GLOBAL.PickMeatFirstGlobals = PickMeatFirstGlobals;
  haxe.Log.trace("MikesPlugin: " .. s,_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=29,className="Main",methodName="log"}));
end
Main.main = function() 
  Main.log("main() starting up...");
  Main.log("debug mode is enabled.");
  GLOBAL.CHEATS_ENABLED = true;
  GLOBAL.require("debugkeys");
  GLOBAL.require("debugtools");
end

Math.__name__ = true

Math.new = {}
Math.__name__ = true
Math.isNaN = function(f) 
  do return (f) ~= (f) end;
end


Reflect.new = {}
Reflect.__name__ = true
Reflect.fields = function(o) 
  if ((o.__fields__) ~= (nil)) then 
    do return lua.PairTools.pairsFold(o.__fields__,function(a,b,c) 
      if ((lua.Boot.hiddenFields:indexOf(a)) == (-1)) then 
        c:push(a);
      end;
      do return c end;
    end,_hx_tabArray({ }, 0)) end;
  else
    do return lua.PairTools.pairsFold(o,function(a1,b1,c1) 
      if ((lua.Boot.hiddenFields:indexOf(a1)) == (-1)) then 
        c1:push(a1);
      end;
      do return c1 end;
    end,_hx_tabArray({ }, 0)) end;
  end;
end


String.new = function(string) 
  local self = _hx_new(String.prototype)
  String.super(self,string)
  self = string
  return self
end

String.super = function(self,string) 
end
String.__name__ = true
String.__index = function(s,k) 
  if ((k) == ("length")) then 
    do return #s end;
  else
    
    local o = String.prototype;
    local field = k;
    if ((function() 
      local _hx_1
      if ((o.__fields__) ~= (nil)) then 
      _hx_1 = (o.__fields__[field]) ~= (nil); else _hx_1 = (o[field]) ~= (nil); end
      return _hx_1
    end )()) then 
      do return String.prototype[k] end;
    else
      if ((String.__oldindex) ~= (nil)) then 
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

String.prototype = _hx_anon(
  'toUpperCase', function(self) 
    do return _G.string.upper(self) end
  end,
  'toLowerCase', function(self) 
    do return _G.string.lower(self) end
  end,
  'indexOf', function(self,str,startIndex) 
    if ((startIndex) == (nil)) then 
      startIndex = 1;
    else
      startIndex = (startIndex) + (1);
    end;
    local r = _G.string.find(self,str,startIndex,true);
    if (((r) ~= (nil)) and ((r) > (0))) then 
      do return (r) - (1) end;
    else
      do return -1 end;
    end;
  end,
  'lastIndexOf', function(self,str,startIndex) 
    local ret = -1;
    if ((startIndex) == (nil)) then 
      startIndex = self.length;
    end;
    while (true) do 
      
      local p = self:indexOf(str,(ret) + (1));
      if (((p) == (-1)) or ((p) > (startIndex))) then 
        do return ret end;
      end;
      ret = p;
    
    end;
  end,
  'split', function(self,delimiter) 
    local idx = 1;
    local ret = _hx_tabArray({ }, 0);
    while ((idx) ~= (nil)) do 
      
      local newidx = 0;
      if ((delimiter.length) > (0)) then 
        newidx = _G.string.find(self,delimiter,idx,true);
      else
        if ((idx) >= (self.length)) then 
          newidx = nil;
        else
          newidx = (idx) + (1);
        end;
      end;
      if ((newidx) ~= (nil)) then 
        
        ret:push(_G.string.sub(self,idx,(newidx) - (1)));
        idx = (newidx) + (delimiter.length);
      else
        
        ret:push(_G.string.sub(self,idx,_G.string.len(self)));
        idx = nil;
      end;
    
    end;
    do return ret end
  end,
  'toString', function(self) 
    do return self end
  end,
  'substring', function(self,startIndex,endIndex) 
    if ((endIndex) == (nil)) then 
      endIndex = self.length;
    end;
    if ((endIndex) < (0)) then 
      endIndex = 0;
    end;
    if ((startIndex) < (0)) then 
      startIndex = 0;
    end;
    if ((endIndex) < (startIndex)) then 
      do return _G.string.sub(self,(endIndex) + (1),startIndex) end;
    else
      do return _G.string.sub(self,(startIndex) + (1),endIndex) end;
    end;
  end,
  'get_length', function(self) 
    do return _G.string.len(self) end
  end,
  'charAt', function(self,index) 
    do return _G.string.sub(self,(index) + (1),(index) + (1)) end
  end,
  'charCodeAt', function(self,index) 
    do return _G.string.byte(self,(index) + (1)) end
  end,
  'substr', function(self,pos,len) 
    if (((len) == (nil)) or ((len) > ((pos) + (self.length)))) then 
      len = self.length;
    else
      if ((len) < (0)) then 
        len = (self.length) + (len);
      end;
    end;
    if ((pos) < (0)) then 
      pos = (self.length) + (pos);
    end;
    if ((pos) < (0)) then 
      pos = 0;
    end;
    do return _G.string.sub(self,(pos) + (1),(pos) + (len)) end
  end
  ,'__class__',  String
)

Std.new = {}
Std.__name__ = true
Std.is = function(v,t) 
  do return lua.Boot.__instanceof(v,t) end;
end
Std.string = function(s) 
  do return lua.Boot.__string_rec(s) end;
end


StringBuf.new = function() 
  local self = _hx_new(StringBuf.prototype)
  StringBuf.super(self)
  return self
end

StringBuf.super = function(self) 
  self.b = _hx_empty();
  self.length = 0;
end
StringBuf.__name__ = true

StringBuf.prototype = _hx_anon(
  'add', function(self,x) 
    local str = Std.string(x);
    _G.table.insert(self.b,str);
    (function() return (function() 
    local fld = 'length';
    local obj = self;
    obj[fld] = (obj.length) + (str.length);
    return obj[fld] end)() end)();
  end
  ,'__class__',  StringBuf
)

haxe.Log.new = {}
haxe.Log.__name__ = true
haxe.Log.trace = function(v,infos) 
  local str = nil;
  if ((infos) ~= (nil)) then 
    
    str = infos.fileName .. ":" .. infos.lineNumber .. ": " .. Std.string(v);
    if ((infos.customParams) ~= (nil)) then 
      str = str .. ("," .. infos.customParams:join(","));
    end;
  else
    str = v;
  end;
  _hx_print(lua.Boot.__string_rec(str));
end


haxe.ds.ArraySort.new = {}
haxe.ds.ArraySort.__name__ = true
haxe.ds.ArraySort.sort = function(a,cmp) 
  haxe.ds.ArraySort.rec(a,cmp,0,a.length);
end
haxe.ds.ArraySort.rec = function(a,cmp,from,to) 
  local middle = _hx_bit.arshift((from) + (to),1);
  if (((to) - (from)) < (12)) then 
    
    if ((to) <= (from)) then 
      do return end;
    end;
    
    local _g1 = (from) + (1);
    while ((_g1) < (to)) do 
      
      _g1 = (_g1) + (1);
      local j = (_g1) - (1);
      while ((j) > (from)) do 
        
        if ((cmp(a[j],a[(j) - (1)])) < (0)) then 
          haxe.ds.ArraySort.swap(a,(j) - (1),j);
        else
          break;
        end;
        j = (j) - (1);
      
      end;
    
    end;
    do return end;
  end;
  haxe.ds.ArraySort.rec(a,cmp,from,middle);
  haxe.ds.ArraySort.rec(a,cmp,middle,to);
  haxe.ds.ArraySort.doMerge(a,cmp,from,middle,to,(middle) - (from),(to) - (middle));
end
haxe.ds.ArraySort.doMerge = function(a,cmp,from,pivot,to,len1,len2) 
  local first_cut
  local second_cut
  local len11
  local len22
  local new_mid
  if (((len1) == (0)) or ((len2) == (0))) then 
    do return end;
  end;
  if (((len1) + (len2)) == (2)) then 
    
    if ((cmp(a[pivot],a[from])) < (0)) then 
      haxe.ds.ArraySort.swap(a,pivot,from);
    end;
    do return end;
  end;
  if ((len1) > (len2)) then 
    
    len11 = _hx_bit.arshift(len1,1);
    first_cut = (from) + (len11);
    second_cut = haxe.ds.ArraySort.lower(a,cmp,pivot,to,first_cut);
    len22 = (second_cut) - (pivot);
  else
    
    len22 = _hx_bit.arshift(len2,1);
    second_cut = (pivot) + (len22);
    first_cut = haxe.ds.ArraySort.upper(a,cmp,from,pivot,second_cut);
    len11 = (first_cut) - (from);
  end;
  haxe.ds.ArraySort.rotate(a,cmp,first_cut,pivot,second_cut);
  new_mid = (first_cut) + (len22);
  haxe.ds.ArraySort.doMerge(a,cmp,from,first_cut,new_mid,len11,len22);
  haxe.ds.ArraySort.doMerge(a,cmp,new_mid,second_cut,to,(len1) - (len11),(len2) - (len22));
end
haxe.ds.ArraySort.rotate = function(a,cmp,from,mid,to) 
  local n
  if (((from) == (mid)) or ((mid) == (to))) then 
    do return end;
  end;
  n = haxe.ds.ArraySort.gcd((to) - (from),(mid) - (from));
  while (true) do 
    
    n = (n) - (1);
    if (not (((n) + (1)) ~= (0))) then 
      break;
    end;
    local val = a[(from) + (n)];
    local shift = (mid) - (from);
    local p1 = (from) + (n);
    local p2 = ((from) + (n)) + (shift);
    while ((p2) ~= ((from) + (n))) do 
      
      a[p1] = a[p2];
      p1 = p2;
      if (((to) - (p2)) > (shift)) then 
        p2 = (p2) + (shift);
      else
        p2 = (from) + (((shift) - (((to) - (p2)))));
      end;
    
    end;
    a[p1] = val;
  
  end;
end
haxe.ds.ArraySort.gcd = function(m,n) 
  while ((n) ~= (0)) do 
    
    local t = _G.math.fmod(m, n);
    m = n;
    n = t;
  
  end;
  do return m end;
end
haxe.ds.ArraySort.upper = function(a,cmp,from,to,val) 
  local len = (to) - (from);
  local half
  local mid
  while ((len) > (0)) do 
    
    half = _hx_bit.arshift(len,1);
    mid = (from) + (half);
    if ((cmp(a[val],a[mid])) < (0)) then 
      len = half;
    else
      
      from = (mid) + (1);
      len = ((len) - (half)) - (1);
    end;
  
  end;
  do return from end;
end
haxe.ds.ArraySort.lower = function(a,cmp,from,to,val) 
  local len = (to) - (from);
  local half
  local mid
  while ((len) > (0)) do 
    
    half = _hx_bit.arshift(len,1);
    mid = (from) + (half);
    if ((cmp(a[mid],a[val])) < (0)) then 
      
      from = (mid) + (1);
      len = ((len) - (half)) - (1);
    else
      len = half;
    end;
  
  end;
  do return from end;
end
haxe.ds.ArraySort.swap = function(a,i,j) 
  local tmp = a[i];
  a[i] = a[j];
  a[j] = tmp;
end


haxe.io.Eof.new = {}
haxe.io.Eof.__name__ = true

haxe.io.Eof.prototype = _hx_anon(
  'toString', function(self) 
    do return "Eof" end
  end
  ,'__class__',  haxe.io.Eof
)

lua.Boot.new = {}
lua.Boot.__name__ = true
lua.Boot.bind = function(o,m) 
  if ((m) == (nil)) then 
    do return nil end;
  end;
  local f = nil;
  if ((o.hx__closures__) == (nil)) then 
    o.hx__closures__ = _hx_empty();
  else
    f = o.hx__closures__[m];
  end;
  if ((f) == (nil)) then 
    
    f = function(...) return m(o, ...) end;
    o.hx__closures__[m] = f;
  end;
  do return f end;
end
lua.Boot.__instanceof = function(o,cl) 
  if ((cl) == (nil)) then 
    do return false end;
  end;
  if (cl) == Array then 
    if ((_G.type(o)) == ("table")) then 
      
      if (((o.__enum__) == (nil)) and ((_G.getmetatable(o)) ~= (nil))) then 
        do return (_G.getmetatable(o).__index) == (Array.prototype) end;
      else
        do return false end;
      end;
    else
      do return false end;
    end;
  elseif (cl) == Bool then 
    do return (_G.type(o)) == ("boolean") end;
  elseif (cl) == Dynamic then 
    do return true end;
  elseif (cl) == Float then 
    do return (_G.type(o)) == ("number") end;
  elseif (cl) == Int then 
    if ((_G.type(o)) == ("number")) then 
      do return (_hx_bit_clamp(o)) == (o) end;
    else
      do return false end;
    end;
  elseif (cl) == String then 
    do return (_G.type(o)) == ("string") end;
  elseif (cl) == _G.table then 
    do return (_G.type(o)) == ("table") end;
  elseif (cl) == lua.Thread then 
    do return (_G.type(o)) == ("thread") end;
  elseif (cl) == lua.UserData then 
    do return (_G.type(o)) == ("userdata") end;
  else
    if ((((o) ~= (nil)) and ((_G.type(o)) == ("table"))) and ((_G.type(cl)) == ("table"))) then 
      
      local tmp
      if (Std.is(o,Array)) then 
        tmp = Array;
      else
        
        local cl1 = o.__class__;
        if ((cl1) ~= (nil)) then 
          tmp = cl1;
        else
          tmp = nil;
        end;
      end;
      if (lua.Boot.extendsOrImplements(tmp,cl)) then 
        do return true end;
      end;
      
      if (((cl) == (Class)) and ((o.__name__) ~= (nil))) then 
        do return true end;
      end;
      
      if (((cl) == (Enum)) and ((o.__ename__) ~= (nil))) then 
        do return true end;
      end;
      do return (o.__enum__) == (cl) end;
    else
      do return false end;
    end;
  end;
end
lua.Boot.__cast = function(o,t) 
  if (lua.Boot.__instanceof(o,t)) then 
    do return o end;
  else
    _G.error("Cannot cast " .. Std.string(o) .. " to " .. Std.string(t),0);
  end;
end
lua.Boot.printEnum = function(o,s) 
  if ((o.length) == (2)) then 
    do return o[0] end;
  else
    
    local str = Std.string(o[0]) .. "(";
    s = s .. "\t";
    
    local _g1 = 2;
    local _g = o.length;
    while ((_g1) < (_g)) do 
      
      _g1 = (_g1) + (1);
      local i = (_g1) - (1);
      if ((i) ~= (2)) then 
        str = str .. ("," .. lua.Boot.__string_rec(o[i],s));
      else
        str = str .. lua.Boot.__string_rec(o[i],s);
      end;
    
    end;
    do return str .. ")" end;
  end;
end
lua.Boot.printClassRec = function(c,result,s) 
  if ((result) == (nil)) then 
    result = "";
  end;
  lua.PairTools.pairsEach(c,function(k,v) 
    if ((result) ~= ("")) then 
      result = result .. ", ";
    end;
    result = result .. ("" .. k .. ": " .. lua.Boot.__string_rec(v,s .. "\t"));
  end);
  do return result end;
end
lua.Boot.__string_rec = function(o,s) 
  if ((s) == (nil)) then 
    s = "";
  end;
  local _g = type(o);
  if (_g) == "boolean" then 
    do return tostring(o) end;
  elseif (_g) == "function" then 
    do return "<function>" end;
  elseif (_g) == "nil" then 
    do return "null" end;
  elseif (_g) == "number" then 
    if ((o) == (_G.math.huge)) then 
      do return "Infinity" end;
    else
      if ((o) == (-_G.math.huge)) then 
        do return "-Infinity" end;
      else
        if ((o) ~= (o)) then 
          do return "NaN" end;
        else
          do return tostring(o) end;
        end;
      end;
    end;
  elseif (_g) == "string" then 
    do return o end;
  elseif (_g) == "table" then 
    if ((o.__enum__) ~= (nil)) then 
      do return lua.Boot.printEnum(o,s) end;
    else
      if (((o.toString) ~= (nil)) and (not lua.Boot.__instanceof(o,Array))) then 
        do return o:toString() end;
      else
        if (lua.Boot.__instanceof(o,Array)) then 
          
          if ((s.length) > (5)) then 
            do return "[...]" end;
          else
            
            local _g1 = _hx_tabArray({ }, 0);
            
            local _g11 = 0;
            local _g2 = lua.Boot.__cast(o , Array);
            while ((_g11) < (_g2.length)) do 
              
              local i = _g2[_g11];
              _g11 = (_g11) + (1);
              _g1:push(lua.Boot.__string_rec(i,s .. 1));
            
            end;
            do return "[" .. _g1:join(",") .. "]" end;
          end;
        else
          if ((s.length) > (5)) then 
            do return "{...}" end;
          else
            if ((function() 
              local _hx_1
              if ((o.__fields__) ~= (nil)) then 
              _hx_1 = (o.__fields__.__tostring) ~= (nil); else _hx_1 = (o.__tostring) ~= (nil); end
              return _hx_1
            end )()) then 
              do return _G.tostring(o) end;
            else
              if ((function() 
                local _hx_2
                if ((o.__fields__) ~= (nil)) then 
                _hx_2 = (o.__fields__.__class__) ~= (nil); else _hx_2 = (o.__class__) ~= (nil); end
                return _hx_2
              end )()) then 
                do return "{" .. lua.Boot.printClassRec(o,"",s .. "\t") .. "}" end;
              else
                if ((_G.next(o)) == (nil)) then 
                  do return "{}" end;
                else
                  
                  local fields = Reflect.fields(o);
                  local buffer = StringBuf.new();
                  local first = true;
                  buffer:add("{ ");
                  
                  local _g3 = 0;
                  while ((_g3) < (fields.length)) do 
                    
                    local f = fields[_g3];
                    _g3 = (_g3) + (1);
                    if (first) then 
                      first = false;
                    else
                      buffer:add(", ");
                    end;
                    buffer:add("" .. s .. Std.string(f) .. " : " .. Std.string(o[f]));
                  
                  end;
                  buffer:add(" }");
                  do return _G.table.concat(buffer.b) end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  elseif (_g) == "thread" then 
    do return "<thread>" end;
  elseif (_g) == "userdata" then 
    do return "<userdata>" end;
  else
    _G.error("Unknown Lua type",0);
  end;
end
lua.Boot.dateStr = function(date) 
  local m = (date:getMonth()) + (1);
  local d = date:getDate();
  local h = date:getHours();
  local mi = date:getMinutes();
  local s = date:getSeconds();
  do return date:getFullYear() .. "-" .. ((function() 
    local _hx_1
    if ((m) < (10)) then 
    _hx_1 = "0" .. m; else _hx_1 = "" .. m; end
    return _hx_1
  end )()) .. "-" .. ((function() 
    local _hx_2
    if ((d) < (10)) then 
    _hx_2 = "0" .. d; else _hx_2 = "" .. d; end
    return _hx_2
  end )()) .. " " .. ((function() 
    local _hx_3
    if ((h) < (10)) then 
    _hx_3 = "0" .. h; else _hx_3 = "" .. h; end
    return _hx_3
  end )()) .. ":" .. ((function() 
    local _hx_4
    if ((mi) < (10)) then 
    _hx_4 = "0" .. mi; else _hx_4 = "" .. mi; end
    return _hx_4
  end )()) .. ":" .. ((function() 
    local _hx_5
    if ((s) < (10)) then 
    _hx_5 = "0" .. s; else _hx_5 = "" .. s; end
    return _hx_5
  end )()) end;
end
lua.Boot.extendsOrImplements = function(cl1,cl2) 
  if (((cl1) == (nil)) or ((cl2) == (nil))) then 
    do return false end;
  else
    if ((cl1) == (cl2)) then 
      do return true end;
    else
      if ((cl1.__interfaces__) ~= (nil)) then 
        
        local intf = cl1.__interfaces__;
        
        local _g1 = 1;
        local _g = (_G.table.maxn(intf)) + (1);
        while ((_g1) < (_g)) do 
          
          _g1 = (_g1) + (1);
          local i = (_g1) - (1);
          if (lua.Boot.extendsOrImplements(intf[1],cl2)) then 
            do return true end;
          end;
        
        end;
      end;
    end;
  end;
  do return lua.Boot.extendsOrImplements(cl1.__super__,cl2) end;
end


lua.UserData.new = {}
lua.UserData.__name__ = true


lua.PairTools.new = {}
lua.PairTools.__name__ = true
lua.PairTools.pairsEach = function(table,func) 
  for k,v in _G.pairs(table) do func(k,v) end;
end
lua.PairTools.pairsFold = function(table,func,seed) 
  for k,v in _G.pairs(table) do seed = func(k,v,seed) end;
  do return seed end;
end


lua.Thread.new = {}
lua.Thread.__name__ = true

local _hx_string_mt = _G.getmetatable('');
String.__oldindex = _hx_string_mt.__index;
_hx_string_mt.__index = String.__index;
_hx_string_mt.__add = function(a,b) return Std.string(a)..Std.string(b) end;
_hx_string_mt.__concat = _hx_string_mt.__add
_hx_array_mt.__index = Array.prototype

lua.Boot.hiddenFields = _hx_tabArray({[0]="__id__", "hx__closures", "super", "prototype", "__fields__", "__ifields__", "__class__", "__properties__" }, 8)
do

String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
_G.math.randomseed(_G.os.time())
end
Main.main()
return _G