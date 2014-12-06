package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.StageDisplayState;
import openfl.events.KeyboardEvent;

/**
 * ...
 * @author lvoursl
 */

class Main extends Sprite 
{
	var inited:Bool;
	var game:Game;
	var frame:Int = 0;
	public static var keys:Map<Int,Bool> = new Map();
	var car:Car;
	var scale:Float = 1;
	var canGo:Bool = true;
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		Lib.current.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		
		game = new Game();
		addChild(game);
		car = new Car();
		addChild(car);
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, car.keyDownHandler);
		stage.addEventListener(KeyboardEvent.KEY_UP, car.keyUpHandler);
		stage.addEventListener(Event.ENTER_FRAME, car.ModifyCar);
		stage.addEventListener(Event.ENTER_FRAME, onFrame);
		//addEventListener(Event.ENTER_FRAME, car.Update, false, 0 , true);
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	public function keyReleased_handler(e:KeyboardEvent) { 
		keys[e.keyCode] = false;
	}
	
	public function keyPressed_handler(e:KeyboardEvent) {
		keys[e.keyCode] = true;
	}
	
	public function onFrame(e:Event) {
		frame++;
		for (tile in game.arrayOfFields) {
			if (car.bmp.hitTestObject(tile)) {
				if (scale < 1.6) {
					car.bmp.width = car.bmp.width / scale;
					car.bmp.height = car.bmp.height / scale;
					scale += 0.1;
				}
				car.setDefault();				
				break;
			}
		}
		
		for (finishTile in game.finishTilesArray) {
			if (car.bmp.hitTestObject(finishTile)) {
				var screen = new Screen();
				addChild(screen);
				break;
			}
		}
		
		if (!canGo) {
			for (tile in game.trafficLightArray) {
				if (car.bmp.hitTestObject(tile)) {
					if (scale < 1.6) {
						car.bmp.width = car.bmp.width / scale;
						car.bmp.height = car.bmp.height / scale;
						scale += 0.1;
					}
					car.setDefault();				
					break;
				}
			}
		}
		
		if ((frame % 200) == 0) onTrafficLight();
		if ((frame % 230) == 0) offTrafficLight();
		if ((frame % 1000) == 0) frame = 0;
	}
	
	public function onTrafficLight() {
		for (lite in game.trafficLightArray) {
			lite.bitmapData = Assets.getBitmapData("img/red.png"); 
			canGo = false;
		}
	}
	
	public function offTrafficLight() {
		for (lite in game.trafficLightArray) {
			lite.bitmapData = Assets.getBitmapData("img/green.png"); 
			canGo = true;
		}
	}
	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
