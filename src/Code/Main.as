package Code 
{
	import Code.Levels.Manifest;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Code.States;
	import Code.States.MainMenu;

	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Main is the main entry point of the program (the document class).
	 * Creates, stores, handles and displays the game states.
	 * 
	 * @see States class
	 * 
	 * @author Mark W. Thompson
	 */
	public class Main extends MovieClip 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		public var currentState:int = States.INITIAL;
		private const mainMenu:MainMenu = new MainMenuState();
		private const levelManifest:Manifest = new Manifest();

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Main() 
		{
			trace("Main script now running.");
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(e:Event):void 
		{			
			SwitchState(States.MAIN_MENU);
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		public function SwitchState(newState:int):void 
		{
			if (currentState != States.INITIAL) 
			{
				removeChildAt(numChildren - 1);
			}
			
			currentState = newState;
			
			switch(currentState) 
			{
				case States.MAIN_MENU:
					trace("\nMAIN MENU\n----------------------------");
					addChild(mainMenu);
				break;
				
				case States.PLAY:
					trace("\nPLAY\n----------------------------");
					addChild(levelManifest);
				break;
			}
		}
	}
}
