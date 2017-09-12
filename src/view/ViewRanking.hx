package view;
import com.vinc.common.ObjectSearch;
import com.vinc.display.VButton;
import com.vinc.display.VImage;
import com.vinc.layout.LayoutManager;
import com.vinc.layout.LayoutSprite;
import com.vinc.mvc.MVCRoot;
import com.vinc.mvc.ViewBase;
import com.vinc.xtends.Button2;
import display.LoadingAnim;
import display.RankingEntry;
import openfl.utils.Object;
import starling.display.Sprite;
import starling.text.TextField;
import ui.GameButton;

/**
 * ...
 * @author Vincent Huss
 */
class ViewRanking extends ViewBase
{
	var _entries:Array<RankingEntry>;
	var _nbentry:Int = 20;
	var _containerEntries:Sprite;
	var _loaderAnim:LoadingAnim;

	public function new() 
	{
		super();
		
	}
	
	override public function construct():Void 
	{
		super.construct();
		trace("ViewRanking.construct");
		
		_container = new LayoutSprite();
		Vars.containerFG.addChild(_container);
		ObjectSearch.registerID(_container, "screen_ranking");
		
		LayoutManager.addItem(_container, { "width" : 376, "height" : 600, "center-v" : 0.5, "center-h" : 0.5 } );
		
		var _containerRanking:LayoutSprite = new LayoutSprite();
		_container.addChild(_containerRanking);
		ObjectSearch.registerID(_containerRanking, "ranking-top");
		
		var _bg:VImage = new VImage("interface/bg-ranking");
		_containerRanking.addChild(_bg);
		
		_containerEntries = new Sprite();
		_containerRanking.addChild(_containerEntries);
		_containerEntries.x = 32;
		_containerEntries.y = 15;
		
		var _btnback:GameButton = new GameButton("interface/buttons/btn-back");
		_container.addChild(_btnback);
		ObjectSearch.registerID(_btnback, "ranking-bottom");
		LayoutManager.addItem(_btnback, {"id" : "btnback", "center-h" : 0.5, "margin-bottom" : 0 } );
		_btnback.clickHandler = MVCRoot.getController("screen_ranking").onclick;
		
		
		_loaderAnim = new LoadingAnim();
		_containerRanking.addChild(_loaderAnim);
		LayoutManager.addItem(_loaderAnim, { "center-h" : 0.5, "margin-top" : 230 } );
		
		
		_entries = new Array();
		
		//_containerRanking
		
		for (i in 0..._nbentry) 
		{
			var _entry:RankingEntry = new RankingEntry();
			_containerEntries.addChild(_entry);
			_entry.x = 0;
			_entry.y = i * 24;
			_entries.push(_entry);
		}
		
	}
	
	public function setLoadingVisible(_value:Bool):Void
	{
		_containerEntries.visible = !_value;
		_loaderAnim.visible = _value;
		if (_value) _loaderAnim.start();
		else _loaderAnim.stop();
	}
	
	
	
	public function setData(_data:Array<Object>):Void
	{
		trace("ViewRanking.setData");
		trace(_data);
		
		var _position:Int = 1;
		for (i in 0..._nbentry) 
		{
			var _obj:Object = _data[i];
			if (_obj != null) {
				_entries[i].setContent(_position, _obj.nickname, _obj.score);
				_entries[i].visible = true;
			}
			else {
				_entries[i].visible = false;
			}
			
			
			_position++;
		}
	}
	
	
}