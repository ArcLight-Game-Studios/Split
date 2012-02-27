//*********************************************************
//
// ARCLIGHT GAME STUDIOS
// Ewan McGregor, Graeme Grier, 
// Kemal Thomson, Mark Thompson, 
// Peeter Pärna, Stefan Harrison.
//
// APPLICATION:		Split
// CREATION DATE:	18/02/12
// LAST ACCESSED:	27/02/12
// HIERARCHY:		Code.Levels.Sandbox.Sandbox
//
//*********************************************************

package Code.Levels.Sandbox {

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import Code.Engine.Level;
	import Code.Levels.Sandbox.Light;
	import Code.Levels.Sandbox.Dark;

	public final class Sandbox extends Level  {

		//=========================
		// PROPERTIES
		//=========================
		private var lightDimension:Light;
		private var darkDimension:Dark;


		//=========================
		// CONSTRUCTOR
		//=========================
		public function Sandbox(stageReference:Stage) {
			
			super(stageReference);
			
			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);
			
		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {
			
			lightDimension = new Light(stageReference);
			darkDimension = new Dark(stageReference);

			this.addChild(lightDimension);
			this.addChild(darkDimension);

			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}