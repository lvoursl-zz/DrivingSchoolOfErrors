package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
/**
 * ...
 * @author lvoursl
 */
class Car extends Sprite 
{

	public var bmp:Bitmap;
	var myX:Float = 50;
	var myY:Float = 620;
	
	public function new() 
	{
		super();
		bmp = new Bitmap(Assets.getBitmapData("img/car.png"));
		bmp.x = myX;
		bmp.y = myY;
		bmp.scaleX = 0.5;
		bmp.scaleY = 0.5;
	}
	var speed:Int = 0;
	var speedLimit:Int = 8;
	var speedStep:Int = 5;
	var rotLimit:Int = 35;
	var rotStep:Int = 3;
	
	public function moveCar() {
		if (Main.keys[38]) {
			// ГАЗ
			myX+=5;
		} if (Main.keys[40]) {
			// ТОРМОЗ
			myX -= 5;
		} if (Main.keys[37]) {
			// ЛЕВО
			this.rotation -= 1;
			this.bmp.rotation = this.rotation;
			myY += 5;
		} if (Main.keys[39]) {
			// ПРАВО
			this.rotation += 1;
			this.bmp.rotation = this.rotation;
			myY -= 5;
		} 
		bmp.x = myX;
		bmp.y = myY;
	}
} 