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
// HIERARCHY:		Code.Engine.CollisionEvent
//
//***********************************************

package Code.Engine {

	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class CollisionEvent extends Event {

		//=========================
		// PROPERTIES
		//=========================
		public var objectBounds:Rectangle;


		//=========================
		// CONSTRUCTOR
		//=========================
		public function CollisionEvent(objectBounds:Rectangle,type:String,bubbles:Boolean=false,cancelable:Boolean=false) {
			super(type,bubbles,cancelable);
			this.objectBounds=objectBounds;
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}