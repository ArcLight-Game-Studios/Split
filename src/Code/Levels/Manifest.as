package Code.Levels 
{
	import Code.Engine.Game.Level;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * The Manifest class creates, stores, handles and displays the game levels.
	 * 
	 * @author Mark W. Thompson
	 */
	public class Manifest extends MovieClip
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		private var currentLevel:int = 1;
		private var sandbox:Level;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Manifest() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(e:Event):void 
		{
			sandbox = new Level(new Sandbox);
			addChild(sandbox);
			trace("Manifest initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);			
		}
	}
}
