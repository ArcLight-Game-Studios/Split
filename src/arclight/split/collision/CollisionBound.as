package arclight.split.collision 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import arclight.split.TopLevel;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Acts as the bound of an object which is intended to experience collisions.
	 * Stores relevant collision data which the object will use to handle collisions.
	 * 
	 * @see CollisionDetector class
	 * @see Player class
	 * 
	 * @author Mark Thompson
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
		private const BOUND_THICKNESS:Number = 0.1;
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
			if (TopLevel.stage) {
				Initialise();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, Initialise);
			}
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(event:Event = null):void 
		{
			if (event) {
				removeEventListener(Event.ADDED_TO_STAGE, Initialise);
			}
			ChangePosition(origin, target);
			addChild(bound);
		}
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		/** 
		 * Sets the position of the bound relative to the parent object.
		 * 
		 * @param origin The origin point of the bound.
		 * @param target The target point of the bound.
		 */
		public function ChangePosition(origin:Point, target:Point):void 
		{
			bound.graphics.clear();
			bound.graphics.lineStyle(BOUND_THICKNESS, 0xFF0000, 0);
			bound.graphics.moveTo(origin.x, origin.y);
			bound.graphics.lineTo(target.x, target.y);
		}
	}
}