package Code.Engine.Text 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	//--------------------------------------
    //  Class description
    //--------------------------------------	
	/**
	 * A refined version of the TextFiled class:
	 * optimises various properties of the default class.
	 * 
	 * @author Mark W. Thompson
	 */
	public class RefinedTextfield extends TextField
	{
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function RefinedTextField() 
		{
			selectable = false;
			mouseEnabled = false;
			autoSize = TextFieldAutoSize.CENTER;
		}
	}
}