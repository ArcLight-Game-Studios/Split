package arclight.split.game 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import arclight.split.TopLevel;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Follows a nested object by controlling the parents position.
	 * 
	 * @author Mark Thompson
	 */
	public class Camera
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/* Parent */
		private var scrollObject:DisplayObject;
		/* Object */
		private var centreX:int = 0;
		private var centreY:int = 0;
		/* Bounds */
		private const BOUND_HEIGHT:int = 250;
		private var topBound:int;
		private var bottomBound:int;
		private const SCROLL_VELOCITY:int = 10;
		private var scrolling:Boolean = false;

		//--------------------------------------
		//  Constructor
		//--------------------------------------	
		public function Camera(scrollObject:DisplayObject) 
		{
			this.scrollObject = scrollObject;		
		}
				
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		public function Follow(object:DisplayObject, velocity:int):void
		{	
			scrolling = false;
			if (velocity < 0) {
				velocity = -velocity;
			}
			
			// Captures the centre of the object being followed.
			centreX = object.x + (object.width / 2);
			centreY = object.y + (object.height / 2);
			
			// Converts the centre obtained above to global coordinates.
			var objectCentre:Point = object.parent.localToGlobal(new Point(centreX, centreY));
			
			// Updates the top and bottom bounds.
			topBound = objectCentre.y - BOUND_HEIGHT;
			bottomBound = objectCentre.y + BOUND_HEIGHT;
						
			/* The following if blocks determine if (upward/downward) scrolling should occur.
			 * Scrolling will occur if one of the bounds has reached the required height and  
			 * when the parent object has not reached its max/min position.
			 */
			if ((topBound < TopLevel.stage.x) && (scrollObject.y < TopLevel.stage.x)) {
				scrollObject.y += velocity;
				scrolling = true;
			}
			
			if ((bottomBound > TopLevel.stage.stageHeight) && ((scrollObject.y + scrollObject.height) > TopLevel.stage.stageHeight)) {
				scrollObject.y -= velocity;
				scrolling = true;
			}
			
			// Prevents the scroll object from scrolling down more than it should.
			if ((scrollObject.y + scrollObject.height) < TopLevel.stage.stageHeight) {
				var offset:int = TopLevel.stage.stageHeight - (scrollObject.y + scrollObject.height)
				scrollObject.y += offset;
			}
		}
		
		public function Focus(object:DisplayObject):void 
		{
			scrolling = true;
			while (scrolling) {
				Follow(object, 1)
			}
		}
	}
}