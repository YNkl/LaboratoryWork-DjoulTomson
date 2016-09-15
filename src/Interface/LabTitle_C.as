package Interface 
{
	/**
	 * ...
	 * @author Nikolaev Yuriy
	 */
	public class LabTitle_C extends LabTitle
	{
		private var stageWidth:Number;
		
		public function LabTitle_C(_stageWidth:Number) 
		{
			this.x = _stageWidth - this.width;
			this.y = 0;
		}
		
		public function onRes(_stageWidth:Number):void{
			this.x = _stageWidth - this.width;
			this.y = 0;
		}
	}

}