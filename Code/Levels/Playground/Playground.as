//*********************************************************
//
// ARCLIGHT GAME STUDIOS
// Ewan McGregor, Graeme Grier, 
// Kemal Thomson, Mark Thompson, 
// Peeter Pärna, Stefan Harrison.
//
// APPLICATION:		Split
// CREATION DATE:	18/02/12
// LAST ACCESSED:	20/02/12
// HIERARCHY:		Code.Levels.Playground.Playground
//
//*********************************************************

package Code.Levels.Playground {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.display.Stage;
	// will be needed once dimension is extended properly
	//import Code.Playground.BlackDimension; 
	//import Code.Playground.WhiteDimension;
	import Code.Classes.Level;
	import Code.Classes.Dimension;
	import Code.Definitions;

	public final class Playground extends Level  {

		//=========================
		// PROPERTIES
		//=========================
		private var whiteDimension:Dimension;
		private var blackDimension:Dimension;

		//=========================
		// CONSTRUCTOR
		//=========================
		public function Playground(stage_reference:Stage,time:Number) {
			
			super(stage_reference,time);
			
			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);
			
		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {
			
			whiteDimension = new Dimension(stageReference,Definitions.WHITE,250,430);
			blackDimension = new Dimension(stageReference,Definitions.BLACK,310,430);
			
			// define level objects
			
			
			// update collision list
			
			
			// level children
			this.addChild(whiteDimension);
			this.addChild(blackDimension);
			
			// set child indexing priorities
			
			
			// event listeners
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
		}


		//=========================
		// MAIN LOOP
		//=========================


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