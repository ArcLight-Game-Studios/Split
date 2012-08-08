package Code.Engine.Game 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Storage class for the various game states.	
	 * 
	 * @see States class
	 * 
	 * @author Mark W. Thompson
	 */
	public class State extends MovieClip 
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
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(e:Event):void 
		{
			main = root as MovieClip;
			trace("State initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		public function Enable():void 
		{
			mouseChildren = true;
			mouseEnabled = true;
			visible = true;
			trace("State enabled");			
		}
		
		public function Disable():void 
		{
			mouseChildren = false;
			mouseEnabled = false;
			visible = false;
			trace("State disabled.");
		}
		
		//--------------------------------------
		//  Event handlers
		//--------------------------------------
		/* Once the level has been loaded key presses are no longer ignored,
		 * it locks focus to the stage so that keyboard interactions are detected and
		 * the main loop is added as an event listener so it updates every frame.
		 * The chapter containing the set of levels is notified that the level has been loaded.
		 */
		protected function OnceLoaded(e:Event):void 
		{
			trace("State loaded.");
		}
	}
}