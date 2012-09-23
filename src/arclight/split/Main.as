package arclight.split 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import arclight.split.States;
	import arclight.split.states.MainMenu;
	import arclight.split.states.Credits;
	import arclight.split.states.Game;
	import arclight.split.TopLevel;

	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Document class (main entry point of the program).
	 * Creates, stores, handles and displays the game states.
	 * 
	 * @see States class
	 * 
	 * @author Mark Thompson
	 */
	public class Main extends TopLevel 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		public var currentState:int = States.INITIAL;
		private const mainMenu:MainMenu = new MainMenuState();
		private const credits:Credits = new CreditsState();
		private var game:Game;

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Main() 
		{			
			trace("Main script now running.");
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
			SwitchState(States.MAIN_MENU);
		}
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		public function SwitchState(newState:int):void 
		{
			if (currentState != States.INITIAL) {
				removeChildAt(numChildren - 1);
			}
			
			currentState = newState;
			
			trace("\n- - - State switched - - -\n");
			
			switch(currentState) {
				case States.MAIN_MENU:
					trace("--------------------\nMAIN MENU\n--------------------");
					addChild(mainMenu);
				break;
				
				case States.CREDITS:
					trace("--------------------\nCREDITS\n--------------------");
					addChild(credits);
				break;
				
				case States.GAME:
					trace("--------------------\nGAME\n--------------------");
					game = new Game(2);
				break;
			}
		}
	}
}