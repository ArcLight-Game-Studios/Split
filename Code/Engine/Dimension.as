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
// HIERARCHY:		Code.Engine.Dimension
//
//***********************************************

package Code.Engine {

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Code.Objects.Platform;
	import Code.Objects.Player;
	import Code.Engine.CollisionEvent;
	import Code.Engine.CollisionHandler;

	public class Dimension extends MovieClip {

		//=========================
		// PROPERTIES
		//=========================
		protected var stageReference:Stage;
		protected var player:Player;
		protected var bg:Platform;
		protected var collisionArray:Array = new Array();
		protected var collisionHandler:CollisionHandler;
		// probably going to make the public vars/consts private instead using 
		// public getters/setters to change their values (better methodology)
		public var type:String;
		public static const LIGHT:String = "light";
		public static const DARK:String = "dark";
		public var bounds:Rectangle;
		

		//=========================
		// CONSTRUCTOR
		//=========================
		public function Dimension(stageReference:Stage,type:String) {

			this.stageReference = stageReference;
			this.type = type;

			addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);

		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {
			
			// simply using a platform for the bg (background - had to shorten name since flash has it reserved)
			
			if(type==LIGHT) {
				bg = new Platform(0,50,300,550,0xFFFFFF);
			} else if(type==DARK) {
				bg = new Platform(300,50,300,550,0x000000);
			} else {
				trace("Dimension colour parameter incorrect should be Dimension.LIGHT or Dimension.DARK");
			}

			this.addChild(bg);
			this.bounds = bg.getBounds(stageReference);
			
			player = new Player(stageReference, this);
			collisionHandler = new CollisionHandler(stageReference);
			
			this.addChild(player);
			
			this.addEventListener(Event.ENTER_FRAME,Update,false,0,true);
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
		}


		//=========================
		// NON-PUBLIC FUNCTIONS
		//=========================
		protected function Update(e:Event):void {
			
			// ORDER IMPORTANT!
			
			player.Update();
			
			if(collisionHandler.CollisionCheck(player,collisionArray)==true) {
				
				collisionHandler.BoundCollision(player.topLine,collisionArray,CollisionEvent.COLLISION_DETECTED);
				collisionHandler.BoundCollision(player.bottomLine,collisionArray,CollisionEvent.COLLISION_DETECTED);
				collisionHandler.BoundCollision(player.leftLine,collisionArray,CollisionEvent.COLLISION_DETECTED);
				collisionHandler.BoundCollision(player.rightLine,collisionArray,CollisionEvent.COLLISION_DETECTED);
			
			}
			
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}