package Code.Engine.Game 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
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
		private const BORDERS_HEIGHT:int = 60;
		/* Parent */
		private var scrollObject:DisplayObject;
		/* Object */
		private var centreX:int = 0;
		private var centreY:int = 0;
		/* Bounds */
		private const BOUND_HEIGHT:int = 250;
		private var topBound:int;
		private var bottomBound:int;
		private const TOP_LIMIT:int = 50;
		private const BOTTOM_LIMIT:int = 600;
		private const SCROLL_VELOCITY:int = 10;

		//--------------------------------------
		//  Constructor
		//--------------------------------------	
		public function Camera(scrollObject:DisplayObject) 
		{
			this.scrollObject = scrollObject;
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
		public function Follow(object:DisplayObject, velocity:int):void
		{			
			PositionBounds(object);
						
			/* The following if blocks determine if (upward/downward) scrolling should occur.
			 * Scrolling will occur if one of the bounds has reached the required height and  
			 * when the parent object has not reached its max/min position.
			 */
			if ((topBound < TOP_LIMIT) && (scrollObject.y < TOP_LIMIT)) 
			{
				scrollObject.y += velocity;
			}
			
			if ((bottomBound > BOTTOM_LIMIT) && ((scrollObject.y + scrollObject.height - BORDERS_HEIGHT) > BOTTOM_LIMIT))
			{
				scrollObject.y += velocity;
			}
		}
		
		public function Focus(object:DisplayObject):void 
		{
			var outOfFocus:Boolean = true;
			while (outOfFocus)
			{
				var scrollUp:Boolean = false;
				var scrollDown:Boolean = false;
				
				PositionBounds(object);
							
				/* The following if blocks determine if (upward/downward) scrolling should occur.
				 * Scrolling will occur if one of the bounds has reached the required height and  
				 * when the parent object has not reached its max/min position.
				 */
				if ((topBound < TOP_LIMIT) && (scrollObject.y < TOP_LIMIT)) 
				{
					scrollObject.y += 1;
					scrollUp = true;
				} 
				else 
				{
					scrollUp = false;
				}
				
				if ((bottomBound > BOTTOM_LIMIT) && ((scrollObject.y + scrollObject.height - BORDERS_HEIGHT) > BOTTOM_LIMIT))
				{
					scrollObject.y -= 1;
					scrollDown = true;
				} 
				else 
				{
					scrollDown = false;
				}
				
				if ((!scrollDown) && (!scrollUp))
					outOfFocus = false;
			}
		}
		
		//--------------------------------------
		//  Private methods
		//--------------------------------------
		private function PositionBounds(object:DisplayObject):void
		{
			// Captures the centre of the object being followed.
			centreX = object.x + (object.width / 2);
			centreY = object.y + (object.height / 2);
			
			// Converts the centre obtained above to global coordinates.
			var objectCentre:Point = object.parent.localToGlobal(new Point(centreX, centreY));
			
			// Updates the top and bottom bounds.
			topBound = objectCentre.y - BOUND_HEIGHT;
			bottomBound = objectCentre.y + BOUND_HEIGHT;
		}
	}
}