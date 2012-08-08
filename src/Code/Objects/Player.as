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
		public var isJumping:Boolean = false;
		public var ignoreKeys:Boolean = false;
		//private const MAX_HORIZONTAL_OVERLAP:int = 4;
		//private const MAX_VERTICAL_OVERLAP:int = 2;
		
		/**
		 * @private 
		 * */
		private var spawn:Point;
		
		/**
		 * @private 
		 * */
		private var currentAnimation:MovieClip = null;
		
		/**
		 * @private 
		 * */
		private var idle:MovieClip = new PlayerIdle();
		
		//private var walking:MovieClip = new PlayerWalking();
		//private var jumping:MovieClip = new PlayerJumping();
		//private var landing:MovieClip = new PlayerLanding();
		//private var death:MovieClip;
		
		private var yPeak:int;
		private var jumpDecay:int = 0;
		private var jumpCooldown:int = 0;
		private var key:Object = { 87: false , 65: false, 68: false }; // order: W, A, D
		
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

			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			
			trace("Player initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Main Loop
		//--------------------------------------
		public function Update():void 
		{
			CheckForInput(); // Looks for WASD.
			CheckIfJumping(); // Applies jump.
			ApplyGravity(); // Affects x/y velocities.
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

		//=========================
		// PUBLIC METHODS
		//=========================
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
				//death = new PlayerDeath();
				//PlayAnimation(death);
				xVelocity = 0;
				yVelocity = 0;
				deathTrigger = true;
			}
		}
		
		//=========================
		// PRIVATE METHODS 
		//=========================
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
					if (!isJumping)
					{
						if (y < bottomBound.objectBounds.y)
						{

							// Positions the player on top of the collision object.
							y = (bottomBound.objectBounds.y - height);
							yVelocity = 0;
							onGround = true;
							isJumping = false;
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
					//trace("top hit");
					if (isJumping)
					{
						//if (y < (topBound.objectBounds.y + topBound.objectBounds.height))//true value
						if ((y + height) > (topBound.objectBounds.height + topBound.objectBounds.y))
						{
							// Positions the player underneath the collision object.
							y = (topBound.objectBounds.y + topBound.objectBounds.height);
							yVelocity = 0;
							isJumping = false;
						}
					}
				}
			}
		}

		// This override additionally checks the player isn't jumping before enabling gravity.
		override protected function ApplyGravity():void 
		{
			if (onGround)
				gravityEnabled = false;
			
			if ((!gravityEnabled) && (!isJumping) && (bottomBound.hit == false))
			{
				gravityEnabled = true;
				onGround = false;
			}
			
			if ((gravityEnabled) && (yVelocity != maxNegativeYVelocity))
				yVelocity--;
		}

		//=========================
		// PRIVATE METHODS
		//=========================
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
		}
		
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
					//FlipLeft();
					if (xVelocity > 0) // Prevents A+D "drift" glitch.
						xVelocity = 0;
					if (xVelocity > maxNegativeXVelocity) 
						xVelocity -= xAcceleration;
				}
				
				// D - RIGHT
				if (key[68] == true) 
				{
					//FlipRight();
					if (xVelocity < 0) // Prevents A+D "drift" glitch.
						xVelocity = 0;
					if (xVelocity < maxXVelocity) 
						xVelocity += xAcceleration;	
				}
				
				// If the A and D keys are not being pressed.
				
				if ((key[65] == false) && (key[68] == false)) 
				{
					// Resets x velocity.
					xVelocity = 0;
					// Plays idle animation if not jumping.
					if (isJumping == false)
						PlayAnimation(idle);
				} 
				else 
				{
					PlayAnimation(idle);
					/* Plays walking animation if not jumping and x-axis collision bunds are not hit.
					 * Otherwise, the idle animation will be played.
					 */
					/*
					if ((isJumping == false) && (rightBound.hit == false) && (leftBound.hit == false))
						PlayAnimation(walking);
					else 
						PlayAnimation(idle);*/
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
			if (isJumping) 
			{
				// If player hasn't reached the peak of the jump.
				if (y > yPeak) 
				{
					yVelocity = 10 - jumpDecay;
					jumpDecay++;
					/* Reduce the y velocity until is equals 1.
					 * This allows for a smooth jump arc.
					 */
					/*
					if (yVelocity != 1) 
					{
						yVelocity = (maxYVelocity - jumpDecay);
						jumpDecay++;
					}*/
				} 
				else 
				{
					// Player is not considered jumping once the peak has been reached.
					yVelocity = 0;
					isJumping = false;
					gravityEnabled = true;
				}
			}
			
			// Reduces x velocity if player is not on the ground.
			if (onGround == false) 
			{
				// Player will be falling so landing animation is played.
				//if (isJumping == false) 
					//PlayAnimation(landing);

				xVelocity *= 0.8;
			}
			else
			{
				if (jumpCooldown > 0)
					jumpCooldown--;					
			}
		}

		private function Jump():void 
		{
			if ((!isJumping) && (onGround) && (jumpCooldown == 0)) 
			{
				isJumping = true;
				onGround = false;
				gravityEnabled = false;
				jumpDecay = 0;
				jumpCooldown = 5;
				yPeak = (y-height);
				//PlayAnimation(jumping);
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

		//=========================
		// EVENT HANDLERS
		//=========================
		private function KeyDown(e:KeyboardEvent):void 
		{
			key[e.keyCode] = true;
		}
		
		private function KeyUp(e:KeyboardEvent):void 
		{
			key[e.keyCode] = false;
		}

		//=========================
		// END OF SCRIPT
		//=========================
	}
}
