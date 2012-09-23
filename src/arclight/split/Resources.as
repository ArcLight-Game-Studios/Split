package arclight.split 
{
	import arclight.split.containers.Level;
	import arclight.split.game.Sandbox;
	import arclight.split.game.Scrolling;
	import arclight.split.game.Template;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * Stores all resources here so that they are not defined/instantiated several times.
	 * Efficient and saves memory!
	 * 
	 * @author Mark Thompson
	 */
	public class Resources
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/* Levels */
		public static const TEMPLATE:Level = new Level(new Template);
		public static const SANDBOX:Level = new Level(new Sandbox);
		public static const SCROLLING:Level = new Level(new Scrolling);
		public static var LEVELS:Array = new Array(TEMPLATE, SANDBOX, SCROLLING);
		/* Formats */
		public static const P:TextFormat = new TextFormat("Arial", 15, 0xFFFFFF, true);
		public static const H1:TextFormat = new TextFormat("Arial", 30, 0xFFFFFF, false);
	}
}