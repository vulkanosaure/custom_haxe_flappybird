package display;
import com.vinc.layout.LayoutSprite;
import starling.text.TextField;
import starling.utils.HAlign;

/**
 * ...
 * @author Vincent Huss
 */
class ScoreText extends LayoutSprite
{
	var _tf:TextField;
	var _valueint:Int;
	@:isVar public var value(get, set):Float;
	

	public function new() 
	{
		super();
		
		_tf = new TextField(150, 50, "", "font_score", 36, 0xFFFFFF);
		_tf.hAlign = HAlign.RIGHT;
		this.addChild(_tf);
		//_tf.border = true;
		
		
		
	}
	
	function get_value():Float 
	{
		return value;
	}
	
	function set_value(v:Float):Float 
	{
		var _int:Int = Math.round(v);
		if (_valueint != _int) {
			//trace("setvalue(" + v + ")");
			_valueint = _int;
			_tf.text = Std.string(_valueint);
			
		}
		return value = v;
	}
	
	
	
	
}