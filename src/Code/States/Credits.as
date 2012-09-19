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
	 * The credits of Split.
	 * Links to the main menu state.
	 * 
	 * @see State class
	 * 
	 * @author Mark W. Thompson
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
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		public function Initialise(e:Event):void 
		{		
			// Set up credits button.
			backButton = getChildByName("backButton") as SimpleButton;
			backButton.addEventListener(MouseEvent.MOUSE_DOWN, OnBackButtonDown);
			
			trace("Credits initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
			//--------------------------------------
		//  Event handlers
		//--------------------------------------
		public function OnBackButtonDown(e:MouseEvent):void 
		{
			trace("Back button pressed.");
			main.SwitchState(States.MAIN_MENU);
		}
	}
}
