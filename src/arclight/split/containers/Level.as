package arclight.split.containers 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	import arclight.split.containers.Dimension;
	import arclight.split.TopLevel;
	import arclight.split.Resources;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Container for the light and dark dimensions.
	 * Most top-level gameplay logic resides in the Level class.
	 * 
	 * @author Mark Thompson
	 */
	public class Level extends Sprite 
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/* Dimensions */
		public var darkDimension:Dimension;
		public var lightDimension:Dimension;
		private var darkContent:Sprite;
		private var lightContent:Sprite;
		/* Level */
		private var content:Sprite;
		/* Timer */
		private var timerText:Text = new Text();
		private var startTime:int;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Level(content:Sprite) 
		{	
			this.content = content;
			darkContent = content.getChildByName("dark") as Sprite;
			lightContent = content.getChildByName("light") as Sprite;
		}

		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		public function Initialise():void 
		{		
			darkDimension = new Dimension(darkContent);
			lightDimension = new Dimension(lightContent);
			darkDimension.Initialise();
			lightDimension.Initialise();
			
			timerText.text = "00.00";
			timerText.background = true;
			timerText.backgroundColor = 0x000000;
			timerText.SetFormat(Resources.P);
			trace("Level initialised.");
		}
		
		public function Start():void 
		{
			addChild(content);
			addChild(timerText);
			timerText.x = (TopLevel.stage.width / 2) - (timerText.width / 2);
			startTime = getTimer();
			addEventListener(Event.ENTER_FRAME, Run);
			trace("Level started");
		}
		
		public function End():void 
		{
			trace("Level ended.");
		}
		

		/**
		 * Calculates time since the level started.
		 */
		private function UpdateTime():void 
		{			
			var timeElapsed:Number = getTimer() - startTime; // Returns milliseconds.
			var seconds:int = Math.floor(timeElapsed / 1000);
			var centiseconds:int = (timeElapsed % 1000) / 10; // 1x10^-2 seconds.
			var leadingZeroSeconds:String;
			var leadingZeroCentiseconds:String;
			var timeString:String;
			
			if (seconds < 10) {
				leadingZeroSeconds = "0";
			} else {
				leadingZeroSeconds = "";
			}
			
			if (centiseconds < 10) {
				leadingZeroCentiseconds = "0";
			} else {
				leadingZeroCentiseconds = "";
			}
			
			// Structure 00.00.
			timeString = (leadingZeroSeconds + seconds + "." + leadingZeroCentiseconds + centiseconds);	
			
			// Update text field.
			timerText.text = timeString;
		}

		//--------------------------------------
		//  Main loop
		//--------------------------------------
		public function Run(event:Event):void 
		{
			darkDimension.Update();
			lightDimension.Update();
			UpdateTime();		
			
			// Conditions for level completion.
			if (lightDimension.reachedGoal && darkDimension.reachedGoal) {
				trace("LEVEL COMPLETE!");
			}
		}	
	}
}