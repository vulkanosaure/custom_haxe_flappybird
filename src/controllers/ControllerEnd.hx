package controllers;
import com.vinc.display.VButton;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.navigation.Navigation;
import js.Browser;
import js.html.Document;
import js.html.Element;
import js.html.Element;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerEnd extends ControllerBase
{

	public function new() 
	{
		super();
	}
	
	
	override public function onclick(_id:String):Void 
	{
		trace("ControllerEnd.onClick(" + _id + ")");
		
		if (_id == "btnplay_end") {
			Navigation.gotoScreen("", "screen_game");
			
		}
		else if (_id == "btnrank_end") {
			
			var _controllerRanking:ControllerRanking = cast(MVCRoot.getController("screen_ranking"), ControllerRanking);
			_controllerRanking.onClickRanking();
			
		}
		
		
		
	}
	
}