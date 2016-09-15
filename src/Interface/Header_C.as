package Interface
{
	/**
	 * ...
	 * @author Nikolaev Yuriy
	 */
	public class Header_C extends Header
	{
		private var stageWidth:Number;
		private var logo:Logo_C;
		
		public function Header_C(StageWidth:Number) 
		{
			this.x = 0;
			this.y = 0;
			stageWidth = StageWidth;
			this.width = StageWidth;
		}
		
		public function onRes(StageWidth:Number):void{
			this.width = StageWidth;
		}
	}

}