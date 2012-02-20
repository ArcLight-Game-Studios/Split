//***********************************************
//
// ARCLIGHT GAME STUDIOS
// Ewan McGregor, Graeme Grier, 
// Kemal Thomson, Mark Thompson, 
// Peeter Pärna, Stefan Harrison.
//
// APPLICATION:		Split
// CREATION DATE:	18/02/12
// LAST ACCESSED:	20/02/12
// HIERARCHY:		Code.Classes.Player
//
//***********************************************

package Code.Classes {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import Code.Definitions;
	import Code.Engine.CollisionEvent;
	import Code.Engine.CollisionHandler;

	public class Player extends MovieClip {

		//=========================
		// PROPERTIES
		//=========================
		
		/* Reference */
		private var stageReference:Stage;
		
		/* Controls */
		private const W:int = 87;
		private const A:int = 65;
		private const S:int = 83; // not sure if needed yet, but handy to keep around
		private const D:int = 68;
		private var key:Object = {W:false,A:false,D:false};
		private var keyIsDown:Boolean = false;
		
		/* X-axis Movement */
		public var xVelocity:Number = 0;
		private const MAX_X_VELOCITY:int = 10;
		private const MAX_X_VELOCITY_REVERSE:int = -10;
		private const X_ACCELERATION:int = 2;
		
		/* Y-axis Movement */
		public var yVelocity:Number = 0;
		private const MAX_Y_VELOCITY:int = 15;
		private const MAX_Y_VELOCITY_REVERSE:int = -10; // not sure if needed yet, as the Force class may be easier to use
		private const Y_ACCELERATION:int = 2; // not sure if needed yet
		private var isJumping:Boolean = false;
		private var inAir:Boolean = false;
		private var reachedYPeak:Boolean = false;
		private var yPeak:int;
		private var jumpDecay:int = 0;
		
		/* General Movement */
		private const FRICTION:Number = 0.5;
		private var gravityEnabled = false;
		private var colour:uint;
		
		/* Collision */
		private var dimensionBounds:Rectangle;
		public var topLine:Shape = new Shape();
		public var bottomLine:Shape = new Shape();
		public var leftLine:Shape = new Shape();
		public var rightLine:Shape = new Shape();


		//=========================
		// CONSTRUCTOR
		//=========================
		public function Player(stageReference:Stage, colour:uint, xPosition:int, yPosition:int, dimensionBounds:Rectangle) {
			
			this.stageReference = stageReference;
			this.colour = colour;
			this.x = xPosition;
			this.y = yPosition;
			this.dimensionBounds = dimensionBounds;
			
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
			
			this.addEventListener("tlCl",TopLeftCollision,false,0,true);
			this.addEventListener("trCl",TopRightCollision,false,0,true);
			
			bottomLine.addEventListener(Definitions.COLLISION_EVENT,BottomCollision,false,0,true);
			topLine.addEventListener(Definitions.COLLISION_EVENT,TopCollision,false,0,true);
			leftLine.addEventListener(Definitions.COLLISION_EVENT,LeftCollision,false,0,true);
			rightLine.addEventListener(Definitions.COLLISION_EVENT,RightCollision,false,0,true);
			
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
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
		
		private function TopLeftCollision(e:CollisionEvent):void { //tl
			xVelocity=0;
			x = ((e.objectBounds.x)+(e.objectBounds.width)+1); // +1 important
			//trace("top left");
		}
		
		private function TopRightCollision(e:CollisionEvent):void { //tr
			xVelocity=0;
			x = ((e.objectBounds.x)-(width));
			//trace("top right");
		}

		private function TopCollision(e:CollisionEvent):void {
			yVelocity=0;
			y = ((e.objectBounds.y)+(e.objectBounds.height));
			//trace("top");
		}
		
		private function BottomCollision(e:CollisionEvent):void {
			yVelocity=0;
			y = ((e.objectBounds.y)-(height));
			//trace("bottom");
		}
		
		private function LeftCollision(e:CollisionEvent):void {
			xVelocity=0;
			x = ((e.objectBounds.x)+(e.objectBounds.width));
			//trace("left");
		}
		
		private function RightCollision(e:CollisionEvent):void {
			xVelocity=0;
			x = ((e.objectBounds.x)-(width));
			//trace("right");
		}

		/* makes sure player is kept within a particular dimension
		   if you start messing around with x/y movement
		   this will probably need changed
		   seems doing !() seems to work better and doesn't cause overlapping
		   maybe just revision, instead of optimisation, is needed to make things more clear */
		private function KeepWithinDimension():void {
			
			// local (temporary) variables
			var yy:int = ((dimensionBounds.y)+(dimensionBounds.height));
			var xx:int = ((dimensionBounds.x)+(dimensionBounds.width));
			
			// top bound
			if(!(y>dimensionBounds.y)) {
				if(yVelocity>=0) {
					y=dimensionBounds.y;
					yVelocity=0;
				}
			}
			
			// bottom bound
			if(!((y+height)<yy)) {
				if(yVelocity<=0) {
					y=(yy-height);
					yVelocity=0;
				}
			}
			
			// left bound
			if(!(x>dimensionBounds.x)) {
				if(colour==Definitions.BLACK) {
					if(xVelocity<=0) {
						x=dimensionBounds.x;
						xVelocity=0;
					}
				} else {
					if(xVelocity>=0) {
						x=dimensionBounds.x;
						xVelocity=0;
					}
				}
			}
			
			// right bound
			if(!((x+width)<xx)) {
				if(colour==Definitions.BLACK) {
					if(xVelocity>=0) {
						x=(xx-width);
						xVelocity=0;
					}
				} else {
					if(xVelocity<=0) {
						x=(xx-width);
						xVelocity=0;
					}
				}
			}
			
		}
		
		private function Jump():void {
			isJumping = true;
			inAir = true;
			jumpDecay = 0;
			yPeak = (y-90);
		}
		
		
		//=========================
		// PUBLIC FUNCTIONS
		//=========================
		public function Update():void {

			// if all keys are false, then no key is down
			if((key[W]==false)&&(key[A]==false)&&(key[D]==false)) {
				keyIsDown = false;
			} else {
				keyIsDown = true;
			}
			
			// W - JUMP
			if(key[W]==true) {
				if(isJumping==false) {
					Jump();
				}
			}
			
			// A - LEFT
			if(key[A]==true) {
				if(xVelocity>MAX_X_VELOCITY_REVERSE) {
					xVelocity-=X_ACCELERATION;
				}
			}
			
			// D - RIGHT
			if(key[D]==true) {
				if(xVelocity<MAX_X_VELOCITY) {
					xVelocity+=X_ACCELERATION;
				}
			}
			
			/* in-built gravity simulator
			   not sure if the Force class should be used
			   reason being: each dimension has its own gravity
			   so would be easier and better practice to use the Force class */
			if(gravityEnabled==true) {
				if(yVelocity!=MAX_Y_VELOCITY_REVERSE) {
					yVelocity--;
				}
			}


			/* needs sorted out, however surprisingly useful for finding
			   bugs, keeping it until all the collision/gravity bugs have
			   been sorted */
			if(isJumping==true) {
				
				if((y>yPeak)&&(reachedYPeak==false)) {
					if(yVelocity!=1) {
						yVelocity=(MAX_Y_VELOCITY-jumpDecay);
						jumpDecay++;
					}
				} else {
					reachedYPeak=true;
					isJumping=false;
					inAir=false;
					reachedYPeak=false;
					yVelocity=0;
					gravityEnabled = true;
				}
				
			}

			topLine.graphics.clear();
			topLine.graphics.lineStyle(1,0x000000,1);
			topLine.graphics.moveTo(0,0);
			topLine.graphics.lineTo(40,0);
			
			bottomLine.graphics.clear();
			bottomLine.graphics.lineStyle(1,0x000000,1);
			bottomLine.graphics.moveTo(0,50);
			bottomLine.graphics.lineTo(40,50);
			
			leftLine.graphics.clear();
			leftLine.graphics.lineStyle(1,0x000000,1);
			leftLine.graphics.moveTo(0,0);
			leftLine.graphics.lineTo(0,50);
			
			rightLine.graphics.clear();
			rightLine.graphics.lineStyle(1,0x000000,1);
			rightLine.graphics.moveTo(40,0);
			rightLine.graphics.lineTo(40,50);

			KeepWithinDimension();

			// decrease x velocity if no key is down
			if(keyIsDown==false) {
				
				/* 
				
				// smooth deceleration - however has tendancy to overlap bounds
				if(xVelocity>=1) {
					xVelocity*=FRICTION;
				} else {
					xVelocity=0;
				}
				
				*/
				
				// rapid deceleartion - seems not to cause overlapping
				xVelocity=0;
				
			}

			// update player position depending on dimension
			if(colour==Definitions.BLACK) {
				this.x += xVelocity;
			} else if(colour==Definitions.WHITE) {
				this.x -= xVelocity;
			} else {
				trace("player class was not supplied with valid colour");
			}

			this.y -= yVelocity;

		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}