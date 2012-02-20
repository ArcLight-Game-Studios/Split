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
// HIERARCHY:		Code.Classes.Dimension
//
//***********************************************

package Code.Classes {

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import Code.Classes.Platform;
	import Code.Classes.Player;
	import Code.Definitions;
	import Code.Engine.CollisionEvent;
	import Code.Engine.CollisionHandler;
	import Code.Engine.Force;

	public class Dimension extends MovieClip {

		//=========================
		// PROPERTIES
		//=========================
		protected var stageReference:Stage;
		protected var player:Player;
		protected var playerX:int;
		protected var playerY:int;
		protected var colour:uint;
		protected var bg:Platform;
		protected var gravity:Force = new Force(-10);
		/* probably better to replace array with vector for optimisation 
		   however to early to decide what type(s) will be going in
		   (vector only allows a single object type) */
		protected var gravityArray:Array = new Array(); 
		protected var collisionArray:Array = new Array();
		protected var collisionHandler:CollisionHandler;
		private var testPlatform1:Platform;
		private var testPlatform2:Platform;
		

		//=========================
		// CONSTRUCTOR
		//=========================
		public function Dimension(stageReference:Stage,colour:uint,playerX:int,playerY:int) {

			this.stageReference = stageReference;
			this.colour = colour;
			this.playerX = playerX;
			this.playerY = playerY;

			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);

		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {
			
			// simply using a platform for the bg (background - had to shorten name since flash has it reserved)
			
			if(colour==Definitions.WHITE) {
				bg = new Platform(0,50,300,550,colour);
			} else if(colour==Definitions.BLACK) {
				bg = new Platform(300,50,300,550,colour);
			} else {
				trace("Dimension colour parameter incorrect should be Definitions.WHITE or Defintions.BLACK");
			}

			/* need to sort this part out - the dimension class needs to be extended for levels
			   it's unsafe modifying this as a base class, however much easier and quicker to test things
			   future level design: probably use xml as changing source code is never really a good idea
			   Flash has a lot of support for xml so should make things a hell of a lot easier
			   leave this for now though 
			   
			   simply: most of the following will be removed after testing is complete.  */

			this.addChild(bg);
			//bg.visible=false;
			
			testPlatform1 = new Platform(410,400,60,200,Definitions.WHITE);
			testPlatform2 = new Platform(300,580,110,20,Definitions.WHITE);
			collisionHandler = new CollisionHandler(stageReference);
			this.addChild(testPlatform1);
			this.addChild(testPlatform2);
			
			player = new Player(stageReference, colour, playerX, playerY, bg.getBounds(stageReference));
			this.addChild(player);
			
			gravityArray.push(player);
			collisionArray.push(testPlatform1,testPlatform2);
			gravity.GlobalEffect(gravityArray);
			
			this.addEventListener(Event.ENTER_FRAME,Update,false,0,true);
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
		}


		//=========================
		// NON-PUBLIC FUNCTIONS
		//=========================
		protected function Update(e:Event):void {
			
			// ORDER IMPORTANT!
			
			player.Update();
			
			collisionHandler.PointCollision(player,player.x,player.y,collisionArray,"tlCl"); //tl
			collisionHandler.PointCollision(player,player.x+player.width,player.y,collisionArray,"trCl"); //tr
			
			collisionHandler.BoundCollision(player.topLine,collisionArray,Definitions.COLLISION_EVENT);
			collisionHandler.BoundCollision(player.bottomLine,collisionArray,Definitions.COLLISION_EVENT);
			collisionHandler.BoundCollision(player.leftLine,collisionArray,Definitions.COLLISION_EVENT);
			collisionHandler.BoundCollision(player.rightLine,collisionArray,Definitions.COLLISION_EVENT);

		}


		//=========================
		// PUBLIC FUNCTIONS
		//=========================
		


		//=========================
		// END OF SCRIPT
		//=========================
	}
}