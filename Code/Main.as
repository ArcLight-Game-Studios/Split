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
// HIERARCHY:		Code.Main
//
//***********************************************

package Code {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.system.fscommand;
	import Code.Levels.Sandbox.Sandbox;

	public class Main extends MovieClip {

		//=========================
		// PROPERTIES
		//=========================
		private var sandbox:Sandbox;

		//=========================
		// CONSTRUCTOR
		//=========================
		public function Main() {

			// flash player options
			//fscommand("allowscale","true");
			//fscommand("showmenu","false");
			
			Mouse.hide();
			
			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);

		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {
			
			// append level
			sandbox = new Sandbox(stage);
			stage.addChild(sandbox);
			
			// event listener
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}