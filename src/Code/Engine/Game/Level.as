package Code.Engine.Game 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;
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
		public static const LEVEL_LOADED:String = "levelLoaded";
		public static const LEVEL_COMPLETE:String = "levelComplete";
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
		
		/**
		 * Calculates time since start of level.
		 */
		private function TimeElapsed():void 
		{			
			var timeElapsed:Number = getTimer(); // Returns milliseconds.
			var seconds:int = Math.floor(timeElapsed / 1000);
			var centiseconds:int = (timeElapsed % 1000) / 10; // 1x10^-2 seconds.
			var leadingZeroSeconds:String;
			var leadingZeroCentiseconds:String;
			var timeString:String;
			
			if (seconds < 10)
				leadingZeroSeconds = "0";
			else
				leadingZeroSeconds = "";
			
			if (centiseconds < 10)
				leadingZeroCentiseconds = "0";
			else
				leadingZeroCentiseconds = "";
			
			// Structure 00.00.
			timeString = (leadingZeroSeconds + seconds + "." + leadingZeroCentiseconds + centiseconds);				
		}

		//--------------------------------------
		//  Main loop
		//--------------------------------------
		public function Run(e:Event):void 
		{
			darkDimension.Update();
			//darkDimension.visible = false;
			lightDimension.Update();
			//TimeElapsed();
			
			// Conditions for level completion.
			if (lightDimension.reachedGoal && darkDimension.reachedGoal)
				trace("LEVEL COMPLETE!");
		}	
	}
}
