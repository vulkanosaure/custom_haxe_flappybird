package controllers;
import com.vinc.common.BroadCaster;
import com.vinc.common.ObjectSearch;
import com.vinc.debug.KeyboardDebug;
import com.vinc.fx.ScreenBlink;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;
import com.vinc.time.DelayManager;
import game.GameEngine;
import js.Cookie;
import openfl.ui.Keyboard;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import view.ViewEnd;
import view.ViewGame;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerGame extends ControllerBase
{
	var _gameEngine:GameEngine;
	var _container:Sprite;
	var _enableClick:Bool;
	

	public function new() 
	{
		super();
	}
	
	
	
	override public function init():Void 
	{
		trace("ControllerGame.init");
		
		_container = cast(ObjectSearch.getID("containerGame"), Sprite);
		_gameEngine = new GameEngine(openflstage, _container);
		
		BroadCaster.addEventListener("GAMEOVER", onGameOver);
		BroadCaster.addEventListener("COUNTER", onCounterChange);
		
		
		KeyboardDebug.init(openflstage);
		KeyboardDebug.addFunction(Keyboard.SPACE, onClickJump);
		
		Vars.starlingStage.addEventListener(TouchEvent.TOUCH, onTouch);
		
		
		
	}
	
	private function onTouch(e:TouchEvent):Void 
	{
		var _touch:Touch = e.getTouch(Vars.starlingStage);
		//trace("_touch.phase:" + _touch.phase);
		
		//trace("_touch : " + _touch);
		if (_touch == null) return;
		if (_touch.phase == TouchPhase.BEGAN) {
			onClickJump();
		}
	}
	
	private function onCounterChange(e:Event):Void 
	{
		trace("onCounterChange " + e.data);
		cast(MVCRoot.getView("screen_game"), ViewGame).setCounterGame(Std.int(e.data));
	}
	
	private function onGameOver(e:Event):Void 
	{
		trace("ControllerGame.onGameOver");
		_gameEngine.stop();
		
		ScreenBlink.blink(0xffffff, 0.01, 0.0, 0.12);
		
		var _viewEnd:ViewEnd = cast(MVCRoot.getView("screen_end"), ViewEnd);
		var _score:Int = _gameEngine.getScore();
		
		
		var _bestscore:Int = 0;
		if (Cookie.exists("best_score")) _bestscore = Std.int(Std.parseFloat(Cookie.get("best_score")));
		else Cookie.set("best_score", Std.string(_bestscore));
		
		
		
		trace("_bestscore : " + _bestscore);
		var _isBest:Bool = (_score > _bestscore);
		
		_viewEnd.setScore(0, 0);
		_viewEnd.displayBestLabel(_isBest);
		
		var _newbestscore:Int = _bestscore;
		if (_score > _newbestscore) {
			_newbestscore = _score;
			Cookie.set("best_score", Std.string(_newbestscore));
		}
		
		_viewEnd.setScore(1, _newbestscore);
		
		
		DelayManager.add("", 500, function():Void
		{
			Navigation.gotoScreen("", "screen_end");
			_viewEnd.tweenScore(0, _score);
		});
	}
	
	
	
	override public function update():Void 
	{
		var _view:ViewGame = cast(MVCRoot.getView(idscreen), ViewGame);
		_view.showHelp();
		
		_gameEngine.reset();
		
		_view.chooseBackground(_container);
		
		_enableClick = false;
		DelayManager.add("", 500, function():Void
		{
			_enableClick = true;
		});
		
		
	}
	
	private function onClickJump() :Void
	{
		if (Navigation.getCurscreen("") != "screen_game") return;
		if (!_enableClick) return;
		if (_gameEngine.isGameOver()) return;
		
		if (!_gameEngine.isStarted()) {
			var _view:ViewGame = cast(MVCRoot.getView(idscreen), ViewGame);
			_view.hideHelp();
			
			_gameEngine.start();
			
		}
		
		_gameEngine.jump();
		
		
		
	}
	
	
}