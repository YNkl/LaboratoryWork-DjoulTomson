package com.project
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class ScrollbarTimelineExampleView extends MovieClip
	{
		public var txtLabel:TextField;
		public var mcTimeline:MovieClip;
		
		public var mcScrollbar:EDScrollbar;
				
		/*
		Constructor
		*/
		
		public function ScrollbarTimelineExampleView()
		{
			super();
			this.mcTimeline.gotoAndStop(1);
			this.mcScrollbar.initialize(this.update,false);
		}
		private function update($percent:Number):void{			
			var numOfFrame:Number = 269;			
			var numGoToFrame:Number = Math.round((numOfFrame-1)*$percent)+1;			
			
			this.txtLabel.text= String("Percentage: "+Math.round($percent*100)+"%  |  Frame: "+numGoToFrame);				
			TweenMax.to(this.mcTimeline, .8, {frame:numGoToFrame});			
		}
	}
	
}