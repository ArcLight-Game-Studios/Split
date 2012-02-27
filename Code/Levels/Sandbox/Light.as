//***********************************************
//
// ARCLIGHT GAME STUDIOS
// Ewan McGregor, Graeme Grier, 
// Kemal Thomson, Mark Thompson, 
// Peeter Pärna, Stefan Harrison.
//
// APPLICATION:		Split
// CREATION DATE:	27/02/12
// LAST ACCESSED:	27/02/12
// HIERARCHY:		Code.Level.Sandbox.Light
//
//***********************************************

package Code.Levels.Sandbox {

	import flash.display.Stage;
	import flash.events.Event;
	import Code.Objects.Platform;
	import Code.Engine.Dimension;

	public class Light extends Dimension {

		//=========================
		// PROPERTIES
		//=========================
		private var ground:Platform;
		private var platform1:Platform;
		private var platform2:Platform;
		private var platform3:Platform;
		private var platform4:Platform;


		//=========================
		// CONSTRUCTOR
		//=========================
		public function Light(stageReference:Stage) {

			super(stageReference,Dimension.LIGHT);

			addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);

		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {

			player.x = 250;
			player.y = 530;

			ground = new Platform(0,580,300,20,0x000000);
			platform1 = new Platform(0,560,120,20,0x000000);
			platform2 = new Platform(180,500,120,20,0x000000);
			platform3 = new Platform(240,420,60,20,0x000000);
			platform4 = new Platform(0,390,130,20,0x000000);

			collisionArray.push(ground,platform1,platform2,platform3,platform4);
			
			this.addChild(ground);
			this.addChild(platform1);
			this.addChild(platform2);
			this.addChild(platform3);
			this.addChild(platform4);
			
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}