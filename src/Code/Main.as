package Code 
{
	import Code.Levels.Manifest;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Code.States;
	import Code.States.MainMenu;
	import Code.States.Credits;
	import Code.Engine.Utils.Utility;

	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Document class (main entry point of the program).
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
		private const credits:Credits = new CreditsState();
		private const levelManifest:Manifest = new Manifest();

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Main() 
		{
			// Set the Utility.
			Utility.stage = this.stage;
			Utility.main = this;
			
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
			
			trace("\n- - - State switched - - -\n");
			
			switch(currentState) 
			{
				case States.MAIN_MENU:
					trace("--------------------\nMAIN MENU\n--------------------");
					addChild(mainMenu);
				break;
				
				case States.CREDITS:
					trace("--------------------\nCREDITS\n--------------------");
					addChild(credits);
				break;
				
				case States.PLAY:
					trace("--------------------\nPLAY\n--------------------");
					addChild(levelManifest);
				break;
			}
		}
	}
}