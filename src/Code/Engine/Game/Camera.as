package Code.Engine.Game 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Mark W. Thompson
	 */
	public class Camera extends EventDispatcher 
	{
		private var centreX:int = 0;
		private var centreY:int = 0;
		private const BOUNDS_HEIGHT:int = 550;
		private const BOUNDS_WIDTH:int = 300;
		private var topBound:int;
		private var bottomBound:int;
		private var scrollObj:DisplayObject;
		private var tempObj:DisplayObject;
		private var scrollingUp:Boolean = true;
		private var scrollingDown:Boolean = true;
		private var scrolling:Boolean = true;
		
		public function Camera(scrollObj:DisplayObject, tempObj:DisplayObject) 
		{
			this.scrollObj = scrollObj;
			this.tempObj = tempObj;
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		private function Initialise(e:Event):void 
		{
			while (scrolling)
			{
				Follow(tempObj);
			}
		}
		
		public function Follow(obj:DisplayObject):void
		{			
			centreX = obj.x + (obj.width / 2);
			centreY = obj.y + (obj.height / 2);
			
			topBound = centreY - (BOUNDS_HEIGHT / 2);
			bottomBound = centreY + (BOUNDS_HEIGHT / 2);
			
			if ((topBound < 50) && (scrollObj.y < 50)) 
			{
				scrollObj.y += 10;
				scrollingUp = true;
			} else {
				scrollingUp = false;
			}
			
			if ((bottomBound > 600) && ((scrollObj.y + scrollObj.height - 70) > 600))
			{
				scrollObj.y -= 10;
				scrollingDown = true;
			} else {
				scrollingDown = false;
			}
			
			if (scrollingDown || scrollingUp)
				scrolling = true;
			else
				scrolling = false;
		}
	}
}