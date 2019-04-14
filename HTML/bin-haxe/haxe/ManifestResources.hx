package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:pathy33:assets%2Fatlas%2Fatlas-game-0.pngy4:sizei326130y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y33:assets%2Fatlas%2Fatlas-game-0.xmlR2i2588R3y4:TEXTR5R7R6tgoR2i13928R3y5:MUSICR5y28:assets%2Faudio%2Fcounter.mp3y9:pathGroupaR10hR6tgoR2i12070R3R9R5y25:assets%2Faudio%2Ffall.mp3R11aR12hR6tgoR2i8867R3R9R5y24:assets%2Faudio%2Fhit.mp3R11aR13hR6tgoR2i16905R3R9R5y29:assets%2Faudio%2Fnavigate.mp3R11aR14hR6tgoR2i6885R3R9R5y30:assets%2Faudio%2Fwing_flap.mp3R11aR15hR6tgoR0y38:assets%2Ffonts%2Fflappyfont-raking.fntR2i11859R3R8R5R16R6tgoR0y40:assets%2Ffonts%2Fflappyfont-raking_0.pngR2i4544R3R4R5R17R6tgoR0y37:assets%2Ffonts%2Fflappyfont-score.fntR2i1610R3R8R5R18R6tgoR0y31:assets%2Ffonts%2Fflappyfont.fntR2i1610R3R8R5R19R6tgoR0y33:assets%2Ffonts%2Fflappyfont_0.pngR2i1795R3R4R5R20R6tgh","version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_atlas_atlas_game_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_atlas_atlas_game_0_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_audio_counter_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_audio_fall_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_audio_hit_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_audio_navigate_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_audio_wing_flap_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_flappyfont_raking_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_flappyfont_raking_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_flappyfont_score_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_flappyfont_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_flappyfont_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:image("assets/atlas/atlas-game-0.png") #if display private #end class __ASSET__assets_atlas_atlas_game_0_png extends lime.graphics.Image {}
@:file("assets/atlas/atlas-game-0.xml") #if display private #end class __ASSET__assets_atlas_atlas_game_0_xml extends haxe.io.Bytes {}
@:file("assets/audio/counter.mp3") #if display private #end class __ASSET__assets_audio_counter_mp3 extends haxe.io.Bytes {}
@:file("assets/audio/fall.mp3") #if display private #end class __ASSET__assets_audio_fall_mp3 extends haxe.io.Bytes {}
@:file("assets/audio/hit.mp3") #if display private #end class __ASSET__assets_audio_hit_mp3 extends haxe.io.Bytes {}
@:file("assets/audio/navigate.mp3") #if display private #end class __ASSET__assets_audio_navigate_mp3 extends haxe.io.Bytes {}
@:file("assets/audio/wing_flap.mp3") #if display private #end class __ASSET__assets_audio_wing_flap_mp3 extends haxe.io.Bytes {}
@:file("assets/fonts/flappyfont-raking.fnt") #if display private #end class __ASSET__assets_fonts_flappyfont_raking_fnt extends haxe.io.Bytes {}
@:image("assets/fonts/flappyfont-raking_0.png") #if display private #end class __ASSET__assets_fonts_flappyfont_raking_0_png extends lime.graphics.Image {}
@:file("assets/fonts/flappyfont-score.fnt") #if display private #end class __ASSET__assets_fonts_flappyfont_score_fnt extends haxe.io.Bytes {}
@:file("assets/fonts/flappyfont.fnt") #if display private #end class __ASSET__assets_fonts_flappyfont_fnt extends haxe.io.Bytes {}
@:image("assets/fonts/flappyfont_0.png") #if display private #end class __ASSET__assets_fonts_flappyfont_0_png extends lime.graphics.Image {}
@:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)



#end
#end