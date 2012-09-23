package arclight.split
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	//--------------------------------------
	//  Class description
	//--------------------------------------
	/**
	 * Allows global stage and root access through
	 * TopLevel.stage and TopLevel.root
	 * 
	 * @author Trevor McCauley
	 */
	public class TopLevel extends MovieClip 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		public static var stage:Stage;
		public static var root:DisplayObject;
			
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function TopLevel() 
		{
			if (this.stage) {
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
			TopLevel.stage = this.stage;
			TopLevel.root = this;
		}
	}
}