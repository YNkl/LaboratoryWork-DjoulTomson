package Interface 
{
	/**
	 * ...
	 * @author Nikolaev Yuriy
	 */
	public class ZeroPhaze_C extends ZeroPhaze
	{
		public var currStage:Object;
		private var isActive:Boolean = true;
		
		public function ZeroPhaze_C(_stageWidth:Number, _stageHeight:Number) 
		{
			//currStage = _stage;
			this.buttonMode = true;
			this.x = _stageWidth - this.width;
			this.y = _stageHeight - this.height;
		}
				
		//перерисовка сцены
		public function onRes(_stageWidth:Number, _stageHeight:Number):void{
			this.x = _stageWidth - this.width;
			this.y = _stageHeight - this.height;
		}
		//активность кнопки
		public function setActive():void
		{
			isActive = true;
			this.gotoAndStop(2);
		}
		//активность кнопки
		public function setUnActive():void
		{
			isActive = false;
			this.gotoAndStop(1);
		}
	}

}