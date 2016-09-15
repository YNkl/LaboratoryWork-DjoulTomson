package Interface 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nikolaev Yuriy
	 */
	public class PhazeOne_C extends phazeOne
	{
		private var isActive:Boolean = false;
		public var currStage:Object;
		
		public function PhazeOne_C(_stageWidth:Number, _stageHeight:Number) 
		{
			this.gotoAndStop(1);
			this.buttonMode = true;
			this.x = _stageWidth - this.width;
			this.y = _stageHeight - this.height;
			this.addEventListener(MouseEvent.MOUSE_OVER, function():void {
				if(!isActive) gotoAndStop(2);
			});
			this.addEventListener(MouseEvent.MOUSE_OUT, function():void {
				if(!isActive) gotoAndStop(1);
			});			
		}
		
		public function setStageActive():void{
			currStage.alpha = 1;
		}
		
		//активность кнопки		
		public function setActive():void
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			isActive = true;
			this.gotoAndStop(2);
		}
		//активность кнопки
		public function setUnActive():void
		{
			this.mouseEnabled = true;
			this.mouseChildren = true;
			isActive = false;
			this.gotoAndStop(1);
		}
				
	}

}