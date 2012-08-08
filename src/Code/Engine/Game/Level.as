package Code.Engine.Game 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import Code.Engine.Game.Dimension;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Contains both light and dark dimensions.
	 * Keeps time and victory conditions.
	 * 
	 * @author Mark W. Thompson
	 */
	public class Level extends MovieClip 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/* Events */
		public static const LEVEL_LOADED:String = "levelLoaded";
		public static const LEVEL_COMPLETE:String = "levelComplete";
		/* Level */
		public var darkDimension:Dimension;
		public var lightDimension:Dimension;
		private var levelContent:Sprite;
		public var complete:Boolean = false;

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Level(levelContent:Sprite) 
		{
			this.levelContent = levelContent;	
			
			// Dark dimension.
			darkDimension = levelContent.getChildByName("dark") as Dimension;
			darkDimension.type = Dimension.DARK;
			
			// Light dimension.
			lightDimension = levelContent.getChildByName("light") as Dimension;
			lightDimension.type = Dimension.LIGHT;
			
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(e:Event):void 
		{	
			addChild(levelContent);
			
			addEventListener(Event.ENTER_FRAME, Run);
			trace("Level initialised.");
			removeEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Destructor
		//--------------------------------------
		public function Destroy():void 
		{
			/*
			removeChild(levelContent);
			for (var i:int = 0; i < levelContent.numChildren; i++) 
			{
				var object:Object = levelContent.getChildAt(i);
				levelContent.removeChildAt(i);
				object = null;
			}
			levelContent = null;
			trace("Level destroyed");*/
		}

		//--------------------------------------
		//  Main loop
		//--------------------------------------
		public function Run(e:Event):void 
		{
			// Update dimensions - where actual gameplay takes place.
			darkDimension.Update();
			lightDimension.Update();
			
			// Update timer.
			// timer.Update();
		}
		
		//--------------------------------------
		//  Event handlers
		//--------------------------------------
		/* Once the level has been loaded key presses are no longer ignored,
		 * it locks focus to the stage so that keyboard interactions are detected and
		 * the main loop is added as an event listener so it updates every frame.
		 * The chapter containing the set of levels is notified that the level has been loaded.
		 */
		protected function OnLevelLoaded(e:Event):void 
		{
			/*
			fadeTweener.removeEventListener(FadeTweener.TWEEN_COMPLETE, OnLevelLoaded);
			player.ignoreKeys = false;
			stage.focus = stage;
			addEventListener(Event.ENTER_FRAME, Run);
			parent.dispatchEvent(new Event(LEVEL_LOADED));*/
		}
		
		/* Once the level is complete the destructors are called and event listeners are removed.
		 * In addition to this, the complete flag is set to true which destroys components and 
		 * triggers the loading of the next level (if there is one).
		 */
		protected function OnLevelComplete(e:Event):void 
		{	
			/*
			complete = true;
			removeEventListener(Event.ENTER_FRAME, Run);
			fadeTweener.removeEventListener(FadeTweener.TWEEN_COMPLETE, OnLevelComplete);
			parent.dispatchEvent(new Event(LEVEL_COMPLETE));
			player.Destroy();
			Destroy();*/
		}		
	}
}
