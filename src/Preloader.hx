package;


import openfl.display.Sprite;
import openfl.events.Event;


@:keep class Preloader extends Sprite {
	
	
	private var progress:Sprite;
	
		
	public function new () {
		
		super ();
		trace("Preloader.new");
		
		progress = new Sprite ();
		progress.graphics.beginFill (0xFF0000);
		progress.graphics.drawRect (0, 0, 300, 100);
		addChild (progress);
		
		progress.scaleX = 0;
		
		
	}
		
	
	
	public function onInit ():Void {
		
		trace ("Preloader.init");
		
	}
	
	
	public function onLoaded ():Void {
		
		trace ("Preloader.loaded");
		
		var delay = 60;
		
		addEventListener (Event.ENTER_FRAME, function (_) {
			
			delay--;
			
			if (delay == 0) {
				
				trace ("delayed start");
				dispatchEvent (new Event (Event.COMPLETE));
				
			}
			
		});
		
	}
	
	
	public function onUpdate (bytesLoaded:Int, bytesTotal:Int):Void {
		
		trace ("Preloader.update: " + bytesLoaded + "/" + bytesTotal);
		
		if (bytesTotal == 0) {
			
			progress.scaleX = 0;
			
		} else {
			
			progress.scaleX = bytesLoaded / bytesTotal;
			
		}
		
	}
	
	
}