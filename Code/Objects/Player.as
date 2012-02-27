//***********************************************
//
// ARCLIGHT GAME STUDIOS
// Ewan McGregor, Graeme Grier, 
// Kemal Thomson, Mark Thompson, 
// Peeter Pärna, Stefan Harrison.
//
// APPLICATION:		Split
// CREATION DATE:	18/02/12
// LAST ACCESSED:	27/02/12
// HIERARCHY:		Code.Objects.Player
//
//***********************************************

package Code.Objects {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Code.Engine.CollisionEvent;
	import Code.Engine.Dimension;

	public class Player extends MovieClip {

		//=========================
		// PROPERTIES
		//=========================
		
		/* Reference */
		private var stageReference:Stage;
		
		/* Controls */
		private var key:Object = {87:false,65:false,68:false}; // order: W, A, D
		
		/* X-axis Movement */
		public var xVelocity:Number = 0;
		private const MAX_X_VELOCITY:int = 10;
		private const MAX_NEGATIVE_X_VELOCITY:int = -10;
		private const X_ACCELERATION:int = 2;
		
		/* Y-axis Movement */
		public var yVelocity:Number = 0;
		private const MAX_Y_VELOCITY:int = 15;
		private var maxNegativeYVelocity:int = -10; // is not a constant because gravity can be changed in a dimension
		private var isJumping:Boolean = false;
		private var yPeak:int;
		private var jumpDecay:int = 0;
		private var onGround:Boolean = false;
		
		/* General Movement */
		private const FRICTION:Number = 0.5;
		private var gravityEnabled = true;
		
		/* Collision */
		public var topLine:Shape = new Shape();
		public var bottomLine:Shape = new Shape();
		public var leftLine:Shape = new Shape();
		public var rightLine:Shape = new Shape();
		private var dimension:Dimension;


		//=========================
		// CONSTRUCTOR
		//=========================
		public function Player(stageReference:Stage, dimension:Dimension) {
			
			this.stageReference = stageReference;
			this.dimension = dimension;
			
			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);

		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {

			this.addChild(topLine);
			this.addChild(bottomLine);
			this.addChild(leftLine);
			this.addChild(rightLine);
			
			stageReference.addEventListener(KeyboardEvent.KEY_DOWN,KeyDown,false,0,true);
			stageReference.addEventListener(KeyboardEvent.KEY_UP,KeyUp,false,0,true);

			bottomLine.addEventListener(CollisionEvent.COLLISION_DETECTED,BottomCollision,false,0,true);
			topLine.addEventListener(CollisionEvent.COLLISION_DETECTED,TopCollision,false,0,true);
			leftLine.addEventListener(CollisionEvent.COLLISION_DETECTED,LeftCollision,false,0,true);
			rightLine.addEventListener(CollisionEvent.COLLISION_DETECTED,RightCollision,false,0,true);
			
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);

		}


		//=========================
		// MAIN LOOP
		//=========================
		public function Update():void {

			// W - JUMP
			if(key[87]==true) {
				if((isJumping==false)&&(onGround==true)) {
					Jump();
				}
			}
			
			// A - LEFT
			if(key[65]==true) {
				if(xVelocity>MAX_NEGATIVE_X_VELOCITY) {
					xVelocity-=X_ACCELERATION;
				}
			}
			
			// D - RIGHT
			if(key[68]==true) {
				if(xVelocity<MAX_X_VELOCITY) {
					xVelocity+=X_ACCELERATION;
				}
			}

			/* KEY CHECK
			 * if no key is down, xVelocity will become 0
			 */
			if((key[87]==false)&&(key[68]==false)&&(key[65]==false)) {
				xVelocity=0;
			}
   			
			/* JUMPING
			 * this will check if the player has reached the jump peak
			 * if this is not true, the yVelocity will decay until it equals 1
			 * otherwise, yVelocity will be set to 0 and 
			 * the player will no longer be jumping - triggers InAir() (private function).
			 */
			if(isJumping) {
				if(y>yPeak) {
					if(yVelocity!=1) {
						yVelocity=(MAX_Y_VELOCITY-jumpDecay);
						jumpDecay++;
					}
				} else {
					yVelocity=0;
					isJumping=false;
				}
			} else {
				InAir();
			}
			
			

			DrawCollisionBounds(); // check in the NON-PUBLIC FUNCTIONS section for more information

			KeepWithinDimension(); // check in the NON-PUBLIC FUNCTIONS section for more information

			/* GRAVITY
			 * player subjected to force of gravity when enabled
			 * if the player yVelocity will continue to decrease until
			 * it has reached maxNegativeYVelocity.
			 */
			if((gravityEnabled==true)&&(yVelocity!=maxNegativeYVelocity)) {
				yVelocity--;
			}

			/* POSITION
			 * depending on colour of player, xVelocity will be either added or subtracted to
			 * give inverted movement.
			 * yVelocity is independant of dimension so will always be subtracted.
			 */
			if(dimension.type==Dimension.DARK) {
				this.x += xVelocity;
			} else if(dimension.type==Dimension.LIGHT) {
				this.x -= xVelocity;
			} else {
				// useful for debugging
				trace("player class was not supplied with valid colour");
			}
			
			this.y -= yVelocity;
			
		}


		//=========================
		// NON-PUBLIC FUNCTIONS
		//=========================
		private function KeyDown(e:KeyboardEvent):void {
			key[e.keyCode]=true;
		}
		
		private function KeyUp(e:KeyboardEvent):void {
			key[e.keyCode]=false;
		}
		
		private function InAir():void {
			if(gravityEnabled==false) {
				gravityEnabled=true;
			}
		}
		
		private function Jump():void {
			isJumping = true;
			onGround = false;
			gravityEnabled=false;
			jumpDecay = 0;
			yPeak = (y-90); // 90px above the initial jump position
		}
		
		/* ALL COLLISION FUNCTIONS
		 * bear in mind that all registration points are located in 
		 * the top left corner just in case you are trying to 
		 * translate the code (which the comments already do).
		 * also note that +1 to a value is to compensate for
		 * a collision bound (which is 1 pixel in thickness, obviously).
		 */

		private function TopCollision(e:CollisionEvent):void {
			// player positioned to base y of the collision object
			y = ((e.objectBounds.y)+(e.objectBounds.height));
			isJumping=false;
			yVelocity=0;
		}
		
		private function BottomCollision(e:CollisionEvent):void {
			// player positioned on top of the collision object
			y = ((e.objectBounds.y)-(height));
			yVelocity=0;
			isJumping=false;
			onGround=true;
		}
		
		private function LeftCollision(e:CollisionEvent):void {
			// player positioned to the left of the collision object
			x = ((e.objectBounds.x)+(e.objectBounds.width));
			xVelocity=0;
		}
		
		private function RightCollision(e:CollisionEvent):void {
			// player positioned to the right of the collision object
			x = ((e.objectBounds.x)-(width));
			xVelocity=0;
		}

		/* KeepWithinBounds
		 * prevents player moving outwith the bounds of a dimension.
		 * if you start modifying the player x/y movement, this will 
		 * most likely need changed.
		 * this may look rather messy, however, it seems to be the 
		 * most efficient way of containment.
		 * if you can clean it up, do so!
		 */
		private function KeepWithinDimension():void {
			
			// local (temporary) variables
			var dimensionBaseY:int = ((dimension.bounds.y)+(dimension.bounds.height));
			var dimensionXWidth:int = ((dimension.bounds.x)+(dimension.bounds.width));
			
			/* Top Dimension Bound */
			// if player is passed the top bound
			if(!(y>dimension.bounds.y)) {
				// and y velocity is positive (travelling upwards)
				if(yVelocity>=0) {
					// position player underneath top bound
					y=dimension.bounds.y;
					yVelocity=0;
				}
			}
			
			/* Bottom Dimension Bound */
			// if player is passed the bottom bound
			if(!((y+height)<dimensionBaseY)) {
				// and velocity is negative (travelling downwards)
				if(yVelocity<=0) {
					// position player above bottom bound
					y=(dimensionBaseY-height);
					yVelocity=0;
					isJumping=false;
					onGround=true;
				}
			}

			/* Left Dimension Bound */
			// if player is passed the left bound
			if(!(x>dimension.bounds.x)) {
				// for the white dimension 
				// (remember player is black in white and vice versa)
				if(dimension.type==Dimension.DARK) {
					// if velocity is negative (moving left for black player)
					if(xVelocity<=0) {
						// position player to the right of the left bound
						x=dimension.bounds.x;
						xVelocity=0;
					}
				} else {
					// if velocity is positive (moving left for white player)
					if(xVelocity>=0) {
						// position player to the right of the left bound
						x=dimension.bounds.x;
						xVelocity=0;
					}
				}
			}
			
			/* Right Dimension Bound */
			// if player is passed the right bound
			if(!((x+width)<dimensionXWidth)) {
				// for the white dimension 
				// (remember player is black in white and vice versa)
				if(dimension.type==Dimension.DARK) {
					// if velocity is negative (moving left for black player)
					if(xVelocity>=0) {
						// position player to the right of the left bound
						x=(dimensionXWidth-width);
						xVelocity=0;
					}
				} else {
					// if velocity is positive (moving left for white player)
					if(xVelocity<=0) {
						// position player to the right of the left bound
						x=(dimensionXWidth-width);
						xVelocity=0;
					}
				}
			}
			
		}
		
		/* DrawCollisionBounds
		 * essentially maps out invisible player bounds for 
		 * collision detection.
		 * all corners are left unmapped because it causes problems.
		 */
		private function DrawCollisionBounds():void {
			
			/* Process */
			// 1st - clear previous line
			// 2nd - set line properties
			// 3rd - set line origin
			// 4th - set line destination
			
			topLine.graphics.clear();
			topLine.graphics.lineStyle(1,0x000000,0);
			topLine.graphics.moveTo(5,0);
			topLine.graphics.lineTo(35,0);
			
			bottomLine.graphics.clear();
			bottomLine.graphics.lineStyle(1,0x000000,0);
			bottomLine.graphics.moveTo(5,50);
			bottomLine.graphics.lineTo(35,50);
			
			leftLine.graphics.clear();
			leftLine.graphics.lineStyle(1,0x000000,0);
			leftLine.graphics.moveTo(0,5);
			leftLine.graphics.lineTo(0,45);
			
			rightLine.graphics.clear();
			rightLine.graphics.lineStyle(1,0x000000,0);
			rightLine.graphics.moveTo(40,5);
			rightLine.graphics.lineTo(40,45);
			
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}