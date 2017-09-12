package controllers;
import com.vinc.mvc.ControllerBase;
import com.vinc.mvc.MVCRoot;
import com.vinc.time.DelayManager;
import view.ViewInput;

/**
 * ...
 * @author Vincent Huss
 */
class ControllerInput extends ControllerBase
{

	public function new() 
	{
		super();
	}
	
	override public function init():Void 
	{
		super.init();
		trace("ControllerInput.init");
		
		var _viewInput:ViewInput = cast(MVCRoot.getView("screen_input"), ViewInput);
		_viewInput.setInputVisible(false);
		
	}
	
	override public function update():Void 
	{
		super.update();
		trace("ControllerInput.update");
		
		var _viewInput:ViewInput = cast(MVCRoot.getView("screen_input"), ViewInput);
		DelayManager.add("", 500, function():Void {
			_viewInput.setInputVisible(true);
		});
		
	}
	
	override public function preLeaveScreen():Void 
	{
		super.leaveScreen();
		var _viewInput:ViewInput = cast(MVCRoot.getView("screen_input"), ViewInput);
		_viewInput.setInputVisible(false);
	}
}