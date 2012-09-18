package Code.States
{
	import flash.display.MovieClip;
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
			playButton = getChildByName("playButton") as PlayButton;
			playButton.addEventListener(MouseEvent.MOUSE_DOWN, OnPlayButtonDown);
			
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
	}
}
