package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.utils.Object;
/**
 * ...
 * @author lvoursl
 */
class Car extends Sprite 
{

	public var bmp:Bitmap;
	
	public function new() 
	{
		super();
		bmp = new Bitmap(Assets.getBitmapData("img/car.png"));
		this.x = 90;
		this.y = 670;
		bmp.x = - bmp.width / 2;
		bmp.y = - bmp.height / 2;
		//bmp.scaleX = 0.5;
		//bmp.scaleY = 0.5;
		this.addChild(bmp);
	}
	
	public var FRICTIONMOD:Float = 0.97; // 1 = no friction
				
		public var MAXSPEED:Float = 10;
		public var ACCELERTAION:Float = 0.25;
		public var REVERSEMAXSPEED:Float = -2;
		public var REVERSEACCELERTAION:Float = 0.2;
		public var MAXTURNRATE:Float = 5;
		public var TURNIMPACTONSPEED = 0.99; // less is more

		public var speed:Float = 0;
		public var pressedKeys:Object = {}; 
		private var pressUp:Bool = false;
		private var pressDown:Bool = false;
		private var pressLeft:Bool = false;
		private var pressRight:Bool = false;
		private var pressSpace:Bool = false;
		private var pressCtrl:Bool = false;
		
		public function setDefault() {
			this.x = 70;
			this.y = 650;
			bmp.x = - bmp.width / 2;
			bmp.y = - bmp.height / 2;
			FRICTIONMOD = 0.97; // 1 = no friction
				
			MAXSPEED= 10;
			ACCELERTAION = 0.25;
			
			REVERSEMAXSPEED = -2;
			REVERSEACCELERTAION = 0.2;
			
			MAXTURNRATE = 5;
			TURNIMPACTONSPEED = 0.99; // less is more
			
			speed= 0;
			pressedKeys = {}; 
			pressUp = false;
			pressDown = false;
			pressLeft = false;
			pressRight = false;
			pressSpace = false;
			pressCtrl = false;
		}
		
		public function ModifyCar(eFrame:Event)
		{
			if (pressUp && !pressCtrl) 
				speed += ACCELERTAION;
			speed = speed * FRICTIONMOD;
			
			// reversing
			if (pressDown) 
				speed -= REVERSEACCELERTAION;
			
	
			if (pressRight) 
			{   
		
				if (speed > MAXSPEED/4)
					this.rotation += MAXTURNRATE;
			
				else if (speed < (MAXSPEED/4) && speed >= 0)     
					this.rotation += ((MAXTURNRATE/4) * speed);
							
				else if (speed < 0) 
					this.rotation += (MAXTURNRATE * speed / ((MAXSPEED/4)*3));
				
				speed *= TURNIMPACTONSPEED;
			}
			
			// turning left
			if (pressLeft) 
			{   
				if (speed > MAXSPEED/4)    
					this.rotation -= MAXTURNRATE;    
			
				else if (speed < (MAXSPEED/4) && speed >= 0)    
					this.rotation -= (MAXTURNRATE/4) * speed;    
							
				else if (speed < 0)   
					this.rotation -= MAXTURNRATE * speed / ((MAXSPEED/4)*3);
				
				speed *= TURNIMPACTONSPEED;
			}
			
			// some very clever maths
			this.x += Math.sin (this.rotation * Math.PI / 180) * speed;
			this.y += Math.cos (this.rotation * Math.PI / 180) * -speed;
			
			// cap the speed to max speed
			if (Math.abs (speed) > MAXSPEED) 
				speed = MAXSPEED;
			
			if (speed < REVERSEMAXSPEED)   
				speed = REVERSEMAXSPEED;
		
			// handrake
			if (pressCtrl) 
			{    
				speed -= speed / (MAXSPEED/2);
				
				// skid
				if (pressRight)     
					this.rotation += speed / 2;
				if (pressLeft)        
					this.rotation -= speed / 2;    
			}
		}
		
		public function keyDownHandler(e:KeyboardEvent)
		{
			modifyKeyStatus(e, true);
		}
		public function keyUpHandler(e:KeyboardEvent)
		{
			modifyKeyStatus(e, false);
		}
		
		public function modifyKeyStatus(e:KeyboardEvent, keyActive:Bool)
		{			
			switch(e.keyCode)
			{
				case 38 : 
					pressUp = keyActive;
				case 40 :
					pressDown = keyActive;
				case 39 :
					pressRight = keyActive;
				case 37 :
					pressLeft = keyActive;
				case 32 :
					pressSpace = keyActive;
				case 17 :
					pressCtrl = keyActive;
			}
		}
		
		public function KillControl()
		{
			this.removeEventListener(Event.ENTER_FRAME, ModifyCar);
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			
			pressDown = false;
			pressUp = false;
			pressRight = false;
			pressLeft = false;
			pressSpace = false;
			pressCtrl = false;
		}
}
