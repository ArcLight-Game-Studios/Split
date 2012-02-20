//***********************************************
//
// ARCLIGHT GAME STUDIOS
// Ewan McGregor, Graeme Grier, 
// Kemal Thomson, Mark Thompson, 
// Peeter Pärna, Stefan Harrison.
//
// APPLICATION:		Split
// CREATION DATE:	18/02/12
// LAST ACCESSED:	20/02/12
// HIERARCHY:		Code.Classes.Level
//
//***********************************************

package Code.Classes {

	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import Code.Classes.Dimension;
	import flash.display.Stage;

	public class Level extends MovieClip {

		//=========================
		// PROPERTIES
		//=========================
		protected var timer:Timer;
		protected var completetionTime:Number;
		protected var stageReference:Stage;
		private var header:Platform;
		

		//=========================
		// CONSTRUCTOR
		//=========================
		public function Level(stageReference:Stage, time:Number) {

			this.completetionTime = time;
			this.stageReference = stageReference;
			
			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);

		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {
			
			timer = new Timer(completetionTime);
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, TimerComplete, false, 0, true);
			timer.start();
			
			header = new Platform(0,0,stage.stageWidth,50,0xCCCCCC);
			this.addChild(header);
			
			this.removeEventListener(Event.ADDED_TO_STAGE,Initialise);
			
		}


		//=========================
		// NON-PUBLIC FUNCTIONS
		//=========================
		protected function Tick(e:TimerEvent):void {
			trace("tick");
		}
		
		protected function TimerComplete(e:TimerEvent):void {
			timer.stop();
			trace("timerComplete");
		}


		//=========================
		// PUBLIC FUNCTIONS
		//=========================
		


		//=========================
		// END OF SCRIPT
		//=========================
	}
}