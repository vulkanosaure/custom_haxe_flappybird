package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VButton;
import com.vinc.display.VImage;
import com.vinc.layout.FlashStarlingContainer;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.MVCRoot;
import com.vinc.mvc.ViewBase;
import haxe.io.Input;
import js.Browser;
import js.html.CSSStyleDeclaration;
import js.html.HtmlElement;
import js.html.InputElement;
import openfl.events.Event;
import openfl.events.TextEvent;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.InputText;
import ru.stablex.ui.widgets.Text;
import ui.GameButton;



/**
 * ...
 * @author Vincent Huss
 */
class ViewInput extends ViewBase
{
	var _fscontainer:FlashStarlingContainer;
	var _textformat:TextFormat;
	var _tf:TextField;

	public function new() 
	{
		super();
	}
	
	override public function construct():Void 
	{
		super.construct();
		trace("ViewInput.construct");
		
		
		_container = new LayoutSprite();
		Vars.containerFG.addChild(_container);
		ObjectSearch.registerID(_container, "screen_input");
		
		
		var _container2:LayoutSprite = new LayoutSprite();
		_container.addChild(_container2);
		LayoutManager.addItem(_container2, { "width": 376, "height" : 240, "center-h" : 0.5, "center-v" : 0.5 } );
		
		var _bloctop:LayoutSprite = new LayoutSprite();
		_container2.addChild(_bloctop);
		ObjectSearch.registerID(_bloctop, "input_bloctop");
		
		
		var _bg:VImage = new VImage("interface/bg-enter-name");
		_bloctop.addChild(_bg);
		
		
		var _title:VImage = new VImage("interface/title-enter-name");
		_bloctop.addChild(_title);
		LayoutManager.addItem(_title, {"margin-top" : 25, "center-h" : 0.5} );
		
		
		//______________________________________________
		//input
		
		var _containerInput:LayoutSprite = new LayoutSprite();
		_bloctop.addChild(_containerInput);
		LayoutManager.addItem(_containerInput, {"margin-top" : 70, "center-h" : 0.5} );
		
		var _bginput:VImage = new VImage("interface/bg-input");
		_containerInput.addChild(_bginput);
		
		
		var _groupsbtns:LayoutSprite = new LayoutSprite();
		_bloctop.addChild(_groupsbtns);
		LayoutManager.addItem(_groupsbtns, { "center-h" : 0.5, "margin-bottom":0, "width" : 255 } );
		ObjectSearch.registerID(_groupsbtns, "input_buttons");
		
		var _btnback:GameButton = new GameButton("interface/buttons/btn-back");
		_btnback.idLayout = "btnback-name";
		_groupsbtns.addChild(_btnback);
		LayoutManager.addItem(_btnback, { "margin-left":0 } );
		_btnback.clickHandler = MVCRoot.getController("screen_ranking").onclick;
		
		
		var _btnvalid:GameButton = new GameButton("interface/buttons/btn-valid");
		_btnvalid.idLayout = "btnvalid-name";
		_groupsbtns.addChild(_btnvalid);
		LayoutManager.addItem(_btnvalid, { "margin-right":0 } );
		_btnvalid.clickHandler = MVCRoot.getController("screen_ranking").onclick;
		
		
		
		
		/*
		_tf = new TextField();
		_tf.type = TextFieldType.INPUT;
		//_tf.border = true;
		//_tf.borderColor = 0x000000;
		_tf.width = 288;
		_tf.height = 38;
		_tf.y = 3;
		_textformat = new TextFormat();
		_textformat.align = TextFormatAlign.CENTER;
		_textformat.font = "Arial";
		_textformat.size = 28;
		
		_tf.addEventListener(TextEvent.TEXT_INPUT, onTextInput);
		_tf.setTextFormat(_textformat);
		_tf.maxChars = 10;
		*/
		
		
		/*
		var _input:InputElement = document.createInputElement();
		_input.width = 288;
		_input.height = 38;
		_input.id = "input_name";
		document.querySelector("#openfl-content").appendChild(_input);
		*/
		
		var _textformat:TextFormat = new TextFormat("Arial", 28);
		
		var widget = UIBuilder.create(InputText, {
			text : 'My first widget!',
			format : _textformat,
			w : 288,
			h : 43,
			align:"center,middle", 
			
		});
		var _tf:InputText = cast(widget, InputText);
		
		var _it:InputText;
		
		Vars.openflstage.addChild(widget);
		
		
		//center, arial, size
		
		_fscontainer = new FlashStarlingContainer();
		_fscontainer.addChild(_tf);
		Vars.openflstage.addChild(_fscontainer);
		_fscontainer.sync(_containerInput, Vars.starlingStage);
		
		
		LayoutManager.addResizeLister(function():Void {
			_fscontainer.sync(_containerInput, Vars.starlingStage);
		});
		
		
		
	}
	
	private function onTextInput(e:TextEvent):Void 
	{
		_tf.setTextFormat(_textformat);
	}
	
	public function setInputVisible(_value:Bool) :Void
	{
		_fscontainer.visible = _value;
	}
	
	public function getInput():String
	{
		return _tf.text;
	}
	
}