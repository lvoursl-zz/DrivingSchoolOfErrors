package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
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
		addChild(car.bmp);
		//car.bmp.rotation = 90;
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed_handler);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased_handler);
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
		car.moveCar();
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
