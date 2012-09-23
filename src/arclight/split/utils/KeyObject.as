package arclight.split.utils 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------
	/**
	 * The KeyObject class recreates functionality of
	 * Key.isDown of ActionScript 1 and 2
	 *
	 * Usage:
	 * var key:KeyObject = new KeyObject(stage);
	 * if (key.isDown(key.LEFT)) { ... }
	 * 
	 * @author Trevor McCauler
	 */
	dynamic public class KeyObject extends Proxy 
	{
		
		private static var stage:Stage;
		private static var keysDown:Object;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function KeyObject(stage:Stage) 
		{
			Construct(stage);
		}
		
		public function Construct(stage:Stage):void 
		{
			KeyObject.stage = stage;
			keysDown = new Object();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyReleased);
		}
		
		flash_proxy override function getProperty(name:*):* 
		{
			return (name in Keyboard) ? Keyboard[name] : -1;
		}
		
		public function IsDown(keyCode:uint):Boolean 
		{
			return Boolean(keyCode in keysDown);
		}
		
		public function Deconstruct():void 
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyPressed);
			stage.removeEventListener(KeyboardEvent.KEY_UP, KeyReleased);
			keysDown = new Object();
			KeyObject.stage = null;
		}
		
		//--------------------------------------
		//  EventHandlers
		//--------------------------------------
		private function KeyPressed(keyEvent:KeyboardEvent):void 
		{
			keysDown[keyEvent.keyCode] = true;
		}
		
		private function KeyReleased(keyEvent:KeyboardEvent):void 
		{
			delete keysDown[keyEvent.keyCode];
		}
	}
}