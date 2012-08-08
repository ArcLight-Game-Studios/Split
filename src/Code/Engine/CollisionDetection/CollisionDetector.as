package Code.Engine.CollisionDetection 
{
	import Code.Engine.Game.Level;
	import Code.Objects.Player;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import Code.Engine.CollisionDetection.CollisionBound;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * The CollisionDetector class is essentially a utility class which
	 * is used to determine if a set of collision bounds are colliding with a given set of objects.
	 * 
	 * @see CollisionBound class
	 * 
	 * @author Mark W. Thompson
	 */
	public class CollisionDetector extends EventDispatcher
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * Used for event listeners.
		 */
		public static const COLLISION_DETECTED:String = "collisionDetected";
		
		/**
		 * @private (temporary)
		 * Stores the number of collisions detected.
		 */
		private var count:int = 0;
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------		
		 /**
		 * Cycles through an array of collision bounds and determines if there are any collisions between
		 * one of the collision bounds and one of the objects in the objects array. 
		 * If there is an event will be dispatched to the parent class of the collision bounds.
		 * 
		 * @param collisionBounds An array of CollisionBounds (this should be converted to Vector type).
		 * @param objects An array of various object types.
		 */
		public function Check(collisionBounds:Array, objects:Array):void 
		{	
			for (var j:int = 0; j < collisionBounds.length; j++)
			{
				var collisionBound:CollisionBound = collisionBounds[j];
				count = 0; // Resets on each cycle.

				for (var i:int = 0; i < objects.length; i++) 
				{
					if (collisionBound.hitTestObject(objects[i])) 
					{
						var parentObject:DisplayObject = collisionBound.parent;
						var dimension:DisplayObject = collisionBound.parent.parent;
						collisionBound.hit = true;
						collisionBound.objectBounds = objects[i].getBounds(dimension);
						count++;
						parentObject.dispatchEvent(new Event(COLLISION_DETECTED));
						break;
					}
				}
				
				if (count == 0)
					collisionBound.hit = false;
			}
		}
	}
}
