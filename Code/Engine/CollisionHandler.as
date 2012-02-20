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
// HIERARCHY:		Code.Engine.CollisionHandler
//
//***********************************************

package Code.Engine {

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Code.Definitions;
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
			this.addEventListener(Event.ADDED_TO_STAGE,Initialise);
		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
		}


		//=========================
		// PUBLIC FUNCTIONS
		//=========================
		public function BoundCollision(main_object:DisplayObject,objects:Array,custom_event_type:String):void {
			for (var i:int=0; i<objects.length; i++) {
				if (main_object.hitTestObject(objects[i])) {			
					main_object.dispatchEvent(new CollisionEvent(objects[i].getBounds(stageReference),custom_event_type));
				}
			}
		}
		
		public function PointCollision(main_object:DisplayObject,main_object_x:Number,main_object_y:Number,objects:Array,custom_event_type:String):void {
			for(var i:int=0; i<objects.length; i++) {
				if(objects[i].hitTestPoint(main_object_x,main_object_y)) {
					main_object.dispatchEvent(new CollisionEvent(objects[i].getBounds(stageReference),custom_event_type));
				}
			}
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}