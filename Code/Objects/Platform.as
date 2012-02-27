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
// HIERARCHY:		Code.Objects.Platform
//
//***********************************************

package Code.Objects {

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Platform extends Sprite {

		//=========================
		// PROPERTIES
		//=========================
		public var platform:Shape = new Shape();
		private var platformX:int;
		private var platformY:int;
		private var platformWidth:int;
		private var platformHeight:int;
		private var platformFill:uint;
		
		
		//=========================
		// CONSTRUCTOR
		//=========================
		public function Platform(platformX:int, platformY:int, platformWidth:int, platformHeight:int, platformFill:uint) {
			
			this.platformX = platformX;
			this.platformY = platformY;
			this.platformWidth = platformWidth;
			this.platformHeight = platformHeight;
			this.platformFill = platformFill;

			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);
			
		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {

			// optimisation
			this.mouseEnabled=false;
			this.mouseChildren=false;
			
			// graphics
			platform.graphics.beginFill(platformFill);
			platform.graphics.drawRect(platformX,platformY,platformWidth,platformHeight);
			platform.graphics.endFill();
			this.addChild(platform);
			
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}