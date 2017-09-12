package game.entity;
import com.vinc.game.nape.factory.IGameItemFactory;
import com.vinc.game.nape.NapeEntity;
import starling.display.Image;
import starling.textures.Texture;
import starling.utils.AssetManager;

/**
 * ...
 * @author Vincent Huss
 */
class GroundEntity extends NapeEntity implements IGameItemFactory
{
	var _img:Image;

	public function new() 
	{
		super();
	}
	
	
	public function init(assets:AssetManager):Void
	{
		var _text:Texture = assets.getTexture("game/ground");
		_img = new Image(_text);
		
		listGraphics = new Array();
		listGraphics.push(_img);
		
	}
	
	public function destroy():Void
	{
		_img.dispose();
	}
	
	
	
}