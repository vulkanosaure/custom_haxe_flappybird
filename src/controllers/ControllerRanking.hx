package controllers;
import model.ModelGame;
import com.vinc.math.Math2;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;
import js.Cookie;
import openfl.utils.Object;
import view.ViewInput;
import view.ViewRanking;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerRanking extends ControllerBase
{

	public function new() 
	{
		super();
	}
	
	override public function init():Void 
	{
		super.init();
		trace("ControllerRanking.init");
		
	}
	
	override public function update():Void 
	{
		super.update();
		trace("ControllerRanking.update");
		
		
	}
	
	public function onClickRanking() :Void
	{
		trace("ControllerRanking.onClickRanking");
		
		//Navigation.gotoScreen("", "screen_ranking");
		
		var _playerid:String = Cookie.get("id");
		
		trace("_playerid : " + _playerid);
		if (Constants.DEBUG_MODE && Math2.getRandProbability(0.5)) _playerid = null;
		
		
		
		if (Navigation.getCurscreen("") == "screen_home") {
			gotoRanking(false);
		}
		else if (_playerid != null) {
			
			trace("player id not null");
			//todo : a mettre dans un Model
			var _nickname:String = Cookie.get("nickname");
			var _bestscore:Int = Std.int(Std.parseFloat(Cookie.get("best_score")));
			
			trace("_nickname : " + _nickname+", _bestscore : " + _bestscore);
			
			gotoRanking(true, {"id" : _playerid, "nickname" : _nickname, "score" : _bestscore});
			
		}
		else {
			trace("player id null");
			Navigation.gotoScreen("", "screen_input");
		}
		
		
		
	}
	
	
	
	
	function gotoRanking(_syncdata:Bool, _data:Object = null) :Void
	{
		Navigation.gotoScreen("", "screen_ranking");
		
		//todo, call script
		ModelGame.queryRanking(_data, onDataComplete);
		
		var _viewRanking:ViewRanking = cast(MVCRoot.getView("screen_ranking"), ViewRanking);
		_viewRanking.setLoadingVisible(true);
		
		//display data
		
	}
	
	function onDataComplete() :Void
	{
		trace("ControllerRanking.onDataComplete");
		trace(ModelGame.data);
		
		var _viewRanking:ViewRanking = cast(MVCRoot.getView("screen_ranking"), ViewRanking);
		_viewRanking.setData(ModelGame.data.data);
		_viewRanking.setLoadingVisible(false);
	}
	
	
	
	override public function onclick(_id:String):Void 
	{
		trace("ControllerRanking.onclick(" + _id + ")");
		
		if (_id == "btnback") {
			
			var _idscreen:String = "";
			if (Navigation.getPrevscreen("") == "screen_home") _idscreen = "screen_home";
			else _idscreen = "screen_end";
			
			Navigation.gotoScreen("", _idscreen);
			
		}
		
		else if (_id == "btnback-name") {
			Navigation.gotoScreen("", "screen_end");
		}
		else if (_id == "btnvalid-name") {
			
			var _valid:Bool = validateInput();
			
			if (_valid) {
				
				onClickRanking();
			}
			
		}
	}
	
	function validateInput() :Bool
	{
		var _output:Bool = true;
		var _viewInput:ViewInput = cast(MVCRoot.getView("screen_input"), ViewInput);
		var _nickname:String = _viewInput.getInput();
		
		trace("_nickname : " + _nickname);
		if (_nickname.length >= 2) {
			
			var _id:String = generateID();
			trace("generated id : " + _id);
			Cookie.set("id", _id);
			Cookie.set("nickname", _nickname);
			
		}
		else _output = false;
		
		return _output;
	}
	
	
	
	function generateID() :String
	{
		var _output:String = "";
		var _dict:String = "0123456789abcdefghijklmnopqrstuvwxyz";
		var _lendict:Int = _dict.length;
		
		for (i in 0...10) _output += _dict.charAt(Std.int(Math2.random(0, _lendict - 1)));
		
		return _output;
		
	}
	
	
}