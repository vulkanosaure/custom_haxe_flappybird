package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.math.Math2;
import com.vinc.mvc.ViewBase;
import com.vinc.time.DelayManager;
import display.Counter;
import haxe.Constraints.Function;
import motion.Actuate;
import starling.display.Sprite;

/**
 * ...
 * @author Vincent Huss
 */
class ViewGame extends ViewBase
{
	var _getready:VImage;
	var _assetHelp:VImage;
	var _counter:Counter;

	public function new() 
	{
		super();
	}
	
	override public function construct():Void 
	{
		_container = new LayoutSprite();
		Vars.containerFG.addChild(_container);
		LayoutManager.addItem(_container, { "center-v" : 0.2, "center-h" : 0.5, "width" : 309, "height" : 420 } );
		ObjectSearch.registerID(_container, "screen_game");
		
		
		_counter = new Counter();
		_container.addChild(_counter);
		LayoutManager.addItem(_counter, { "center-h" : 0.5 } );
		_counter.setValue(0);
		
		
		_getready = new VImage("interface/get-ready");
		_container.addChild(_getready);
		LayoutManager.addItem(_getready, { "margin-top" : 130 } );
		_getready.visible = false;
		
		
		var _containerGame:Sprite = cast(ObjectSearch.getID("containerGame"), Sprite);
		
		_assetHelp = new VImage("interface/asset-help");
		_assetHelp.visible = false;
		
		_containerGame.addChild(_assetHelp);
		LayoutManager.addItem(_assetHelp, { "margin-bottom" : 294, "center-h" : 0.5 } );
		
		//todo : a intégrer dans BG, en cohérence avec hero
		
		
		
	}
	
	
	
	public function showHelp():Void
	{
		_getready.visible = true;
		_getready.alpha = 1;
		_assetHelp.visible = true;
		_assetHelp.alpha = 1;
	}
	
	public function hideHelp():Void
	{
		Actuate.tween(_getready, 1.0, { alpha:0 } );
		Actuate.tween(_assetHelp, 1.0, { alpha:0 } );
	}
	
	public function setCounterGame(_score:Int) 
	{
		_counter.setValue(_score);
	}
	
	public function chooseBackground(_container:Sprite) :Void
	{
		var _rand:Float = Math2.random(0, 1, 1);
		_container.getChildByName("bg0").visible = (_rand == 0);
		_container.getChildByName("bg1").visible = (_rand == 1);
	}
	
	
}