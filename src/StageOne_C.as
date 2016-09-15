package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class StageOne_C extends Sprite
	{
		private var mainMachine:MainMachine_C;
		private var background:Sprite;
		private var _stage:Stage;
		private var _this:*;
		
		private var stopWatch:StopWatch_C;
		
		public function StageOne_C(_Stage:Stage) 
		{
			_stage = _Stage;
			_this = this;
			//фон сцены
			background = new Sprite();
			background.graphics.beginFill(0xffffff);
			background.graphics.drawRect(0, 0, 1024, 768);
			background.graphics.endFill();
			addChild(background);
			
			mainMachine = new MainMachine_C(_stage);
			mainMachine.height = 700;
			mainMachine.width = mainMachine.height * 0.666351;
			mainMachine.x = background.width / 2 - (mainMachine.width / 2);
			addChild(mainMachine);
			
			stopWatch = new StopWatch_C();
			addChild(stopWatch);
			stopWatch.y = 120;
			stopWatch.x = 700;
		}
		
		public function setActive():void {
			this.alpha = 0;
			_stage.addChildAt(this, 0);
			TweenLite.to(this, 1, {alpha:1 } );
		}
		
		public function setUnActive():void{
			TweenLite.to(this, 0.2, {alpha:0, onComplete:function():void{_stage.removeChild(_this) }} );//_stage.removeChild(this);
		}
		
		public function onRes(_Width:Number, _Height:Number):void{
			
			this.y = 47;
			
			
			this.height = _Height;
			this.width = this.height * 4 / 3;
			this.x = _Width / 2 - this.width / 2;
		}
	}

}