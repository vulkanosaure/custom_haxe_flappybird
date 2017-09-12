package game.assets;
import openfl.events.TimerEvent;
import openfl.geom.Point;
import openfl.utils.Timer;
import openfl.Vector;
import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

/**
 * ...2
 * @author Vincent Huss
 */
class HeroAsset extends Sprite
{
	static public var DIMENSION:Point = new Point(57, 39);
	static private inline var NB_FRAME:Int = 3;
	
	private var _playing:Bool;
	private var _way:Int;
	var _mc:MovieClip;
	var _timer:Timer;
	var _sinusAnim:Bool;
	var _counterSinus:Int;

	public function new() 
	{
		super();
		
        var _frames:Vector<Texture> = LoaderManager.am().getTextures("game/hero");
		trace("_frames len : " + _frames.length);
		_mc = new MovieClip(_frames);
		_mc.fps = 4;
		
		_mc.x = -Math.round(DIMENSION.x / 2);
		_mc.y = -Math.round(DIMENSION.y / 2);
		
		addChild(_mc);
		_mc.stop();
		Starling.current.juggler.add(_mc);
		
		_timer = new Timer(500);
		_timer.addEventListener(TimerEvent.TIMER, onTimer);
		_timer.start();
		
		_sinusAnim = false;
		_playing = false;
		
		this.addEventListener(Event.ENTER_FRAME, onEnterframe);
		
	}
	
	private function onEnterframe(e:Event):Void 
	{
		if (_sinusAnim) {
			var _y:Int = Math.round(Math.sin(_counterSinus * 0.14) * 4);
			_mc.y = _y;
			
			_counterSinus++;
		}
	}
	
	private function onTimer(e:TimerEvent):Void 
	{
		if (_playing) {
			//trace("_mc.currentFrame : " + _mc.currentFrame);
			if (_way == 1) {
				if (_mc.currentFrame < NB_FRAME -1) _mc.currentFrame++;
				else {
					_mc.currentFrame--;
					_way = -1;
				}
			}
			else {
				if (_mc.currentFrame > 0) _mc.currentFrame--;
				else {
					_mc.currentFrame++;
					_way = 1;
				}
			}
		}
	}
	
	public function play(_fast:Bool):Void
	{
		_playing = true;
		_way = 1;
		
		_timer.delay = (_fast) ? 50 : 120;
		_timer.repeatCount = (_fast) ? 11 : 0;
		_mc.currentFrame = 0;
		
		_timer.reset();
		_timer.start();
		
	}
	public function stop():Void
	{
		_playing = false;
		_timer.stop();
	}
	
	
	
	
	
	public function enableSinusAnim(_value:Bool):Void
	{
		_sinusAnim = _value;
		_counterSinus = 0;
		_mc.y = -Math.round(DIMENSION.y / 2);
	}
	
	
}