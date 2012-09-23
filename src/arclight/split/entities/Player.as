package arclight.split.entities 
{
	import arclight.split.containers.Dimension;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import arclight.split.collision.CollisionDetector;
	import arclight.split.collision.CollisionBound;
	import arclight.split.TopLevel;
	import arclight.split.utils.KeyObject;

	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * This is the user controlled character.
	 * Responds to user input and reacts to the game environment. 
	 *
	 * @author Mark Thompson
	 */
	public class Player extends MovieClip 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/* X-Axis Movement */
		private var xVelocity:int = 0;
		private var maxXVelocity:int = 8;
		private var xAcceleration:int = 2;
		/* Y-Axis Movement */
		private var yVelocity:int = 0;
		private var maxYVelocity:int = 10;
		private var gravityEnabled:Boolean = true;
		/* Collision */
		public var topBound:CollisionBound;
		public var bottomBound:CollisionBound;
		public var leftBound:CollisionBound;
		public var rightBound:CollisionBound;
		public var collisionBounds:Array;
		/* Object */
		private var onGround:Boolean = false;
		private var spawn:Point;
		private var disabled:Boolean = false;
		private const BOUND_GAP:int = 2;
		/* Orientation */
		private var facingRight:Boolean = true;
		private var previousPosition:Point;
		/* Animations */
		private var currentAnimation:MovieClip = null;
		private var idle:MovieClip = new PlayerIdle();
		private var walk:MovieClip = new PlayerWalking();
		private var jump:MovieClip = new PlayerJumping();
		private var land:MovieClip = new PlayerLanding();
		private var death:MovieClip;
		/* Controls */
		private var key:KeyObject = new KeyObject(TopLevel.stage);
		private var ignoreKeys:Boolean = false;
		/* Jump */
		private var jumping:Boolean = false;
		private var jumpCooldown:int = 0;
		private var yPeak:int = 0;
		private var jumpBlocks:int = 5;
		private const JUMP_COOLDOWN:int = 5;
		private const JUMP_VELOCITY:int = 10;
		private const BLOCK_HEIGHT:int = 10;

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Player() 
		{
			if (TopLevel.stage) {
				Initialise();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, Initialise);
			}
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		/**
		 * @private
		 * Initialises the player object:
		 * Sets spawn point; Sets animation; Adds keyboard event listeners; 
		 */
		private function Initialise(event:Event = null):void 
		{	
			if (event) {
				removeEventListener(Event.ADDED_TO_STAGE, Initialise);
			}
			
			// Standard collision bounds.
			bottomBound = new CollisionBound(new Point(BOUND_GAP, height), new Point((width - BOUND_GAP), height));
			rightBound = new CollisionBound(new Point(width, BOUND_GAP), new Point(width, (height - BOUND_GAP)));
			leftBound = new CollisionBound(new Point(0, BOUND_GAP), new Point(0, (height - BOUND_GAP)));	
			topBound = new CollisionBound(new Point(BOUND_GAP, 0), new Point((width - BOUND_GAP), 0));
			
			collisionBounds = new Array(bottomBound, topBound, leftBound, rightBound); 

			addChild(bottomBound);
			addChild(rightBound);
			addChild(leftBound);
			addChild(topBound);
			
			spawn = new Point(x, y);
			PlayAnimation(idle);

			addEventListener(CollisionDetector.COLLISION_DETECTED, OnCollision);
			
			trace("Player initialised.");
		}

		//--------------------------------------
		//  Main Loop
		//--------------------------------------
		public function Update():void 
		{
			if (!disabled) {
				CheckForInput(); // Looks for WASD key presses and modifies x/y velocities.
				CheckIfJumping(); // Applies jump.
			}
			ApplyGravity(); // Modifies y velocity.
			
			UpdatePosition(); // Updates x/y values.
			
			// Prevents player from getting outwith the dimension.
			var p:Point = parent.localToGlobal(new Point(x, y));	
			
			if (x < 0) {
				x = 0;
			}
			if ((x + width) > 300)
			{
				x = 300 - width;
			}
			if ((p.y + height) > TopLevel.stage.stageHeight)
			{
				y = 750 - height;
				onGround = true;
			}
			if (p.y < 0) {
				y = 0;
				jumping = false;
				yVelocity = 0;
			}
			
			previousPosition = new Point(x, y);

			if (currentAnimation == death) { 
				// If reached end of death animation.
				if (currentAnimation.currentFrame == currentAnimation.totalFrames) {
					FlipRight();
					PlayAnimation(idle);
					x = spawn.x;
					y = spawn.y;
					xVelocity = 0;
					yVelocity = 0;
					disabled = false;
				}
			}
		}

		//--------------------------------------
		//  Public methods
		//--------------------------------------
		/* When the player dies:
		 * death animation is played and
		 * x/y velocities are zeroed.
		 */
		public function Die():void {
			if(!disabled) {
				death = new PlayerDeath();
				PlayAnimation(death);
				xVelocity = 0;
				yVelocity = 0;
				disabled = true;
			}
		}
		
		//--------------------------------------
		//  Private methods
		//--------------------------------------
		/* This function will not work if the player character registration
		 * point is located other than the top left.
		 * The override of this function allows for jumping to be reset and 
		 * to check for multiple collisions.
		 * If the player is dying no collisions will be made.
		 */
		private function OnCollision(event:Event):void {
			if (!disabled) {
				if (bottomBound.hit) {	
					if (!jumping) {
						// Note: yVelocity var has major effect.
						var previousBasePosition:int = previousPosition.y + height + yVelocity;
						var basePosition:int = y + height + yVelocity;
						
						// Previous position was above top of platform.
						if (previousBasePosition <= bottomBound.objectBounds.y)
						{
							// Current position above bottom of platform.
							if (basePosition <= (bottomBound.objectBounds.y + bottomBound.objectBounds.height))
							{
								// Positions the player on top of the collision object.
								y = (bottomBound.objectBounds.y - height);
								yVelocity = 0;
								onGround = true;
								jumping = false;
							}
						}
					}
				} 
				
				if (rightBound.hit) {
					xVelocity = 0;
					// Positions the player to the right of the collision object.
					if (facingRight)
						x = (rightBound.objectBounds.x - width);
					else
						x = ((rightBound.objectBounds.x + rightBound.objectBounds.width) + width);
				} 
				
				if (leftBound.hit) {	
					xVelocity = 0;
					// Positions the player to the left of the collision object.
					if (facingRight)
						x = (leftBound.objectBounds.x + leftBound.objectBounds.width);
					else
						x = leftBound.objectBounds.x;
				}
				
				if (topBound.hit) {
					// Previous position was below bottom of platform.
					if ((previousPosition.y + yVelocity) >= (topBound.objectBounds.y + topBound.objectBounds.height)) {
						// Current position below top of platform.
						if ((y + yVelocity) >= topBound.objectBounds.y) {
							y = (topBound.objectBounds.y + topBound.objectBounds.height);
							yVelocity = 0;
							jumping = false;
						}
					}
				}
			}
		}

		// This override additionally checks the player isn't jumping before enabling gravity.
		private function ApplyGravity():void 
		{
			if (onGround) {
				gravityEnabled = false;
			}
			
			// In the air.
			if ((!gravityEnabled) && (!jumping) && (bottomBound.hit == false)) {
				gravityEnabled = true;
				onGround = false;
			}
			
			// Gravity enabled - increase to max y velocity.
			if ((gravityEnabled) && (yVelocity != -maxYVelocity)) {
				yVelocity--;
			}
		}
		
		private function CheckForInput():void 
		{
			if (ignoreKeys == false) {

				if (key.IsDown(key.W)) {
					Jump();
				}
				
				// A - LEFT
				if (key.IsDown(key.A)) {
					rightBound.hit = false; // Temporary fix for "sticking" to the wall.
					//FlipLeft();
					if (xVelocity > 0) { // Prevents A+D "drift" bug.
						xVelocity = 0;	
					}
					if (xVelocity > -maxXVelocity) {
						xVelocity -= xAcceleration;
					}
				}
				
				// D - RIGHT
				if (key.IsDown(key.D)) {
					leftBound.hit = false; // Temporary fix for "sticking" to the wall.
					//FlipRight();
					if (xVelocity < 0) { // Prevents A+D "drift" bug.
						xVelocity = 0;
					}
					if (xVelocity < maxXVelocity) {
						xVelocity += xAcceleration;	
					}
				}
				
				// If the A and D keys are not being pressed.
				if ((!key.IsDown(key.A)) && (!key.IsDown(key.D))) {
					xVelocity = 0;
					if (!jumping) {
						PlayAnimation(idle);
					}
				} else {
					if ((!jumping) && (rightBound.hit == false) && (leftBound.hit == false)) {
						PlayAnimation(walk);
					} else {
						PlayAnimation(idle);
					}
				}
				
				// Prevents A/D move bug.
				if ((key.IsDown(key.A)) && (key.IsDown(key.D))) {
					xVelocity = 0;
				}
			}
		}	
		
		private function UpdatePosition():void 
		{	
			x += xVelocity;
			y -= yVelocity;
		}
		
		private function PlayAnimation(newAnimation:MovieClip):void 
		{
			// Check to see if the new animation is different from the current one.
			if (currentAnimation != newAnimation) {
				// Remove the previous animation from the stage (if it is set to something).
				if (currentAnimation != null) {
					removeChild(currentAnimation);
				}
		
				// Set the current animation to be the new one.
				currentAnimation = newAnimation;
		
				// Add the animation movie clip back to the stage.
				addChild(currentAnimation);
			}
		}
				
		private function CheckIfJumping():void 
		{
			if (jumping) {
				if (y <= yPeak) {
					jumping = false;
					gravityEnabled = true;
				} 
			} else {
				if (!onGround) {
					PlayAnimation(land);
				}
			}
			if (onGround) {
				if (jumpCooldown > 0) {
					jumpCooldown--;
				}
			} else {
				xVelocity *= 0.9;
			}
		}

		private function Jump():void 
		{
			if ((!jumping) && (onGround) && (jumpCooldown == 0)) {
				jumping = true;
				onGround = false;
				gravityEnabled = false;
				yVelocity = JUMP_VELOCITY;
				jumpCooldown = JUMP_COOLDOWN;
				yPeak = y - (BLOCK_HEIGHT * jumpBlocks);
				PlayAnimation(jump);
			}
		}
		
		// Flips the player sprite left.
		private function FlipLeft():void 
		{
			if (facingRight) {
				scaleX = -1;
				x += width;
				facingRight = false;
			}
		}
		
		// Flips the player sprite right.
		private function FlipRight():void 
		{
			if (!facingRight) {
				scaleX = 1;
				x -= width;
				facingRight = true;
			}
		}
		
		public function GetYVelocity():int
		{
			return yVelocity;
		}
	}
}