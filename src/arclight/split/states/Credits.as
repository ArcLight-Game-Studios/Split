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
	 * The credits of Split.
	 * Links to the main menu state.
	 * 
	 * @see State class
	 * 
	 * @author Mark Thompson
	 */
	public class Credits extends State
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		private var backButton:SimpleButton;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Credits() 
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
		public function Initialise(event:Event = null):void 
		{		
			if (event) {
				removeEventListener(Event.ADDED_TO_STAGE, Initialise);
			}
			// Set up credits button.
			backButton = getChildByName("backButton") as SimpleButton;
			backButton.addEventListener(MouseEvent.MOUSE_DOWN, OnBackButtonDown);
			
			trace("Credits initialised.");
		}
		
		//--------------------------------------
		//  Event handlers
		//--------------------------------------
		public function OnBackButtonDown(mouseEvent:MouseEvent):void 
		{
			trace("Back button pressed.");
			main.SwitchState(States.MAIN_MENU);
		}
	}
}
