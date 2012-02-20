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
// HIERARCHY:		Code.Engine.Force
//
//***********************************************

package Code.Engine {

	import flash.display.Sprite;
	import flash.events.Event;
	import Code.Definitions;
	
	public final class Force extends Sprite {

		//=========================
		// PROPERTIES
		//=========================
		private var _force:int;


		//=========================
		// CONSTRUCTOR
		//=========================
		public function Force(force:int) {
			this._force = force;
			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);
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
		public function LocalEffect(object:Object):void {
			object.yVelocity+=_force;
		}
		
		public function GlobalEffect(objects:Array):void {
			for(var i:int=0; i<objects.length; i++) {
				objects[i].yVelocity+=_force;
			}
		}
		
		public function Set(new_force_value:int,type:String):void {
			if(type==Definitions.GRADUAL) {
				if(_force!=new_force_value) {
					if(_force>new_force_value) {
						_force--;
					} else {
						_force++;
					}
				}
			} else if(type==Definitions.INSTANT) {
				if(_force!=new_force_value) {
					_force = new_force_value;
				}
			}		
		}
		
		public function get force():int {
			return _force;
		}


		//=========================
		// END OF SCRIPT
		//=========================
	}
}