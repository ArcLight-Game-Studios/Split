package arclight.split.containers 
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import arclight.split.TopLevel;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * A refined version of the TextFiled class.
	 * Optimises various properties.
	 * 
	 * @author Mark Thompson
	 */
	public class Text extends TextField
	{
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function Text() 
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
		private function Initialise(event:Event = null):void 
		{
			if (event) {
				removeEventListener(Event.ADDED_TO_STAGE, Initialise);
			}
			selectable = false;
			mouseEnabled = false;
			autoSize = TextFieldAutoSize.CENTER;
		}
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		/**
		 * Sets the texts format.
		 * 
		 * @param	format The format which the text will use.
		 */
		public function SetFormat(format:TextFormat):void
		{
			defaultTextFormat = format; 
		}
	}
}