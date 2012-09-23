package arclight.split.states 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import arclight.split.TopLevel;
	import arclight.split.Resources;
	import arclight.split.containers.State;
	
	/**
	 * Game state handles the loading and switching of levels.
	 * 
	 * @author Mark Thompson
	 */
	public class Game extends State
	{
		private var currentLevel:int;
		
		public function Game(level:int) 
		{
			this.currentLevel = level;
			Initialise();
		}
		
		private function Initialise():void 
		{
			LoadLevel(currentLevel);
		}
		
		private function LoadLevel(level:int):void 
		{
			TopLevel.stage.addChild(Resources.LEVELS[level]);
			Resources.LEVELS[level].Initialise();
			Resources.LEVELS[level].Start();
		}
	}
}