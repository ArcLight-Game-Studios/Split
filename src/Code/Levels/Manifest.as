package Code.Levels 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Code.Engine.Game.Level;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Creates, stores, handles and displays the levels of Split.
	 * These levels can be modified in the Split Flash Professional file.
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
			sandbox = new Level(new Scrolling);
			addChild(sandbox);
			trace("Manifest initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);			
		}
	}
}