package Trriggers 
{
	import com.greensock.TimelineLite;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class CompressorHandlerSequence_C extends Sprite
	{
		private var leftMask:ButMask_mc;
		private var rightMask:ButMask_mc;
		private var arrow:Arrow_mc;
		private var handl:HandlerSequence_mc;
		
		private var wheelLeft:Boolean = false;
		private var wheelRight:Boolean = false;
		private var mainStage:Stage;
		
		public function CompressorHandlerSequence_C(_arrow:Arrow_mc, _stage:Stage) 
		{
			
			mainStage = _stage;
			//инициализация стрелки
			arrow = _arrow;
			
			//ручка
			handl = new HandlerSequence_mc();
			handl.gotoAndStop
			handl.height = 91;
			handl.width = 90;
			handl.rotation = -135;
			handl.addEventListener(Event.ENTER_FRAME, onEnterFrameWheel);
			addChild(handl);
			
			//маска вращения налево
			leftMask = new ButMask_mc();
			leftMask.height = this.height;
			leftMask.width = this.width / 2;
			leftMask.rotation = -180;
			leftMask.alpha = 0.3;
			leftMask.y = leftMask.height / 2;
			leftMask.x = -2;
			leftMask.buttonMode = true;
			leftMask.addEventListener(MouseEvent.MOUSE_OVER, function():void { TweenLite.to(leftMask, 0.2, { alpha:0 } ); } );
			leftMask.addEventListener(MouseEvent.MOUSE_OUT, function():void { TweenLite.to(leftMask, 0.2, { alpha:0.3 } ); } );
			leftMask.addEventListener(MouseEvent.MOUSE_WHEEL, wheelHandl);
			leftMask.addEventListener(MouseEvent.MOUSE_DOWN, function():void { wheelLeft = true; } );
			mainStage.addEventListener(MouseEvent.MOUSE_UP, function():void { wheelLeft = false; } );
			addChild(leftMask);
			
			//маска вращения направо
			rightMask = new ButMask_mc();
			rightMask.height = this.height;
			rightMask.width = this.width / 2;
			rightMask.alpha = 0.3;
			rightMask.y = -rightMask.height / 2 - 1;
			rightMask.x = 1;
			rightMask.buttonMode = true;
			rightMask.addEventListener(MouseEvent.MOUSE_OVER, function():void { TweenLite.to(rightMask, 0.2, { alpha:0 } ); } );
			rightMask.addEventListener(MouseEvent.MOUSE_OUT, function():void { TweenLite.to(rightMask, 0.2, { alpha:0.3 } ); } );
			rightMask.addEventListener(MouseEvent.MOUSE_WHEEL, wheelHandl);
			rightMask.addEventListener(MouseEvent.MOUSE_DOWN, function():void { wheelRight = true; } );
			mainStage.addEventListener(MouseEvent.MOUSE_UP, function():void { wheelRight = false; } );
			addChild(rightMask);
			
			//выключаем 
			setUnActive();
		}
		//вращение по нажатию
		private function onEnterFrameWheel(e:Event):void{
			if(wheelLeft && arrow.rotation <= 135 && arrow.rotation > -135){
				handl.rotation -= 2;
				arrow.rotation -= 2;
			}
			if(wheelRight && arrow.rotation >= -135 && arrow.rotation < 135){
				handl.rotation += 2;
				arrow.rotation += 2;
			}
		}
		//вращение по прокрутке колесика
		private function wheelHandl(e:MouseEvent):void{
			if(e.delta > 0 && arrow.rotation >= -135 && arrow.rotation < 135){
				handl.rotation += 2;
				arrow.rotation += 2;
			}
			if(e.delta < 0 && arrow.rotation <= 135 && arrow.rotation > -135){
				handl.rotation -= 2;
				arrow.rotation -= 2;
			}
		}
		//получить ссылку на стрелку
		public function getArrowLink():Arrow_mc{
			return arrow;
		}
		
		public function setActive():void {
			TweenLite.to(leftMask, 0.5, { alpha:0.3 } );
			leftMask.mouseEnabled = true;
			leftMask.mouseChildren = true;
			
			TweenLite.to(rightMask, 0.5, { alpha:0.3 } );
			rightMask.mouseEnabled = true;
			rightMask.mouseChildren = true;
		}
		
		public function setUnActive():void {
			
			TweenLite.to(leftMask, 0.5, { alpha:0 } );
			leftMask.mouseEnabled = false;
			leftMask.mouseChildren = false;
			
			TweenLite.to(rightMask, 0.5, { alpha:0 } );
			rightMask.mouseEnabled = false;
			rightMask.mouseChildren = false;
		}
	}

}