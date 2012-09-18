package Code.Engine.Game 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Placeholder for state classes.
	 * 
	 * @see States class
	 * @see MainMenu class
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
		public function SwitchMode():void
		{
			mouseChildren = !mouseChildren;
			mouseEnabled = !mouseEnabled;
			visible = !visible;
		}
	}
}