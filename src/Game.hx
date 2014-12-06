package ;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

/**
 * ...
 * @author lvoursl
 */
class Game extends Sprite
{
	public var field:Array<Int> = [];
	public var tilesSprite:Sprite = new Sprite();
	public var arrayOfFields:Array<Bitmap> = [];
	public var trafficLightArray:Array<Bitmap> = [];
	public var wall:Bool = false;
	public var trafficLite:Bool = false;
	public function new() 
	{
		super();
		setFieldFromBitmap();
		drawField();
		addChild(tilesSprite);
	}
	
	
	public function setFieldFromBitmap() {
		var bitmapData:BitmapData = Assets.getBitmapData("img/level.png");
		
		for (iy in 0 ... bitmapData.height) {
			for (ix in 0 ... bitmapData.width) {
				var color:UInt = bitmapData.getPixel(ix, iy);
				var cell:Int = switch(color) {
					case 0xffffff: 1;
					case 0x000000: 2;
					case 0xff0000: 3;
					default: 0;
				}
				field.push(cell);
			}
		}

	}
	
	public function drawField() {
		while (tilesSprite.numChildren > 0) tilesSprite.removeChildAt(0);
		
		var bitmapData:BitmapData = Assets.getBitmapData("img/level.png");
		
		for (iy in 0 ... bitmapData.height) {
			for (ix in 0 ... bitmapData.width) {
				var bmpData:BitmapData = switch(field[ix + iy * bitmapData.width]) {
					case 1: Assets.getBitmapData("img/wall.png");
					case 2: Assets.getBitmapData("img/road1.png");
					case 3: Assets.getBitmapData("img/green.png");
					default: null;
				}
				
				
				
				switch(field[ix + iy * bitmapData.width]) {
					case 1: wall = true;
					case 3: trafficLite = true;
					default: wall = false;
				}
				if (bmpData != null) {
					var bmp = new Bitmap(bmpData);
					bmp.scaleX = 0.25;
					bmp.scaleY = 0.25;
					bmp.x = ix * 10.5;
					bmp.y = iy * 10.9;
					tilesSprite.addChild(bmp);
					if (wall) {
						arrayOfFields.push(bmp);
						wall = false;
					}
					if (trafficLite) {
						trafficLightArray.push(bmp);
						trafficLite = false;
					}
				}
			}
		}
	}
}