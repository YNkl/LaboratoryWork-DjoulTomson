package com.project
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class ScrollbarMCPropsExampleView extends MovieClip
	{
		public var txtLabel:TextField;
		public var mcProps:MovieClip;
		
		public var mcScrollbar:EDScrollbar;
				
		/*
		Constructor
		*/
		
		public function ScrollbarMCPropsExampleView()
		{
			super();
			
			this.mcProps.rotation = -180;			
			this.mcScrollbar.initialize(this.update,true,false);
		}
		private function update($percent:Number):void{	
			this.txtLabel.text= String("Percentage: "+Math.round($percent*100)+"%");
			
			var numAlpha:Number = 1-$percent;
			var numScaleX:Number = 1-$percent;
			var numScaleY:Number = 1-$percent;
			
			var numRotMin:Number = -180;
			var numRotMax:Number = 180;			
			var numRotDifference:Number = numRotMax-numRotMin;			
			var numRotation:Number = numRotMin+Math.round(numRotDifference*$percent);			
			
			TweenMax.to(this.mcProps, .5, {alpha:numAlpha, rotation:numRotation, scaleX:numScaleX, scaleY:numScaleY});
		}
	}
	
}