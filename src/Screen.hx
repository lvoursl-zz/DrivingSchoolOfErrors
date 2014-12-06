package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
/**
 * ...
 * @author lvoursl
 */
class Screen extends Sprite
{
	var screenText:TextField;
	
	public function new() 
	{
		super();
		var bg = new Sprite();
		bg.graphics.beginFill(0x2c86ba);
		bg.graphics.drawRect(0, 0, 1366, 768);
		bg.graphics.endFill();
		addChild(bg);
		var tf = new TextFormat();
		tf.font = "Ariel";
		tf.size = 25;
		screenText = new TextField();
		screenText.multiline = true;
		screenText.htmlText = "Вы победили!<br><br>Большое спасибо за то, что сыграли:)<br>Пожалуйста, закройте игру с помощью ALT + F4.";
		screenText.autoSize = TextFieldAutoSize.CENTER;
		screenText.textColor = 0xffffff;
		screenText.x = 480;
		screenText.y = 230;
		screenText.setTextFormat(tf);
		addChild(screenText);
	}
	
}