package Interface 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Nikolaev Yuriy
	 */
	public class MainBanner extends Sprite
	{
		private var bg:Header_C;
		private var logo:Logo_C;
		private var title:LabTitle_C;
		//private var exit:ExitButt_C;
		private var stageWidth:Number;
		
		public function MainBanner(_stageWidth:Number, _stageHeight:Number) 
		{
			bg = new Header_C(_stageWidth);
			logo = new Logo_C();
			title = new LabTitle_C(_stageWidth);
			//exit = new ExitButt_C(_stageWidth);
			
			addChild(bg);
			addChild(logo);
			addChild(title);
			//addChild(exit);
		}
		
		public function onRes(_stageWidth:Number, _stageHeight:Number):void{
			bg.onRes(_stageWidth);
			title.onRes(_stageWidth);
			//exit.onRes(_stageWidth);
		}
	}

}