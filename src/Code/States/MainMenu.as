package Code.States
{
	import Code.Engine.Game.State;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Code.States;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Main menu.
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
			playButton.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			
			trace("MainMain initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Event handlers
		//--------------------------------------
		public function OnMouseDown(e:MouseEvent):void 
		{
			trace("playButton pressed.");
			main.SwitchState(States.PLAY);
		}
	}
}