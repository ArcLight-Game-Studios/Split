package arclight.split.containers 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import arclight.split.TopLevel;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Container for state classes.
	 * 
	 * @see MainMenu class
	 * @see Credits class
	 * @see Game class
	 * 
	 * @author Mark Thompson
	 */
	public class State extends Sprite
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		protected var main:MovieClip;

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function State() 
		{
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
			main = root as MovieClip;
			trace("State initialised.");
		}
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		public function SwitchMode():void
		{
			mouseChildren = !mouseChildren;
			mouseEnabled = !mouseEnabled;
			visible = !visible;
		}
	}
}