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
// HIERARCHY:		Code.Main
//
//***********************************************

package Code {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.system.fscommand;
	import Code.Levels.Playground.Playground;

	public class Main extends MovieClip {

		//=========================
		// PROPERTIES
		//=========================
		private var playground:Playground;

		//=========================
		// CONSTRUCTOR
		//=========================
		public function Main() {

			// flash player options
			//fscommand("allowscale","true");
			//fscommand("showmenu","false");
			
			Mouse.hide(); // don't think a mouse is needed for this game, so may as well hide it for now
			
			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);

		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {
			
			// append level
			playground = new Playground(stage,1000);
			stage.addChild(playground);
			
			// event listener
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
		}


		//=========================
		// NON-PUBLIC FUNCTIONS
		//=========================
		

		//=========================
		// PUBLIC FUNCTIONS
		//=========================
		


		//=========================
		// END OF SCRIPT
		//=========================
	}
}