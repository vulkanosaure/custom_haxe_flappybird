package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VImage;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.MVCRoot;
import com.vinc.mvc.ViewBase;
import controllers.ControllerEnd;
import display.ScoreText;
import haxe.Timer;
import motion.Actuate;
import motion.easing.Linear;
import openfl.system.System;
import starling.display.Sprite;
import starling.text.TextField;
import ui.GameButton;

/**
 * ...
 * @author Vincent Huss
 */
class ViewEnd extends ViewBase
{
	var _score:ScoreText;
	var _bestScore:ScoreText;
	var _bestlabel:VImage;

	public function new() 
	{
		super();
	}
	
	override public function construct():Void 
	{
		_container = new LayoutSprite();
		Vars.containerFG.addChild(_container);
		ObjectSearch.registerID(_container, "screen_end");
		
		
		var _zonecenter:LayoutSprite = new LayoutSprite();
		_container.addChild(_zonecenter);
		_container = _zonecenter;
		LayoutManager.addItem(_zonecenter, {"width": 376, "height" : 445, "center-h" : 0.5, "center-v" : 0.54 } );
		
		
		
		var _title:VImage = new VImage("interface/game-over");
		_zonecenter.addChild(_title);
		LayoutManager.addItem(_title, { "center-h" : 0.5 } );
		ObjectSearch.registerID(_title, "screen_end_title");
		
		var _scoretable:LayoutSprite = new LayoutSprite();
		_zonecenter.addChild(_scoretable);
		LayoutManager.addItem(_scoretable, { "margin-top" : 105 } );
		ObjectSearch.registerID(_scoretable, "screen_end_table");
		
		_scoretable.addChild(new VImage("interface/bg-game-over"));
		
		
		_score = new ScoreText();
		_scoretable.addChild(_score);
		LayoutManager.addItem(_score, { "margin-right": 30, "margin-top" : 50 } );
		_score.value = 0;
		
		
		_bestScore = new ScoreText();
		_scoretable.addChild(_bestScore);
		LayoutManager.addItem(_bestScore, { "margin-right": 30, "margin-top" : 120 } );
		_bestScore.value = 0;
		
		_bestlabel = new VImage("interface/new-best-score");
		_scoretable.addChild(_bestlabel);
		_bestlabel.scaleX = _bestlabel.scaleY = 480 / 1080;
		LayoutManager.addItem(_bestlabel, { "margin-right": 30 + 68, "margin-top" : 97 } );
		
		//Actuate.defaultEase = Linear.easeNone;
		
		
		
		
		
		var _btnplay:GameButton = new GameButton("interface/buttons/btn-play");
		_btnplay.clickHandler = MVCRoot.getController("screen_end").onclick;
		_zonecenter.addChild(_btnplay);
		LayoutManager.addItem(_btnplay, { "margin-bottom" : 0, "id" : "btnplay_end" } );
		ObjectSearch.registerID(_btnplay, "screen_end_btn_replay");
		
		
		var _btnrank:GameButton = new GameButton("interface/buttons/btn-ranking");
		_btnrank.clickHandler = MVCRoot.getController("screen_end").onclick;
		_zonecenter.addChild(_btnrank);
		LayoutManager.addItem(_btnrank, { "margin-bottom" : 0, "margin-right" : 0, "id" : "btnrank_end" } );
		ObjectSearch.registerID(_btnrank, "screen_end_btn_rank");
		
		
	}
	
	public function setScore(_index:Int, _nbpts:Int) :Void
	{
		var _sc:ScoreText = (_index == 0) ? _score : _bestScore;
		_sc.value = _nbpts;
	}
	public function tweenScore(_index:Int, _nbpts:Int) :Void
	{
		var _sc:ScoreText = (_index == 0) ? _score : _bestScore;
		Actuate.tween(_sc, 0.5, { value : _nbpts } ).ease(Linear.easeNone).delay(1.7);
	}
	
	public function displayBestLabel(_value:Bool):Void
	{
		_bestlabel.visible = _value;
	}
	
}