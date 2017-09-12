package game.entity;
import com.vinc.game.nape.NapeEntity;
import game.assets.HeroAsset;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import starling.display.Sprite;

/**
 * ...
 * @author Vincent Huss
 */
class HeroEntity extends NapeEntity
{
	var _graphic:HeroAsset;
	var _body:Body;
	var _rotationWay:Int;
	var _counterWaiting:Int;

	public function new() 
	{
		super();
		
		_body = new Body(BodyType.DYNAMIC);
        _body.shapes.add(new Circle(18));
		
		listBody.push(_body);
		
		_body.mass = 12.0;
		
		
		_graphic = new HeroAsset();
		
		//_graphic.enableSinusAnim(true);
		//todo : handle outside of heroGraphic
		
		listGraphics.push(_graphic);
		
		
	}
	
	public function setPosition(_x:Int, _y:Int):Void
	{
		
        _body.position.setxy(_x, _y);
	}
	
	public function jump() :Void
	{
		listBody[0].velocity.y = 0;
		var _impulse:Vec2 = Vec2.weak(0, -5700);	
		listBody[0].applyImpulse(_impulse);
		
		_graphic.play(true);
		
		_rotationWay = -1;
		_counterWaiting = 0;
		
	}
	
	public function getGraphic():Sprite
	{
		return _graphic;
	}
	
	public function start(_velx:Float) 
	{
		listBody[0].velocity = Vec2.weak(_velx, 0);
	}
	
	public function stepX(_stepx:Float) :Void
	{
		listBody[0].position.x += _stepx;
	}
	
	public function reset() 
	{
		listBody[0].velocity.x = 0;
		listBody[0].velocity.y = 0;
		
		_rotationWay = 0;
		_graphic.rotation = 0;
	}
	
	
	
	
	
	public function playAnimWaiting() :Void
	{
		_graphic.play(false);
	}
	
	public function enableSinusAnim(_value:Bool):Void
	{
		_graphic.enableSinusAnim(_value);
	}
	
	
	override public function updateGraphic():Void 
	{
		super.updateGraphic();
		
		
		//trace("_graphic.rotation : " + _graphic.rotation);
		if (_rotationWay == -1) {
			if (_graphic.rotation > -Math.PI * 0.12) _graphic.rotation -= 0.21;
			else {
				_rotationWay = 1;
			}
			
		}
		else if (_rotationWay == 1) {	
			
			if(_counterWaiting < 26) _counterWaiting++;
			else if (_graphic.rotation < Math.PI * 0.5) {
				_graphic.rotation += 0.09;
			}
			else {
				_graphic.rotation = Math.PI * 0.5;
				_rotationWay = 0;
			}
		}
		
		
	}
	
	public function setVisible(_value:Bool) :Void
	{
		_graphic.visible = _value;
	}
	
	
}