package Interface 
{
	/**
	 * ...
	 * @author Nikolaev Yuriy
	 */
	public class StageInfo_C extends StageInfo
	{
		private var isCurr:Number = 0;
		
		public function StageInfo_C(_stageWidth:Number, _stageHeight:Number, buttonsArray:Array) 
		{
			gotoAndStop(1);
			this.x = _stageWidth - this.width - 49 * (buttonsArray.length-4) + 11;
			this.y = _stageHeight - this.height;
		}
		
		public function setCurr(k:Number):void{
			isCurr = k;
		}
		public function getCurr():Boolean{
			return isCurr;
		}
		public function onRes(_stageWidth:Number, _stageHeight:Number, buttonsArray:Array):void{
			this.x = _stageWidth - this.width - 49 * (buttonsArray.length -4) + 11;
			this.y = _stageHeight - this.height;
		}
	}

}