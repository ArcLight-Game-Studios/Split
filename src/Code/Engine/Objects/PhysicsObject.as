package Code.Engine.Objects 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import Code.Engine.CollisionDetection.CollisionBound;
	import Code.Engine.CollisionDetection.CollisionDetector;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Base class for player controlled objects.
	 * Provides basic functionality for multi-directional movement,
	 * collision detection, collision handling, and the application of gravity.
	 * This class is to be extended to provide full functionality.
	 * 
	 * @see States class
	 * 
	 * @author Mark W. Thompson
	 */
	public class PhysicsObject extends MovieClip 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/* X-Axis Movement */
		protected var xVelocity:int = 0;
		protected var maxXVelocity:int = 8;
		protected var maxNegativeXVelocity:int = -8;
		protected var xAcceleration:int = 2;
		/* Y-Axis Movement */
		protected var yVelocity:int = 0;
		protected var maxYVelocity:int = 7;
		protected var maxNegativeYVelocity:int = -10;
		protected var onGround:Boolean = false;
		protected var gravityEnabled:Boolean = true;
		/* Collision */
		public var topBound:CollisionBound;
		public var bottomBound:CollisionBound;
		public var leftBound:CollisionBound;
		public var rightBound:CollisionBound;
		public var collisionBounds:Array;

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function PhysicsObject() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
			
			var boundGap:Number = 1;
			
			// Standard collision bounds.
			bottomBound = new CollisionBound(new Point(boundGap, height), new Point((width - boundGap), height));
			rightBound = new CollisionBound(new Point(width, boundGap), new Point(width, (height - boundGap)));
			leftBound = new CollisionBound(new Point(0, boundGap), new Point(0, (height - boundGap)));	
			topBound = new CollisionBound(new Point(boundGap, 0), new Point((width - boundGap), 0));
			
			collisionBounds = new Array(bottomBound, topBound, leftBound, rightBound); 
			
			addEventListener(CollisionDetector.COLLISION_DETECTED, OnCollision);
		}
		
		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(e:Event):void 
		{
			addChild(bottomBound);
			addChild(rightBound);
			addChild(leftBound);
			addChild(topBound);
			
			trace("Physics object initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Protected methods
		//--------------------------------------
		protected function UpdatePosition():void 
		{
			x += xVelocity;
			y -= yVelocity;
		}
		
		protected function ApplyGravity():void 
		{
			// When object is on the ground, gravity is disabled.
			if (onGround)
				gravityEnabled = false;
			
			// Enables gravity if falling.
			if ((!gravityEnabled) && (!onGround))
				gravityEnabled = true;
			
			// Simulates falling.
			if ((gravityEnabled) && (yVelocity != maxNegativeYVelocity))
				yVelocity--;
		}

		//--------------------------------------
		//  Event handlers
		//--------------------------------------
		/* Handles all collisions using the collision bounds to 
		 * determine how to deal with the collision.
		 * This function will not work properly if the registration point of 
		 * the object extending this class is not in the top left corner.
		 */
		protected function OnCollision(e:Event):void 
		{
			if (bottomBound.hit)
			{
				// Positions the physics object on top of the collision object.
				y = (bottomBound.objectBounds.y - height);
				yVelocity = 0;
				onGround = true;
			} 
			
			if (rightBound.hit)
			{
				// Positions the physics object to the right of the collision object.
				x = (rightBound.objectBounds.x - width);
				xVelocity = 0;
			} 
			
			if (leftBound.hit)
			{
				// Positions the physics object to the left of the collision object.
				x = (leftBound.objectBounds.x + leftBound.objectBounds.width);
				xVelocity = 0;
			}
			
			if (topBound.hit)
			{
				// Positions the physics object underneath the collision object.
				y = (topBound.objectBounds.y + topBound.objectBounds.height);
				yVelocity = 0;
			}
		}
	}
}
