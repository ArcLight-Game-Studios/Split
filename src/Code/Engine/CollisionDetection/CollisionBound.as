package Code.Engine.CollisionDetection 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Acts as the bound of an object which is intended to experience collisions.
	 * Stores relevant collision data which the object will use to handle collisions.
	 * 
	 * @see CollisionDetector class
	 * @see Player class
	 * @see PhysicsObject class
	 * 
	 * @author Mark W. Thompson
	 */
	public class CollisionBound extends Sprite 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/* Bound */
		private var bound:Shape = new Shape();
		private var origin:Point;
		private var target:Point;
		private const THICKNESS:Number = 0.1;
		private const ALPHA:Number = 1;
		private const COLOUR:uint = 0xFF0000;
		/* Collision data */
		public var objectBounds:Rectangle = new Rectangle();
		public var overlap:int = 0;
		public var hit:Boolean = false;

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function CollisionBound(origin:Point, target:Point) 
		{
			// Sets the initial origin and target of the bound.
			this.origin = new Point(origin.x, origin.y);
			this.target = new Point(target.x, target.y);
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(e:Event):void 
		{
			ChangePosition(origin, target);
			addChild(bound);
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		/** Sets the position of the bound relative to the parent object.
		 * 
		 * @param origin The origin point of the bound.
		 * @param target The target point of the bound.
		 */
		public function ChangePosition(origin:Point, target:Point):void 
		{
			bound.graphics.clear();
			bound.graphics.lineStyle(THICKNESS, COLOUR, ALPHA);
			bound.graphics.moveTo(origin.x, origin.y);
			bound.graphics.lineTo(target.x, target.y);
		}
	}
}