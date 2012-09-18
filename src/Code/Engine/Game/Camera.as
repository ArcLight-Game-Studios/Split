package Code.Engine.Game 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Follows a nested object by controlling the parents position.
	 * 
	 * @author Mark W. Thompson
	 */
	public class Camera extends EventDispatcher 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/* Dimension */
		private const BOUNDS_HEIGHT:int = 550;
		private const BOUNDS_WIDTH:int = 300;
		/* Parent */
		private var scrollObj:DisplayObject;
		/* Object */
		private var centreX:int = 0;
		private var centreY:int = 0;
		/* Bounds */
		private var topBound:int;
		private var bottomBound:int;
		private const TOP_LIMIT:int = 50;
		private const BOTTOM_LIMIT:int = 600;
		private const SCROLL_VELOCITY:int = 10;

		//--------------------------------------
		//  Constructor
		//--------------------------------------	
		public function Camera(scrollObj:DisplayObject) 
		{
			this.scrollObj = scrollObj;
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(e:Event):void 
		{
		}
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		public function Follow(obj:DisplayObject):void
		{			
			// Captures the centre of the object being followed.
			centreX = obj.x + (obj.width / 2);
			centreY = obj.y + (obj.height / 2);
			
			// Updates the top and bottom bounds.
			topBound = centreY - (BOUNDS_HEIGHT / 2);
			bottomBound = centreY + (BOUNDS_HEIGHT / 2);
			
			/* The following if blocks determine if (upward/downward) scrolling should occur.
			 * Scrolling will occur if one of the bounds has reached the required height and  
			 * when the parent object has not reached its max/min position.
			 */
			if ((topBound < TOP_LIMIT) && (scrollObj.y < TOP_LIMIT)) 
			{
				scrollObj.y += SCROLL_VELOCITY;
			}
			
			if ((bottomBound > BOTTOM_LIMIT) && ((scrollObj.y + scrollObj.height - 70) > BOTTOM_LIMIT))
			{
				scrollObj.y -= SCROLL_VELOCITY;
			}
		}
	}
}