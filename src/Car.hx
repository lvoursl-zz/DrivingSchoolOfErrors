package ;
import openfl.display.Sprite;
import box2D.collision.*;// bounding box of our world
import box2D.common.math.*;// for vector(define gravity)
import box2D.dynamics.*;// define bodies and define world
import box2D.dynamics.joints.*;
import box2D.collision.shapes.*;// define our shapes
/**
 * ...
 * @author lvoursl
 */
class Car extends Sprite 
{

	public function new() 
	{
		super();
		var MAX_STEER_ANGLE:Number = Math.PI/3;
		var STEER_SPEED = 1.5;
		var SIDEWAYS_FRICTION_FORCE:Number = 10;
		var HORSEPOWERS:Number = 40;
		var CAR_STARTING_POS:B2Vec2 = new B2Vec2(10,10);
		var leftRearWheelPosition:B2Vec2 = new B2Vec2(-1.5,1.90);
		var rightRearWheelPosition:B2Vec2 = new B2Vec2(1.5,1.9);
		var leftFrontWheelPosition:B2Vec2 = new B2Vec2(-1.5,-1.9);
		var rightFrontWheelPosition:B2Vec2 = new B2Vec2(1.5,-1.9);

		var engineSpeed:Number =0;
		var steeringAngle:Number = 0;

		var myWorld:B2World;

		var worldBox:B2AABB = new B2AABB();
		worldBox.lowerBound.Set(-100,-100);
		worldBox.upperBound.Set(100,100);
		myWorld = new B2World(worldBox, new B2Vec2(0,0) , true);

		//Create some static stuff
		var staticDef = new B2BodyDef();
		staticDef.position.Set(5,20);
		var staticBox = new B2PolygonDef();
		staticBox.SetAsBox(5,5);
		myWorld.CreateBody(staticDef).CreateShape(staticBox);
		staticDef.position.x = 25;
		myWorld.CreateBody(staticDef).CreateShape(staticBox);
		staticDef.position.Set(15, 24);
		myWorld.CreateBody(staticDef).CreateShape(staticBox);


		// define our body
		var bodyDef:B2BodyDef = new B2BodyDef();
		bodyDef.linearDamping = 1;
		bodyDef.angularDamping = 1;
		bodyDef.position = CAR_STARTING_POS.Copy()

		var body:B2Body = myWorld.CreateBody(bodyDef);
		body.SetMassFromShapes();

		var leftWheelDef:B2BodyDef = new B2BodyDef();
		leftWheelDef.position = CAR_STARTING_POS.Copy();
		leftWheelDef.position.Add(leftFrontWheelPosition);
		var leftWheel:B2Body = myWorld.CreateBody(leftWheelDef);

		var rightWheelDef:B2BodyDef = new B2BodyDef();
		rightWheelDef.position = CAR_STARTING_POS.Copy();
		rightWheelDef.position.Add(rightFrontWheelPosition);
		var rightWheel:B2Body = myWorld.CreateBody(rightWheelDef);

		var leftRearWheelDef:B2BodyDef = new B2BodyDef();
		leftRearWheelDef.position = CAR_STARTING_POS.Copy();
		leftRearWheelDef.position.Add(leftRearWheelPosition);
		var leftRearWheel:B2Body = myWorld.CreateBody(leftRearWheelDef);

		var rightRearWheelDef:B2BodyDef = new B2BodyDef();
		rightRearWheelDef.position = CAR_STARTING_POS.Copy();
		rightRearWheelDef.position.Add(rightRearWheelPosition);
		var rightRearWheel:B2Body = myWorld.CreateBody(rightRearWheelDef);

		// define our shapes
		var boxDef:B2PolygonDef = new B2PolygonDef();
		boxDef.SetAsBox(1.5,2.5);
		boxDef.density = 1;
		body.CreateShape(boxDef);

		//Left Wheel shape
		var leftWheelShapeDef = new B2PolygonDef();
		leftWheelShapeDef.SetAsBox(0.2,0.5);
		leftWheelShapeDef.density = 1;
		leftWheel.CreateShape(leftWheelShapeDef);

		//Right Wheel shape
		var rightWheelShapeDef = new B2PolygonDef();
		rightWheelShapeDef.SetAsBox(0.2,0.5);
		rightWheelShapeDef.density = 1;
		rightWheel.CreateShape(rightWheelShapeDef);

		//Left Wheel shape
		var leftRearWheelShapeDef = new B2PolygonDef();
		leftRearWheelShapeDef.SetAsBox(0.2,0.5);
		leftRearWheelShapeDef.density = 1;
		leftRearWheel.CreateShape(leftRearWheelShapeDef);

		//Right Wheel shape
		var rightRearWheelShapeDef = new B2PolygonDef();
		rightRearWheelShapeDef.SetAsBox(0.2,0.5);
		rightRearWheelShapeDef.density = 1;
		rightRearWheel.CreateShape(rightRearWheelShapeDef);

		Body.SetMassFromShapes();
		leftWheel.SetMassFromShapes();
		rightWheel.SetMassFromShapes();
		leftRearWheel.SetMassFromShapes();
		rightRearWheel.SetMassFromShapes();

		var leftJointDef:B2RevoluteJointDef = new B2RevoluteJointDef();
		leftJointDef.Initialize(body, leftWheel, leftWheel.GetWorldCenter());
		leftJointDef.enableMotor = true;
		leftJointDef.maxMotorTorque = 100;

		var rightJointDef = new B2RevoluteJointDef();
		rightJointDef.Initialize(body, rightWheel, rightWheel.GetWorldCenter());
		rightJointDef.enableMotor = true;
		rightJointDef.maxMotorTorque = 100;

		var leftJoint:B2RevoluteJoint = B2RevoluteJoint(myWorld.CreateJoint(leftJointDef));
		var rightJoint:B2RevoluteJoint = B2RevoluteJoint(myWorld.CreateJoint(rightJointDef));

		var leftRearJointDef:B2PrismaticJointDef = new B2PrismaticJointDef();
		leftRearJointDef.Initialize(body, leftRearWheel, leftRearWheel.GetWorldCenter(), new B2Vec2(1,0));
		leftRearJointDef.enableLimit = true;
		leftRearJointDef.lowerTranslation = leftRearJointDef.upperTranslation = 0;

		var rightRearJointDef:B2PrismaticJointDef = new B2PrismaticJointDef();
		rightRearJointDef.Initialize(body, rightRearWheel, rightRearWheel.GetWorldCenter(), new B2Vec2(1,0));
		rightRearJointDef.enableLimit = true;
		rightRearJointDef.lowerTranslation = rightRearJointDef.upperTranslation = 0;

		myWorld.CreateJoint(leftRearJointDef);
		myWorld.CreateJoint(rightRearJointDef);


		// debug draw
		var dbgDraw:B2DebugDraw = new B2DebugDraw();
		dbgDraw.m_sprite = new Sprite();
		addChild(dbgDraw.m_sprite);
		dbgDraw.m_drawScale = 20.0;
		dbgDraw.m_fillAlpha = 0.3;
		dbgDraw.m_lineThickness = 1.0;
		dbgDraw.m_drawFlags = B2DebugDraw.e_shapeBit |B2DebugDraw.e_centerOfMassBit;
		myWorld.SetDebugDraw(dbgDraw);
	}
	
	


	//========== FUNCTIONS ==========

	//This function applies a "friction" in a direction orthogonal to the body's axis.
	function killOrthogonalVelocity(targetBody:B2Body){
		var localPoint = new B2Vec2(0,0);
		var velocity:B2Vec2 = targetBody.GetLinearVelocityFromLocalPoint(localPoint);
		
		var sidewaysAxis = targetBody.GetXForm().R.col2.Copy();
		sidewaysAxis.Multiply(B2Math.B2Dot(velocity,sidewaysAxis))

		targetBody.SetLinearVelocity(sidewaysAxis);//targetBody.GetWorldPoint(localPoint));
	}

	stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed_handler);
	stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased_handler);

	function keyPressed_handler(e:KeyboardEvent) {
		if(e.keyCode == Keyboard.UP){
			body.WakeUp();
			engineSpeed = -HORSEPOWERS;
		}
		if(e.keyCode == Keyboard.DOWN){
			engineSpeed = HORSEPOWERS;
		}
		if(e.keyCode == Keyboard.RIGHT){
			steeringAngle = MAX_STEER_ANGLE
		}
		if(e.keyCode == Keyboard.LEFT){
			steeringAngle = -MAX_STEER_ANGLE
		}
	}

	function keyReleased_handler(e:KeyboardEvent){
		if(e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN){
			engineSpeed = 0;
		} 
		if(e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT){
			steeringAngle = 0;
		}
	}

	addEventListener(Event.ENTER_FRAME, Update, false, 0 , true);

	function Update(e:Event):void {
		myWorld.Step(1/30, 8);
		killOrthogonalVelocity(leftWheel);
		killOrthogonalVelocity(rightWheel);
		killOrthogonalVelocity(leftRearWheel);
		killOrthogonalVelocity(rightRearWheel);

		//Driving
		var ldirection = leftWheel.GetXForm().R.col2.Copy();
		ldirection.Multiply(engineSpeed);
		var rdirection = rightWheel.GetXForm().R.col2.Copy()
		rdirection.Multiply(engineSpeed);
		leftWheel.ApplyForce(ldirection, leftWheel.GetPosition());
		rightWheel.ApplyForce(rdirection, rightWheel.GetPosition());
		
		//Steering
		var mspeed:Number;
		mspeed = steeringAngle - leftJoint.GetJointAngle();
		leftJoint.SetMotorSpeed(mspeed * STEER_SPEED);
		mspeed = steeringAngle - rightJoint.GetJointAngle();
		rightJoint.SetMotorSpeed(mspeed * STEER_SPEED);
	}
}