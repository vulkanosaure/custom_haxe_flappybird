package controllers;
import com.vinc.display.VButton;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;
import js.Browser;
import js.html.Document;
import js.html.Window;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerHome extends ControllerBase
{

	public function new() 
	{
		super();
	}
	
	
	
	
	
	override public function onclick(_id:String):Void 
	{
		trace("ControllerHome.onclick(" + _id + ")");
		
		if (_id == "btnrate") {
			
		}
		else if (_id == "btnplay") {
			
			Navigation.gotoScreen("", "screen_game");
			
		}
		else if (_id == "btnrank") {
			//Navigation.gotoScreen("", "screen_end");
			
			var _controllerRanking:ControllerRanking = cast(MVCRoot.getController("screen_ranking"), ControllerRanking);
			_controllerRanking.onClickRanking();
		}
		
	}
	
}