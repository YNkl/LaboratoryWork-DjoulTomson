package com.project
{	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class ScrollbarExampleView extends MovieClip
	{
		public var txtLabel:TextField;
		public var mcScrollbar:EDScrollbar;
				
		public function ScrollbarExampleView()
		{
			super();		
			
			var bolVerticle:Boolean =true; //change to false for a horizontal scrollbar
			var bolUseArrows:Boolean=true; //change to false to hide arrows
			var numArrowSpeed:Number = 1; //Any value you want. (Example:  Slower 0.5   or   Faster 5)
			
			this.mcScrollbar.initialize(this.update,bolVerticle,bolUseArrows,numArrowSpeed);
		}
		private function update($percent:Number):void{
			this.txtLabel.text= String("Percentage: "+Math.round($percent*100)+"%");
		}		
	}	
}