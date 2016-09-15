package com.project
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class ScrollbarContentExampleView extends MovieClip
	{
		public var txtLabel:TextField;
		
		public var mcScrollbar:EDScrollbar;
		public var mcContent:MovieClip;
				
		/*
		Constructor
		*/
		
		public function ScrollbarContentExampleView()
		{
			super();
			
			this.mcScrollbar.initialize(this.update);
		}
		private function update($percent:Number):void{	
			this.txtLabel.text= String("Percentage: "+Math.round($percent*100)+"%");
			
			var numDifferenceOfHeight:Number = this.mcContent.mcContainer.height-this.mcContent.mcMask.height;			
			var numY:Number = 0-Math.round(numDifferenceOfHeight*$percent);
			
			//no easing
			//this._mcContainer.y = numY;  
			
			//easing
			TweenMax.to(this.mcContent.mcContainer, .5, {y:numY, ease:Expo.easeOut});				
		}
	}
	
}