package Interface 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nikolaev Yuriy
	 */
	public class ExitButt_C extends ExitButt
	{
		
		public function ExitButt_C(_stageWidth:Number) 
		{
			this.x = _stageWidth - this.width - 12;
			this.y = 13;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, showMsg);
		}
		
		public function onRes(_stageWidth:Number):void{
			this.x = _stageWidth - this.width - 12;
			this.y = 13;
		}
		
		public function setMsg():void{
			
		}
		
		public function showMsg(e:MouseEvent):void{
			trace("close");
		}
	}

}