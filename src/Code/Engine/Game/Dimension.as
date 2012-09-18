package Code.Engine.Game 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Code.Objects.Player;
	import Code.Engine.CollisionDetection.CollisionBound;
	import Code.Engine.CollisionDetection.CollisionDetector;
	import Code.Engine.Game.Camera;

	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Contains player controlled character, objects.
	 * This class should be a child of the Level class.
	 * 
	 * @see States class
	 * @see Level class
	 * 
	 * @author Mark W. Thompson
	 */
	public class Dimension extends MovieClip 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		public static const LIGHT:String = "light";
		public static const DARK:String = "dark";
		private var player:Player;
		private var collisionArray:Array = new Array();
		//private var hazardArray:Array = new Array();
		private var level:MovieClip;
		private var collisionDetector:CollisionDetector = new CollisionDetector();
		public var type:String;
		private var dimensionContent:Dimension;
		public var reachedGoal:Boolean = false;
		private var goal:Goal;
		private var camera:Camera;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Dimension() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(e:Event):void 
		{
			// Reference to level parent class.
			level = parent.parent as MovieClip;
			
			// !!! Can possibly get rid of this by setting it in the level - keep for now (15/09/12).
			if (type == LIGHT)
				dimensionContent = level.lightDimension;
			else if (type == DARK)
				dimensionContent = level.darkDimension;
			
			camera = new Camera(this);
				
			ConfigureDimensionContent();
			
			trace(type + " dimension initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Main loop
		//--------------------------------------
		public function Update():void 
		{
			player.Update();
			camera.Follow(player);
			collisionDetector.Check(player.collisionBounds, collisionArray);
			
			// Game logic.
			if (player.hitTestObject(goal))
			{
				reachedGoal = true;
			}
			else
			{
				reachedGoal = false;
			}
		}
		
		//--------------------------------------
		//  Private methods
		//--------------------------------------
		/* Searches through the levelContent and coerces each object
		 * to the right type and then adds it to either the hazardous
		 * or standard collision array.
		 */
		private function ConfigureDimensionContent():void 
		{			
			for (var i:int = 0; i < dimensionContent.numChildren; i++) 
			{
				var object:Object = dimensionContent.getChildAt(i);
				// BG layer.
				var isLayer:Boolean = Boolean(i == 0); 

				if (isLayer)
				{
					object.cacheAsBitmap = true;
				} 
				else 
				{
					if (object is Player) 
					{
						player = object as Player;
						player.removeChildAt(0); // Removes spawn point placeholder image.
						player.mouseChildren = false;
						player.mouseEnabled = false;
					} 
					else if (object is Goal)
					{
						goal = object as Goal;
					}
					else // Standard object.
					{
						if (object is Sprite) // Dimension border.
						{
							object.visible = false;
						}
						object.cacheAsBitmap = true;
						collisionArray.push(object);
					}
				}
			}
		}
	}
}