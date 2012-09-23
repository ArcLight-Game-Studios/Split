package arclight.split.states
{
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import arclight.split.States;
	import arclight.split.containers.State;
	import arclight.split.TopLevel;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * The main menu for Split.
	 * Links to the play state.
	 * 
	 * @see State class
	 * 
	 * @author Mark Thompson
	 */
	public class MainMenu extends State
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		private var playButton:SimpleButton;
		private var creditsButton:SimpleButton;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function MainMenu() {
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
			// Set up play button.
			playButton = getChildByName("playButton") as SimpleButton;
			playButton.addEventListener(MouseEvent.MOUSE_DOWN, OnPlayButtonDown);
			
			// Set up credits button.
			creditsButton = getChildByName("creditsButton") as SimpleButton;
			creditsButton.addEventListener(MouseEvent.MOUSE_DOWN, OnCreditsButtonDown);
			
			trace("Main menu initialised.");
		}
		
		//--------------------------------------
		//  Event handlers
		//--------------------------------------
		public function OnPlayButtonDown(e:MouseEvent):void 
		{
			trace("Play button pressed.");
			main.SwitchState(States.GAME);
		}
		
		private function OnCreditsButtonDown(e:MouseEvent):void
		{
			trace("Credits button pressed.");
			main.SwitchState(States.CREDITS);
		}
	}
}
