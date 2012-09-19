package Code.Engine.Text 
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * A refined version of the TextFiled class.
	 * Optimises various properties.
	 * Contains several predefined formats.
	 * 
	 * @author Mark W. Thompson
	 */
	public class RefinedTextField extends TextField
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		private var currentFormatID:int = 0;
		/* Format IDs */
		public static const P:int = 1;
		public static const H1:int = 2;
		/* Formats */
		private var p:TextFormat = new TextFormat("Arial", 15, 0xFFFFFF, true);
		private var h1:TextFormat = new TextFormat("Arial", 30, 0xFFFFFF, false);
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function RefinedTextField() 
		{
			selectable = false;
			mouseEnabled = false;
			autoSize = TextFieldAutoSize.CENTER;	
			addEventListener(Event.ADDED_TO_STAGE, Initialise);
		}
		
		//--------------------------------------
		//  Initialiser
		//--------------------------------------
		private function Initialise(e:Event):void 
		{
			p.align = TextFieldAutoSize.CENTER;
			h1.align = TextFieldAutoSize.CENTER;
			SetFormat(P);
		}
		
		//--------------------------------------
		//  Public methods
		//--------------------------------------
		public function SetFormat(formatID:int):void
		{
			if (formatID != currentFormatID)
			{
				switch(formatID)
				{
					case 1: defaultTextFormat = p; break;
					case 2: defaultTextFormat = h1; break;
					default: defaultTextFormat = p; break;
				}
			}
		}
	}
}