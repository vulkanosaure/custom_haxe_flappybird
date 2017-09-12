package display;
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.HAlign;

/**
 * ...
 * @author Vincent Huss
 */
class RankingEntry extends Sprite
{
	var _tfposition:TextField;
	var _tfname:TextField;
	var _tfscore:TextField;

	public function new() 
	{
		super();
		
		_tfposition = new TextField(50, 24, "", "font_ranking");
		//_tfposition.border = true;
		_tfposition.fontSize = 20;
		this.addChild(_tfposition);
		_tfposition.text = "75.";
		_tfposition.color = 0xf77857;
		_tfposition.hAlign = HAlign.LEFT;
		
		
		_tfname = new TextField(180, 24, "", "font_ranking");
		//_tfname.border = true;
		_tfname.fontSize = 20;
		this.addChild(_tfname);
		_tfname.text = "Nickname too long poaziur azeir ";
		_tfname.x = 50;
		_tfname.color = 0xFFFFFF;
		_tfname.hAlign = HAlign.LEFT;
		_tfname.autoScale = false;
		
		_tfscore = new TextField(70, 24, "", "font_ranking");
		//_tfscore.border = true;
		_tfscore.fontSize = 20;
		this.addChild(_tfscore);
		_tfscore.text = "58";
		_tfscore.color = 0xf77857;
		_tfscore.hAlign = HAlign.RIGHT;
		_tfscore.x = 240;
		
	}
	
	public function setContent(_position:Int, _nickname:String, _score:Int):Void
	{
		_tfposition.text = Std.string(_position + ".");
		_tfname.text = _nickname;
		_tfscore.text = Std.string(_score);
		
		
	}
	
}