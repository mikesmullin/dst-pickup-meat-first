package;

import sys.io.File;

class Macro {
	public static macro function dontStarvePreInit()
	{
		// Dont Starve mods operate in a sandboxed environment
		// where global functions are all moved into a GLOBAL variable.
		// Here we restore common functions to local script scope
		// so the Haxe Lua target boilerplate works as expected.		
		
		haxe.macro.Context.onAfterGenerate(function() {
			var mainFile = haxe.macro.Compiler.getOutput();
			var compilerOutput = File.getContent(mainFile);
			File.saveContent(mainFile, 
				"local pcall = GLOBAL.pcall\n"+
				"local getmetatable = GLOBAL.getmetatable\n"+
				"local setmetatable = GLOBAL.setmetatable\n"+
				"local rawset = GLOBAL.rawset\n"+
				"local select = GLOBAL.select\n" +
				"local debug = GLOBAL.debug\n"+	
				"local _G = GLOBAL\n\n" +
				compilerOutput);
		});
		
		return macro null;
	}
}