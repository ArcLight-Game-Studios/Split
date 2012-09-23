package arclight.split.collision 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import arclight.split.collision.CollisionBound;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * A utility class which is used to determine if a set of 
	 * collision bounds are colliding with an array of objects.
	 * 
	 * @see CollisionBound class
	 * 
	 * @author Mark Thompson
	 */
	public class CollisionDetector extends EventDispatcher
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		public static const COLLISION_DETECTED:String = "collisionDetected";
		private var collisionDetected:Boolean = false;
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------	
		/**
		 * Cycles through an array of collision bounds and determines if there are any collisions between
		 * one of the collision bounds and one of the objects in the objects array. 
		 * If there is an event will be dispatched to the parent class of the collision bounds. 
		 * 
		 * @param	collisionBounds An array of CollisionBounds (this should be converted to Vector type).
		 * @param	objects An array of various object types.
		 */
		public function Check(collisionBounds:Array, objects:Array):void 
		{	
			// Cycles through the set of collision bounds.
			for (var j:int = 0; j < collisionBounds.length; j++) {
				var collisionBound:CollisionBound = collisionBounds[j];
				collisionDetected = false; 
				// Cycles through the array of objects.
				for (var i:int = 0; i < objects.length; i++) {
					// Checks if the current collision bound is colliding with the current object.
					if (collisionBound.hitTestObject(objects[i])) {
						// References the player and dimension.
						var player:DisplayObject = collisionBound.parent;
						var dimension:DisplayObject = collisionBound.parent.parent;
						
						// Sets collision bound data which will be used in the handling function of the Player class.
						collisionBound.hit = true;
						collisionBound.objectBounds = objects[i].getBounds(dimension);
						
						// Triggers collision handler in Player class.
						player.dispatchEvent(new Event(COLLISION_DETECTED));
						
						collisionDetected = true;
						break;
					}
				}
				
				if (!collisionDetected) {
					collisionBound.hit = false;
				}
			}
		}
	}
}