package game;
import com.vinc.common.BroadCaster;
import com.vinc.debug.KeyboardDebug;
import com.vinc.fx.ScreenBlink;
import com.vinc.game.nape.factory.GameItemFactory;
import com.vinc.game.nape.factory.GameItemFactoryEvent;
import com.vinc.game.nape.factory.IGameItemFactory;
import com.vinc.math.Math2;
import com.vinc.navigation.Navigation;
import com.vinc.time.DelayManager;
import com.vinc.xtends.FSprite;
import game.assets.HeroAsset;
import game.entity.GroundEntity;
import game.entity.HeroEntity;
import game.entity.TuyauxEntity;
import js.Cookie;
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.geom.Mat23;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;
import nape.util.Debug;
import nape.util.ShapeDebug;
import openfl.display.DisplayObjectContainer;
import openfl.display.Graphics;
import openfl.display.Shape;
import openfl.display.Stage;
import openfl.media.Sound;
import openfl.ui.Keyboard;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.QuadBatch;
import starling.display.Sprite;
import starling.events.Event;


/**
 * ...
 * @author Vincent Huss
 */
class GameEngine
{
	private var _container:Sprite;
	
	private static inline var SPACE_ITEMS:Int = 200;
	private static inline var FIRST_ITEM:Int = 400;
	private static inline var SPEED_CAMERA:Float = 3.2;	//3.3 before
	
	
	var space:Space;
	var debug:Debug;
	var _openflstage:Stage;
	
	var bodyFloor:nape.phys.Body;
	var _containerDebug:FSprite;
	
	var _started:Bool;
	var _waitingstart:Bool;
	var _isgameover:Bool;
	
	var _containerScroll:QuadBatch;
	var _lastTuyaux:TuyauxEntity;
	var _heroEntity:HeroEntity;
	var _factoryTuyaux:GameItemFactory;
	var _factoryGround:GameItemFactory;
	var _cameraContainer:Sprite;
	var _cbTypeObstacle:CbType;
	var _ctTypeHero:CbType;
	var _nbpts:Int;
	
	
	
	public function new(__openflstage:Stage, __container:Sprite) 
	{
		_container = __container;
		_openflstage = __openflstage;
		
		_cameraContainer = new Sprite();
		_container.addChild(_cameraContainer);
		
		
		
		//_____________________________________________
		//nape
		
		_ctTypeHero=new CbType();
		_cbTypeObstacle = new CbType();
		
		var w = Constants.GAME_WIDTH;
        var h = Constants.GAME_HEIGHT;
		
		var gravity = Vec2.weak(0, 1200);
		space = new Space(gravity);
		debug = new ShapeDebug(w, h);
		
		
		_containerDebug = new FSprite();
		_containerDebug.addChild(debug.display);
		Starling.current.nativeOverlay.addChild(_containerDebug);
		
		
		
		
		
		
		
		_factoryTuyaux = new GameItemFactory(TuyauxEntity);
		_factoryTuyaux.marginLeft = -86;
		_factoryTuyaux.marginRight = 500;
		_factoryTuyaux.interval = 79;
		_factoryTuyaux.firststep = 330;
		_factoryTuyaux.addEventListener(GameItemFactoryEvent.ADD_ITEM, onAddTuyaux);
		_factoryTuyaux.addEventListener(GameItemFactoryEvent.REMOVE_ITEM, onRemoveTuyaux);
		
		
		_factoryGround = new GameItemFactory(GroundEntity);
		_factoryGround.marginLeft = -200;
		_factoryGround.marginRight = 500;
		_factoryGround.interval = Std.int(200 / SPEED_CAMERA - 1);
		_factoryGround.firststep = 0;
		_factoryGround.addEventListener(GameItemFactoryEvent.ADD_ITEM, onAddGround);
		_factoryGround.addEventListener(GameItemFactoryEvent.REMOVE_ITEM, onRemoveGround);
		
		
		
		
		
		_container.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		
		_containerScroll = new QuadBatch();
		_cameraContainer.addChild(_containerScroll);
		
		
		
		
		
		_heroEntity = new HeroEntity();
		Vars.zoneCenterHomepage.addChild(_heroEntity.getGraphic());
		
		
		_heroEntity.space = space;
		_heroEntity.listBody[0].cbTypes.add(_ctTypeHero);
		//_heroEntity.start(SPEED_CAMERA * _openflstage.frameRate);
		
		
		_heroEntity.setPosition(202, 115);
		_heroEntity.updateGraphic();
		_heroEntity.enableSinusAnim(true);
		_heroEntity.playAnimWaiting();
		
		
		var interactionListener:InteractionListener;
		
		interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _ctTypeHero, _cbTypeObstacle, onCollision);
		space.listeners.add(interactionListener);
		//interactionListener.space = space;
		
		_waitingstart = true;
		
		stop();
	}
	
	
	
	function onCollision(collision:InteractionCallback) :Void
	{
		trace("onCollision " + collision.int1 + ", " + collision.int2);
		if (!_isgameover) {
			BroadCaster.dispatchEvent(new Event("GAMEOVER"));
			_isgameover = true;
			_factoryTuyaux.reset();
			
			Vars.assets.getSound("hit").play();
			DelayManager.add("", 200, function():Void
			{
				Vars.assets.getSound("fall").play();
			});
			
		}
	}
	
	public function getScore():Int
	{
		return _nbpts;
	}
	
	
	
	public function isStarted():Bool
	{
		return _started;
	}
	
	
	public function jump():Void 
	{
		if (_heroEntity.listBody[0].position.y < 30) return;
		_heroEntity.jump();
		var _sound:Sound = Vars.assets.getSound("wing_flap");
		trace("_sound: " + _sound);
		_sound.play();
	}
	
	
	
	
	private function onAddGround(e:GameItemFactoryEvent):Void 
	{
		var _item:GroundEntity = cast(e.item, GroundEntity);
		_item.init(LoaderManager.am());
		
		var _x:Float = Math.floor(e.progress * SPEED_CAMERA);
		_item.listGraphics[0].x = _x;
		_item.listGraphics[0].y = 640;
		
		
		updateQuadBatch();
		
	}
	
	
	
	private function onAddTuyaux(e:GameItemFactoryEvent):Void 
	{
		trace("onAddTuyaux " + e.progress);
		var _item:TuyauxEntity = cast(e.item, TuyauxEntity);
		_item.init(space, LoaderManager.am());
		
		var _x:Float = e.progress * SPEED_CAMERA;
		
		var _miny:Int = -310;
		var _maxy:Int = -90;
		
		
		
		var _ybase:Float = Math2.random(_miny, _maxy, 1);
		//_ybase = Math2.getRandProbability(0.5) ? _miny : _maxy;
		
		var _space:Int = 660;
		
		
		_item.listBody[0].position.setxy(_x, _ybase);
		_item.listBody[1].position.setxy(_x, _ybase + _space);
		
		_item.listBody[0].cbTypes.add(_cbTypeObstacle);
		_item.listBody[1].cbTypes.add(_cbTypeObstacle);
		
		_item.updateGraphic();
		
		updateQuadBatch();
	}
	
	private function onRemoveTuyaux(e:GameItemFactoryEvent):Void 
	{
		trace("onRemoveTuyaux");
		updateQuadBatch();
	}
	
	private function onRemoveGround(e:GameItemFactoryEvent):Void
	{
		updateQuadBatch();
	}
	
	public function reset() 
	{
		
		_cameraContainer.addChild(_heroEntity.getGraphic());
		
		_factoryTuyaux.reset();
		_factoryGround.reset();
		updateQuadBatch();
		
		_heroEntity.reset();
		
		_heroEntity.playAnimWaiting();
		
		_heroEntity.setPosition(148, 386);
		_heroEntity.updateGraphic();
		
		_cameraContainer.x = 0;
		
		_waitingstart = true;
		_isgameover = false;
		
		_nbpts = 0;
		BroadCaster.dispatchEvent(new Event("COUNTER", false, _nbpts));
		
		_heroEntity.enableSinusAnim(true);
	}
	
	public function start():Void
	{
		reset();
		_lastTuyaux = null;
		_started = true;
		_waitingstart = false;
		_isgameover = false;
		
		_heroEntity.enableSinusAnim(false);
	}
	
	
	
	public function stop():Void
	{
		_started = false;
		_heroEntity.listBody[0].velocity.x = 0;
	}
	
	public function isGameOver() 
	{
		return _isgameover;
	}
	
	
	
	
	
	
	
	private function enterFrameHandler(e:Event):Void 
	{
		//trace("GameEngine.enterFrameHandler");		
		
		if (!_waitingstart) {
			if (_started) {
				
				//trace("floor position : " + floor.position.x);
				/*
				debug.clear();
				debug.draw(space);
				debug.flush();
				
				_containerDebug.scaleX = _containerDebug.scaleY = Vars.containerBG.scaleX;
				_containerDebug.x = _container.x * _containerDebug.scaleX;
				_containerDebug.y = _container.y * _containerDebug.scaleY;
				*/
				
				
				_cameraContainer.x -= SPEED_CAMERA;
				
				_factoryTuyaux.progress++;
				_factoryTuyaux.update();
				
				_factoryGround.progress++;
				_factoryGround.update();
				
				_heroEntity.stepX(SPEED_CAMERA);
				
				
				
				var _nbptstmp:Int = Math.floor((_factoryTuyaux.progress - _factoryTuyaux.firststep + 117) / _factoryTuyaux.interval);
				
				if (_nbptstmp > _nbpts) {
					trace("_nbpts : " + _nbpts);
					_nbpts = _nbptstmp;
					BroadCaster.dispatchEvent(new Event("COUNTER", false, _nbpts));
					Vars.assets.getSound("counter").play();
				}
				
			}
			
			space.step(1 / _openflstage.frameRate);
			
			var _maxvelocity:Float = 700;
			if (_heroEntity.listBody[0].velocity.y > _maxvelocity) _heroEntity.listBody[0].velocity.y = _maxvelocity;
			
			var _floorY:Float = 641 - 24;
			if (_heroEntity.listBody[0].position.y >= _floorY) {
				_heroEntity.listBody[0].position.y = _floorY;
				
				if (!_isgameover) {
					BroadCaster.dispatchEvent(new Event("GAMEOVER"));
					_isgameover = true;
					
					Vars.assets.getSound("hit").play();
				}
				
			}
			
			
		}
		else {
			_factoryGround.progress++;
			_factoryGround.update();
			_cameraContainer.x -= SPEED_CAMERA;
			
			if (_heroEntity.getGraphic().parent != Vars.zoneCenterHomepage) _heroEntity.stepX(SPEED_CAMERA);
			
		}
		
		
		
		_heroEntity.updateGraphic();
		
		
	}
	
	
	
	function updateQuadBatch():Void
	{
		_containerScroll.reset();
		
		
		var _items:Array<IGameItemFactory> = _factoryTuyaux.getItems();
		
		var _len:Int = _items.length;
		//trace("item len update : " + _len);
		for (i in 0..._len) 	
		{
			var _tuyaux:TuyauxEntity = cast(_items[i], TuyauxEntity);
			
			var _imgs:Array<DisplayObject> = _tuyaux.listGraphics;
			_containerScroll.addImage(cast(_imgs[0], Image));
			_containerScroll.addImage(cast(_imgs[1], Image));
		}
		
		var _items2:Array<IGameItemFactory> = _factoryGround.getItems();
		var _len:Int = _items2.length;
		//trace("item len update : " + _len);
		for (i in 0..._len) 	
		{
			var _ground:GroundEntity = cast(_items2[i], GroundEntity);
			
			var _imgs:Array<DisplayObject> = _ground.listGraphics;
			_containerScroll.addImage(cast(_imgs[0], Image));
			
		}
	}
	
	
	
	
}