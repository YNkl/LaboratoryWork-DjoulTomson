package Interface 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	/**
	 * информация о лабораторной вместе с кнопакми и переключением стадий
	 * @author Nikolaev Yuriy
	 */
	public class PhazesInfo extends Sprite
	{
		private var stageInfo:StageInfo_C;
		private var zeroPhaze:ZeroPhaze_C;
		public var buttons:Array;
		public var stages:Array;
		public var currStage:Number = 0;
		
		private var stg:*;
		private var exitQuestion:ExitQuestion_C;
		
		public function PhazesInfo(_stageWidth:Number, _stageHeight:Number, st:*, _exitQuestion:ExitQuestion_C ) 
		{
			stg = st;
			exitQuestion = _exitQuestion;
			
			buttons = new Array;
			buttons[0] = new ZeroPhaze_C(_stageWidth, _stageHeight);
			buttons[1] = new PhazeOne_C(_stageWidth, _stageHeight);	
			buttons[2] = new PhazeTwo_C(_stageWidth, _stageHeight);	
			buttons[3] = new PhazeThree_C(_stageWidth, _stageHeight);
			buttons[4] = new PhazeFour_C(_stageWidth, _stageHeight);
			buttons[5] = new PhazeFive_C(_stageWidth, _stageHeight);
			//buttons[3] = new pha
			stageInfo = new StageInfo_C(_stageWidth, _stageHeight, buttons);
			addChild(stageInfo);
			addChild(buttons[0]);
			addChild(buttons[1]);
			//addChild(buttons[2]);
			//addChild(buttons[3]);
			//addChild(buttons[4]);
			//addChild(buttons[5]);
			
			
			
			onRes(_stageWidth, _stageHeight);
			//включаем превью
			buttons[0].addEventListener(MouseEvent.CLICK, function():void{
				
				
			});
			//включаем первую стадию
			buttons[1].addEventListener(MouseEvent.CLICK, function():void{
				stageInfo.gotoAndStop(2);
				stageInfo.setCurr(1);
				buttons[1].setActive();
				buttons[2].setUnActive();
				buttons[3].setUnActive();
				buttons[4].setUnActive();
				buttons[5].setUnActive();
				setButStage(1);
				currStage = 1;
			});
			//включаем вторую сцену
			buttons[2].addEventListener(MouseEvent.CLICK, function():void{
				stageInfo.gotoAndStop(3);
				stageInfo.setCurr(2);
				//buttons[1].setUnActive();
				buttons[2].setActive();
				buttons[3].setUnActive();
				buttons[4].setUnActive();
				buttons[5].setUnActive();
				setButStage(2);
				currStage = 2;
			});
			buttons[3].addEventListener(MouseEvent.CLICK, function():void{
				stageInfo.gotoAndStop(4);
				stageInfo.setCurr(3);
				//buttons[1].setUnActive();
				//buttons[2].setUnActive();
				buttons[3].setActive();
				buttons[4].setUnActive();
				buttons[5].setUnActive();
				setButStage(4);
				currStage = 3;
			});
			buttons[4].addEventListener(MouseEvent.CLICK, function():void{
				stageInfo.gotoAndStop(5);
				stageInfo.setCurr(4);
				//buttons[1].setUnActive();
				//buttons[2].setUnActive();
				//buttons[3].setUnActive();
				buttons[4].setActive();
				buttons[5].setUnActive();
				setButStage(4);
				currStage = 4;
			});
			buttons[5].addEventListener(MouseEvent.CLICK, function():void{
				stageInfo.gotoAndStop(6);
				stageInfo.setCurr(5);
				//buttons[1].setUnActive();
				//buttons[2].setUnActive();
				//buttons[3].setUnActive();
				//buttons[4].setUnActive();
				buttons[5].setActive();
				setButStage(5);
				currStage = 5;
			});
			
			buttons[0].addEventListener(MouseEvent.MOUSE_OVER, function():void{
				stageInfo.gotoAndStop(1);
			});
			buttons[0].addEventListener(MouseEvent.MOUSE_OUT, function():void{
				stageInfo.gotoAndStop(currStage + 1);
			});
			
			buttons[1].addEventListener(MouseEvent.MOUSE_OVER, function():void{
				stageInfo.gotoAndStop(2);
			});
			buttons[1].addEventListener(MouseEvent.MOUSE_OUT, function():void{
				stageInfo.gotoAndStop(currStage + 1);
			});
			buttons[2].addEventListener(MouseEvent.MOUSE_OVER, function():void{
				stageInfo.gotoAndStop(3);
			});
			buttons[2].addEventListener(MouseEvent.MOUSE_OUT, function():void{
				stageInfo.gotoAndStop(currStage + 1);
			});
			buttons[3].addEventListener(MouseEvent.MOUSE_OVER, function():void{
				stageInfo.gotoAndStop(4);
			});
			buttons[3].addEventListener(MouseEvent.MOUSE_OUT, function():void{
				stageInfo.gotoAndStop(currStage + 1);
			});
			buttons[4].addEventListener(MouseEvent.MOUSE_OVER, function():void{
				stageInfo.gotoAndStop(5);
			});
			buttons[4].addEventListener(MouseEvent.MOUSE_OUT, function():void{
				stageInfo.gotoAndStop(currStage + 1);
			});
			buttons[5].addEventListener(MouseEvent.MOUSE_OVER, function():void{
				stageInfo.gotoAndStop(6);
			});
			buttons[5].addEventListener(MouseEvent.MOUSE_OUT, function():void{
				stageInfo.gotoAndStop(currStage + 1);
			});
			
			for (var i:Number = 2; i < buttons.length;i++ ){
				buttons[i].setUnActive();
			}
		}
		private function setButStage(_num:Number ):void {
			for (var i:Number = 1; i < _num;i++ ) {
				buttons[i].gotoAndStop(3);
				buttons[i].mouseEnabled = false;
			    buttons[i].mouseChildren = false;
			}
		}
		
		public function reboot():void{
				stages[0].setActive();
				stages[1].setUnActive();
				//stages[2].setUnActive();
				//stages[3].setUnActive();
				
				stageInfo.gotoAndStop(1);
				stageInfo.setCurr(0);
				buttons[1].setUnActive();
				buttons[2].setUnActive();
				buttons[3].setUnActive();
				buttons[4].setUnActive();
				buttons[5].setUnActive();
			}
		
		//переключение между сценами
		public function setStages(_stages:Array):void
		{	
			stages = _stages;
			
				
			buttons[0].addEventListener(MouseEvent.CLICK, function():void {
			
				
				
				if (currStage != 0) {
					exitQuestion.alpha = 0;	
					parent.addChild(exitQuestion);
					TweenLite.to(exitQuestion, 0.7, {alpha:1 } );
				}
				//reboot();
				//stg.reboot();
				//_stages[4].setUnActive();
			});
			buttons[1].addEventListener(MouseEvent.CLICK, function():void {
				_stages[0].setUnActive();	
				_stages[1].setActive();
				//_stages[2].setUnActive();
				//_stages[3].setUnActive();
				//_stages[4].setUnActive();
			});
			buttons[2].addEventListener(MouseEvent.CLICK, function():void {
				_stages[0].setUnActive();
				_stages[1].setStageTwoAvailable();
				//_stages[1].setUnActive();
				//_stages[2].setActive(2);
				//_stages[3].setUnActive();
				//_stages[4].setUnActive();
			});
			buttons[3].addEventListener(MouseEvent.CLICK, function():void {
				_stages[0].setUnActive();	
				_stages[1].setStageThreeAvailable();
				//_stages[2].setUnActive();
				//_stages[3].setActive();
				//_stages[4].setUnActive();
			});
			buttons[4].addEventListener(MouseEvent.CLICK, function():void {
				_stages[0].setUnActive();	
				_stages[1].setStageFourAvailable();
				//_stages[2].setUnActive();
				//_stages[3].setUnActive();
				//_stages[2].setActive(4);
			});
			buttons[5].addEventListener(MouseEvent.CLICK, function():void {
				_stages[0].setUnActive();	
				_stages[1].setStageFiveAvailable();
			});
		}
		
		public function getBut(num:Number){
			return buttons[num];
		}
		
		public function onRes(_stageWidth:Number, _stageHeight:Number):void{
			stageInfo.onRes(_stageWidth, _stageHeight, buttons);
			var butWidth:Number = 0;
			var butHeight:Number = 0;
				for (var i:Number = buttons.length-5; i >= 0; i--) {
					butWidth += buttons[i].width;
					butHeight = buttons[i].height;
					buttons[i].x = _stageWidth - butWidth;
					buttons[i].y = _stageHeight - butHeight;
				}
		}
		
		
	}

}