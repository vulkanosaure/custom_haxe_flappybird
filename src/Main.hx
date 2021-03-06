package;

import com.vinc.layout.LayoutManager;
import haxe.Timer;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.display3D.Context3DRenderMode;
import openfl.errors.Error;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.system.Capabilities;
import starling.core.Starling;
import starling.events.Event;
import starling.textures.RenderTexture;
import starling.utils.AssetManager;
import starling.utils.Max;
import starling.utils.RectangleUtil;
import starling.utils.ScaleMode;
import utils.ProgressBar;

/**
 * ...
 * @author Vincent Huss
 */
class Main extends Sprite 
{
	private var mStarling:Starling;
    private var mBackground:Bitmap;
    private var mProgressBar:ProgressBar;

	public function new()
    {
        super();
        if (stage != null) start();
        else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Dynamic):Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
		start();
    }
	
	
	
	private function start():Void
    {
		trace("Main.start");
		
		
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		this.stage.addEventListener(Event.RESIZE, LayoutManager.onResize, false, Max.INT_MAX_VALUE, true);
		/*
		var sp:Sprite = new Sprite();
		sp.graphics.beginFill(0xFF0000);
		sp.graphics.drawCircle(20, 20, 20);
		this.addChild(sp);
		*/
        
		
        Starling.multitouchEnabled = true; // for Multitouch Scene
        Starling.handleLostContext = true; // recommended everywhere when using AssetManager
        RenderTexture.optimizePersistentBuffers = true; // should be safe on Desktop
		
        mStarling = new Starling(StarlingRoot, stage, null, null, Context3DRenderMode.AUTO, "auto");
        mStarling.simulateMultitouch = true;
        mStarling.enableErrorChecking = Capabilities.isDebugger;
		mStarling.antiAliasing = 0;
		
        mStarling.addEventListener(Event.ROOT_CREATED, function():Void
        {
            LoaderManager.load(startApp);
			Vars.assets = LoaderManager.am();
        });
		
		
        mStarling.start();
        //initElements();
    }
	
	
	
	private function initElements():Void
    {
        // Add background image.
		/*
        mBackground = new Bitmap(Assets.getBitmapData("assets/textures/1x/background.jpg"));
        mBackground.smoothing = true;
        addChild(mBackground);
		
        // While the assets are loaded, we will display a progress bar.
		
        mProgressBar = new ProgressBar(175, 20);
        mProgressBar.x = (mBackground.width - mProgressBar.width) / 2;
        mProgressBar.y =  mBackground.height * 0.7;
        addChild(mProgressBar);
		*/
		
    }
	
	
    private function removeElements():Void
    {
		/*
        if (mBackground != null)
        {
            removeChild(mBackground);
            mBackground = null;
        }
		
        if (mProgressBar != null)
        {
            removeChild(mProgressBar);
            mProgressBar = null;
        }
		*/
    }
	
	
	
	
	
	
	private function startApp(assets:AssetManager):Void
    {
		trace("startApp");
		
        var game:StarlingRoot = cast(mStarling.root, StarlingRoot);
        game.start(stage, mStarling);
        Timer.delay(removeElements, 150); // delay to make 100% sure there's no flickering.
		
		
		
    }
	
	
	
	
	

}
