package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author lvoursl
 */
class Road extends Sprite
{
	var bmp:Bitmap;
	
	public function new() 
	{
		super();
		bmp = new Bitmap(Assets.getBitmapData("img/road.png");
	}
	
}