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
// HIERARCHY:		Code.Engine.CollisionHandler
//
//***********************************************

package Code.Engine {

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import Code.Engine.CollisionEvent;

	public class CollisionHandler extends Sprite {

		//=========================
		// PROPERTIES
		//=========================
		private var stageReference:Stage;


		//=========================
		// CONSTRUCTOR
		//=========================
		public function CollisionHandler(stageReference:Stage) {
			this.stageReference = stageReference;
		}


		//=========================
		// PUBLIC FUNCTIONS
		//=========================
		public function CollisionCheck(main_object:DisplayObject, objects:Array):Boolean {
			
			var collision_count:int = 0;
			
			for (var i:int=0; i<objects.length; i++) {
				if (main_object.hitTestObject(objects[i])) {			
					collision_count++;
				}
			}
			
			if(collision_count==0) {
				return false;
			} else {
				return true;
			}
			
		}
		
		public function BoundCollision(main_object:DisplayObject, objects:Array, custom_event_type:String):void {
			
			for (var i:int=0; i<objects.length; i++) {
				if (main_object.hitTestObject(objects[i])) {			
					main_object.dispatchEvent(new CollisionEvent(objects[i].getBounds(stageReference),custom_event_type));
				}
			}
			
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}