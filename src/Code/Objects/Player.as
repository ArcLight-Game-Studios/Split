package Code.Objects 
{
	import Code.Engine.CollisionDetection.CollisionDetector;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import Code.Engine.CollisionDetection.CollisionBound;
	import Code.Engine.Objects.PhysicsObject;

	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * The Player class, once instantiated, is one that is interactive.
	 * It responds to user input and reacts to the gameplay environment. 
	 * 
	 * @see PhysicsObject class
	 * 
	 * @author Mark W. Thompson
	 */
	public class Player extends PhysicsObject 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		public static const PLAYER_DEATH:String = "playerDeath";
		public var deathTrigger:Boolean = false;
		public var isFacingRight:Boolean = true;
		public var jumping:Boolean = false;
		public var ignoreKeys:Boolean = false;
		//private const MAX_HORIZONTAL_OVERLAP:int = 4;
		//private const MAX_VERTICAL_OVERLAP:int = 2;
		private var spawn:Point;
		
		private var currentAnimation:MovieClip = null;
		private var idle:MovieClip = new PlayerIdle();
		private var walk:MovieClip = new PlayerWalking();
		private var jump:MovieClip = new PlayerJumping();
		private var land:MovieClip = new PlayerLanding();
		private var death:MovieClip;
		
		private var key:Object = { 87: false , 65: false, 68: false }; // order: W, A, D
		
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
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		/**
		 * @private
		 * Initialises the player object:
		 * Sets spawn point; Sets animation; Adds keyboard event listeners; 
		 */
		private function Initialise(e:Event):void 
		{			
			spawn = new Point(x, y);
			PlayAnimation(idle);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
			
			trace("Player initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Main Loop
		//--------------------------------------
		public function Update():void 
		{
			//trace("B "+bottomBound.hit, "T "+topBound.hit, "L "+leftBound.hit, "R "+rightBound.hit);
			CheckForInput(); // Looks for WASD key presses and modifies x/y velocities.
			CheckIfJumping(); // Applies jump.
			ApplyGravity(); // Modifies y velocity.
			UpdatePosition(); // Updates x/y values.

			/*
			 if (deathTrigger == false) 
			{
				CheckForInput();
				CheckIfJumping();
			}
			
			if (currentAnimation == death) 
			{ 
				// If reached end of death animation.
				if (currentAnimation.currentFrame == currentAnimation.totalFrames) 
				{
					FlipRight();
					PlayAnimation(idle);
					x = spawn.x;
					y = spawn.y;
					xVelocity = 0;
					yVelocity = 0;
					deathTrigger = false;
				}
			}*/
		}

		//--------------------------------------
		//  Public methods
		//--------------------------------------
		/* When the player dies:
		 * death animation is played and
		 * x/y velocities are zeroed.
		 */
		
		/**
         * Merges the styles from multiple classes into one object. 
         * If a style is defined in multiple objects, the first occurrence
         * that is found is used. 
         *
         * @param list A comma-delimited list of objects that contain the default styles to be merged.
         *
         * @return A default style object that contains the merged styles.
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
         */
		public function Die():void 
		{
			if(deathTrigger == false) 
			{
				death = new PlayerDeath();
				PlayAnimation(death);
				xVelocity = 0;
				yVelocity = 0;
				deathTrigger = true;
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
		override protected function OnCollision(e:Event):void 
		{
			/*
			if (deathTrigger == false) 
			{
				CalculateBoundOverlaps();
				CheckForMultipleCollisions();
			}*/

			if (deathTrigger == false)
			{
				if (bottomBound.hit)
				{					
					if (!jumping)
					{
						// !!!!!!!!!! NEEDS TO BE CORRECTED !!!!!!!!!! (Improve accuracy of assumption.)
						if ((y < bottomBound.objectBounds.y) && ((y+height)<(bottomBound.objectBounds.y+bottomBound.objectBounds.height)))
						{

							// Positions the player on top of the collision object.
							y = (bottomBound.objectBounds.y - height);
							yVelocity = 0;
							onGround = true;
							jumping = false;
						}
					}
				} 
				
				if (rightBound.hit)
				{
					xVelocity = 0;
					// Positions the player to the right of the collision object.
					if (isFacingRight)
						x = (rightBound.objectBounds.x - width);
					else
						x = ((rightBound.objectBounds.x + rightBound.objectBounds.width) + width);
				} 
				
				if (leftBound.hit)
				{	
					xVelocity = 0;
					// Positions the player to the left of the collision object.
					if (isFacingRight)
						x = (leftBound.objectBounds.x + leftBound.objectBounds.width);
					else
						x = leftBound.objectBounds.x;
				}
				
				if (topBound.hit)
				{
					//if (!onGround)
					//{
						//if (y < (topBound.objectBounds.y + topBound.objectBounds.height))//true value
						if ((y + height) > (topBound.objectBounds.height + topBound.objectBounds.y))
						{
							// Positions the player underneath the collision object.
							y = (topBound.objectBounds.y + topBound.objectBounds.height);
							yVelocity = 0;
							jumping = false;
						}
					//}
				}
			}
		}

		// This override additionally checks the player isn't jumping before enabling gravity.
		override protected function ApplyGravity():void 
		{
			if (onGround)
				gravityEnabled = false;
			
			// In the air.
			if ((!gravityEnabled) && (!jumping) && (bottomBound.hit == false))
			{
				gravityEnabled = true;
				onGround = false;
			}
			
			// Gravity enabled - increase to max y velocity.
			if ((gravityEnabled) && (yVelocity != maxNegativeYVelocity))
				yVelocity--;
		}

		/*
		private function CalculateBoundOverlaps():void 
		{
			bottomBound.overlap = (y + height) - bottomBound.objectBounds.y;
			topBound.overlap = (y - (topBound.objectBounds.y + topBound.objectBounds.height));
			if (isFacingRight)
			{
				leftBound.overlap = (x - (leftBound.objectBounds.x + leftBound.objectBounds.width));
				rightBound.overlap = ((x + width) - (rightBound.objectBounds.x));
			}
			else
			{
				leftBound.overlap = ((rightBound.objectBounds.x + rightBound.objectBounds.width) - (x - width));
				rightBound.overlap = (x - leftBound.objectBounds.x);
			}
		}*/
		
		private function CheckForInput():void 
		{
			if (ignoreKeys == false) 
			{
				// W - JUMP
				if (key[87] == true)
					Jump();
				
				// A - LEFT
				if (key[65] == true) 
				{
					rightBound.hit = false; // Temporary fix for "sticking" to the wall.
					//FlipLeft();
					if (xVelocity > 0) // Prevents A+D "drift" bug.
						xVelocity = 0;	
					if (xVelocity > maxNegativeXVelocity) 
						xVelocity -= xAcceleration;
				}
				
				// D - RIGHT
				if (key[68] == true) 
				{
					leftBound.hit = false; // Temporary fix for "sticking" to the wall.
					//FlipRight();
					if (xVelocity < 0) // Prevents A+D "drift" bug.
						xVelocity = 0;
					if (xVelocity < maxXVelocity) 
						xVelocity += xAcceleration;	
				}
				
				// If the A and D keys are not being pressed.
				if ((key[65] == false) && (key[68] == false)) 
				{
					xVelocity = 0;
					if (!jumping)
						PlayAnimation(idle);
				} 
				else 
				{
					if ((!jumping) && (rightBound.hit == false) && (leftBound.hit == false))
						PlayAnimation(walk);
					else 
						PlayAnimation(idle);
				}
			}
		}		
		
		private function PlayAnimation(newAnimation:MovieClip):void 
		{
			// Check to see if the new animation is different from the current one.
			if (currentAnimation != newAnimation) 
			{
				// Remove the previous animation from the stage (if it is set to something).
				if (currentAnimation != null)
					removeChild(currentAnimation);
		
				// Set the current animation to be the new one.
				currentAnimation = newAnimation;
		
				// Add the animation movie clip back to the stage.
				addChild(currentAnimation);
			}
		}
		
		/* If the top + bottom or left + right collision bounds have been hit simultaneously
		 * and the required overlaps are met, the player is deemed to be sqaushed and death ensues...
		 */
		/*
		private function CheckForMultipleCollisions():void 
		{
			if (topBound.hit && bottomBound.hit) 
			{
				if ((topBound.overlap > MAX_VERTICAL_OVERLAP) || (bottomBound.overlap > MAX_VERTICAL_OVERLAP))
					Die();
			}
			else if (leftBound.hit && rightBound.hit) 
			{
				if ((leftBound.overlap > MAX_HORIZONTAL_OVERLAP) || (rightBound.overlap > MAX_HORIZONTAL_OVERLAP))
					Die();
			}
		}*/
		
		private function CheckIfJumping():void 
		{
			if (jumping) 
			{
				if (y <= yPeak) 
				{
					jumping = false;
					gravityEnabled = true;
				} 
			}
			else
			{
				if (!onGround)
				{
					PlayAnimation(land);
				}
			}
			if (onGround)
			{
				if (jumpCooldown > 0)
				{
					jumpCooldown--;
				}
			}
			else
			{
				xVelocity *= 0.9;
			}
		}

		private function Jump():void 
		{
			if ((!jumping) && (onGround) && (jumpCooldown == 0)) 
			{
				jumping = true;
				onGround = false;
				gravityEnabled = false;
				yVelocity = JUMP_VELOCITY;
				jumpCooldown = JUMP_COOLDOWN;
				yPeak = y - (BLOCK_HEIGHT * jumpBlocks);
				PlayAnimation(jump);
			}
		}
		
		// Flips the players sprite left.
		private function FlipLeft():void 
		{
			if (isFacingRight) 
			{
				scaleX = -1;
				x += width;
				isFacingRight = false;
			}
		}
		
		// Flips the players sprite right.
		private function FlipRight():void 
		{
			if (!isFacingRight) 
			{
				scaleX = 1;
				x -= width;
				isFacingRight = true;
			}
		}

		//--------------------------------------
		//  Event handlers
		//--------------------------------------
		private function OnKeyDown(e:KeyboardEvent):void 
		{
			key[e.keyCode] = true;
		}
		
		private function OnKeyUp(e:KeyboardEvent):void 
		{
			key[e.keyCode] = false;
		}
	}
}
