package arclight.split.containers 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import arclight.split.entities.Player;
	import arclight.split.collision.CollisionBound;
	import arclight.split.collision.CollisionDetector;
	import arclight.split.game.Camera;
	import arclight.split.TopLevel;

	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Container for the player and objects.
	 * Handles low-level gameplay logic: collision detection, victory condition.
	 * This class should be a child of the Level class.
	 * 
	 * @see States class
	 * @see Level class
	 * 
	 * @author Mark Thompson
	 */
	public class Dimension extends Sprite 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		public var reachedGoal:Boolean = false;
		private var player:Player = null;
		private var collisionArray:Array = new Array();
		private var collisionDetector:CollisionDetector = new CollisionDetector();
		private var content:Sprite;
		private var goal:Sprite;
		private var camera:Camera;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Dimension(content:Sprite) 
		{
			this.content = content;
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		public function Initialise():void 
		{			
			ConfigureDimensionContent();
			
			camera = new Camera(content);
			camera.Focus(player);
			
			trace("Dimension initialised.");
		}

		//--------------------------------------
		//  Main loop
		//--------------------------------------
		public function Update():void 
		{
			player.Update();
			camera.Follow(player, player.GetYVelocity());
			collisionDetector.Check(player.collisionBounds, collisionArray);
			
			// Game logic.
			player.hitTestObject(goal) ? reachedGoal = true : reachedGoal = false;
		}
		
		//--------------------------------------
		//  Private methods
		//--------------------------------------
		/**
		 *	Cycles through the dimension content to coerce certain objects to the correct type and 
		 *  set relevant properties. 
		 */
		private function ConfigureDimensionContent():void 
		{			
			for (var i:int = 0; i < content.numChildren; i++) {
				var object:Object = content.getChildAt(i);

				if (object is Player) {
					player = object as Player;
					player.removeChildAt(0); // Removes spawn point placeholder image.
					player.mouseChildren = false;
					player.mouseEnabled = false;
				} else if (object is Goal) {
					goal = object as Goal;
				} else if (i == 0) { // BG layer.
					object.cacheAsBitmap = true;
				} else { // Standard collidable object.
					object.cacheAsBitmap = true;
					collisionArray.push(object);
				}
			}
		}
	}
}