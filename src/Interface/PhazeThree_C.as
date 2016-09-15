package Interface 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class PhazeThree_C extends PhazeThree
	{
		public var isActive:Boolean = false;
		public var currStage:Object;
		public var isAvailable:Boolean = false;
		
		public function PhazeThree_C(_stageWidth:Number, _stageHeight:Number) 
		{
			this.gotoAndStop(1);
			this.buttonMode = true;
			this.x = _stageWidth - this.width;
			this.y = _stageHeight - this.height;
			this.addEventListener(MouseEvent.MOUSE_OVER, function():void {
				if(!isActive) gotoAndStop(3);
			});
			this.addEventListener(MouseEvent.MOUSE_OUT, function():void {
				if(!isActive) gotoAndStop(2);
			});			
			
		}
		
		public function setStageActive():void{
			currStage.alpha = 1;
		}
		
		//активность кнопки		
		public function setActive():void
		{
			//trace(23232323);
			this.buttonMode = true;
			isActive = true;
			this.gotoAndStop(3);
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		//активность кнопки
		public function setUnActive():void
		{
			isAvailable = false;
			isActive = false;
			this.buttonMode = false;
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.gotoAndStop(1);
		}
		
		public function setAvailable():void {
			isAvailable = true;	
			this.buttonMode = true;
			isActive = false;
			this.gotoAndStop(2);
			
			this.mouseEnabled = true;
			this.mouseChildren = true;
		}
	}

}