package game.entity;
import com.vinc.game.nape.factory.IGameItemFactory;
import com.vinc.game.nape.NapeEntity;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import openfl.geom.Point;
import starling.display.Image;
import starling.textures.Texture;
import starling.utils.AssetManager;

/**
 * ...
 * @author Vincent Huss
 */
class TuyauxEntity extends NapeEntity implements IGameItemFactory
{
	private var _bodyTop:Body;
	private var _bodyBottom:Body;
	
	static private inline var ITEM_WIDTH:Int = 86;
	static private inline var ITEM_HEIGHT:Int = 500;
	var _imgtop:Image;
	var _imgbottom:Image;
	

	public function new() 
	{
		super();
		
	}
	
	public function init(_space:Space, assets:AssetManager):Void
	{
		listGraphics = new Array();
		
		var _text:Texture = assets.getTexture("game/pipe");
		_imgtop = new Image(_text);
		
		_imgbottom = new Image(_text);
		_imgbottom.rotation = Math.PI;
		
		
		listGraphics.push(_imgtop);
		listGraphics.push(_imgbottom);
		
		trace("HEIGHT_ITEM : " + ITEM_HEIGHT);
		_bodyTop = new Body(BodyType.KINEMATIC);
		_bodyTop.shapes.add(new Polygon(Polygon.rect(0, 0, ITEM_WIDTH, ITEM_HEIGHT)));
		_bodyTop.space = _space;
		
		_bodyBottom = new Body(BodyType.KINEMATIC);
		_bodyBottom.shapes.add(new Polygon(Polygon.rect(0, 0, ITEM_WIDTH, ITEM_HEIGHT)));
		_bodyBottom.space = _space;
		
		listBody = new Array();
		listBody.push(_bodyTop);
		listBody.push(_bodyBottom);
		
		
		
	}	
	
	
	
	public function destroy():Void
	{
		_bodyBottom.shapes.clear();
		_bodyBottom.space = null;
		
		_bodyTop.shapes.clear();
		_bodyTop.space = null;
		
		_imgbottom.dispose();
		_imgtop.dispose();
	}
	
	
	override public function updateGraphic():Void 
	{
		_imgtop.x = _bodyTop.position.x;
		_imgtop.y = _bodyTop.position.y;
		
		_imgbottom.x = _bodyBottom.position.x + ITEM_WIDTH;
		_imgbottom.y = _bodyBottom.position.y + ITEM_HEIGHT;
	}
	
}