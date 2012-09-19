package Code.States
{
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Code.Engine.Game.State;
	import Code.States;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * The main menu for Split.
	 * Links to the play state.
	 * 
	 * @see State class
	 * 
	 * @author Mark W. Thompson
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
		public function MainMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		public function Initialise(e:Event):void 
		{
			// Set up play button.
			playButton = getChildByName("playButton") as SimpleButton;
			playButton.addEventListener(MouseEvent.MOUSE_DOWN, OnPlayButtonDown);
			
			// Set up credits button.
			
			creditsButton = getChildByName("creditsButton") as SimpleButton;
			creditsButton.addEventListener(MouseEvent.MOUSE_DOWN, OnCreditsButtonDown);
			
			trace("Main menu initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Event handlers
		//--------------------------------------
		public function OnPlayButtonDown(e:MouseEvent):void 
		{
			trace("Play button pressed.");
			main.SwitchState(States.PLAY);
		}
		
		private function OnCreditsButtonDown(e:MouseEvent):void
		{
			trace("Credits button pressed.");
			main.SwitchState(States.CREDITS);
		}
	}
}
