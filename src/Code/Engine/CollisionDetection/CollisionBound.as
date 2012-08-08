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
	 * The CollisionBound class is used to store collision data.
	 * This data will be parsed by some form of collision handler.
	 * 
	 * @see CollisionDetector class
	 * @see Player class
	 * 
	 * @author Mark W. Thompson
	 */
	public class CollisionBound extends Sprite 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * How far the bound has past the collision object.
		 */
		public var overlap:int = 0;
		
		/**
		 * Determines if the bound has been hit.
		 */
		public var hit:Boolean = false;

		/**
		 * Stores the dimensions of the object which the bound has hit.
		 */
		public var objectBounds:Rectangle = new Rectangle();
		
		/**
		 * @private
		 * The visual component of the bound.
		 */
		private var bound:Shape = new Shape();
		
		/**
		 * @private
		 * The bounds point of origin.
		 */
		private var origin:Point;
		
		/**
		 * @private
		 * The bounds target point.
		 */
		private var target:Point;

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function CollisionBound(origin:Point, target:Point) 
		{
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
		/* Sets the origin and target coordinates of the collision bound.
		 * Coordinates should be relative to the parent object  
		 * since a collision bound is added as child.
		 */
		public function ChangePosition(origin:Point, target:Point):void 
		{
			bound.graphics.clear();
			bound.graphics.lineStyle(1, 0xFF0000, 0);
			bound.graphics.moveTo(origin.x, origin.y);
			bound.graphics.lineTo(target.x, target.y);
		}
	}
}
