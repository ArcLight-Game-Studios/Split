//***********************************************
//
// ARCLIGHT GAME STUDIOS
// Ewan McGregor, Graeme Grier, 
// Kemal Thomson, Mark Thompson, 
// Peeter Pärna, Stefan Harrison.
//
// APPLICATION:		Split
// CREATION DATE:	18/02/12
// LAST ACCESSED:	27/02/12
// HIERARCHY:		Code.Engine.Level
//
//***********************************************

package Code.Engine {

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	

	public class Level extends MovieClip {

		//=========================
		// PROPERTIES
		//=========================
		protected var timer:Timer;
		protected var stageReference:Stage;
		

		//=========================
		// CONSTRUCTOR
		//=========================
		public function Level(stageReference:Stage) {

			this.stageReference = stageReference;
			
			this.addEventListener(Event.ADDED_TO_STAGE,Initialise,false,0,true);

		}


		//=========================
		// INITIALISER
		//=========================
		private function Initialise(e:Event):void {
			
			timer = new Timer(1000);
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, TimerComplete, false, 0, true);
			timer.start();
			
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
		// END OF SCRIPT
		//=========================
	}
}