package Code.Engine.Utils 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	/**
	 * Static function and variable based class.
	 * There is no need to implement this class due to its static nature.
	 * 
	 * @author Mark W. Thompson
	 */
	public class Utility 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		public static var stage:Stage;
		public static var main:MovieClip;
		/**
		 * Shouldn't use stage.width or stage.height values since 
		 * they are dynamic and off-screen objects alter stage size.
		 */
		public static const STAGE_WIDTH:int = 600;
		public static const STAGE_HEIGHT:int = 600;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Utility() 
		{
		}
				
		//--------------------------------------
		//  Static methods
		//--------------------------------------
		/**
		 * Requires object parameter to have a top left registration point.
		 * 
		 * @param	object The display object to be centred.
		 */
		public static function Centre(object:DisplayObject):void 
		{
			object.x = (STAGE_WIDTH / 2) - (object.width / 2);
		}
	}
}