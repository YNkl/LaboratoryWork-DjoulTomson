package Trriggers 
{
	import com.greensock.TimelineLite;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class CompressorHandler_C extends Sprite
	{
		private var leftMask:ButMask_mc;
		private var rightMask:ButMask_mc;
		private var arrow:Arrow_mc;
		private var handl:Handle_mc;
		
		private var wheelLeft:Boolean = false;
		private var wheelRight:Boolean = false;
		private var mainStage:Stage;
		private var temperatureTrigger:TemperatureTrigger_C;
		
		//трясется ли стрелка
		private var isBounce:Boolean = false;
		
		//таймеры роста температур
		private var tickUp:Timer = new Timer(20,1);
		private var tickDown:Timer = new Timer(20, 1);
		
		public function CompressorHandler_C(_arrow:Arrow_mc, _stage:Stage) 
		{
			
			mainStage = _stage;
			//инициализация стрелки
			arrow = _arrow;
			
			//ручка
			handl = new Handle_mc();
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
		
		var arrowPosition:Number = 135;
		
		//вращение по нажатию
		private function onEnterFrameWheel(e:Event):void{
			if(wheelLeft && handl.rotation <= 135 && handl.rotation > -135){
				handl.rotation -= 1.25;
				arrow.rotation -= 1.25;
				
				//trace(Math.abs(arrow.rotation - arrowPosition));
				if(Math.abs(Math.abs(handl.rotation) % 27.5) == 0){
					temperatureTrigger.T1.text = String(Math.round((Number(temperatureTrigger.T1.text) - 0.1) * 10) / 10);
					arrowPosition -= 10;
					if(Number(temperatureTrigger.T1.text) % 1 == 0){
						temperatureTrigger.T1.text = temperatureTrigger.T1.text + ".0";
					}
				}
				if(Math.abs(Math.abs(handl.rotation) % 50) == 0){
					temperatureTrigger.T2.text = String(Math.round((Number(temperatureTrigger.T2.text) + 0.1) * 10) / 10);
					if(Number(temperatureTrigger.T2.text) % 1 == 0){
						temperatureTrigger.T2.text = temperatureTrigger.T2.text + ".0";
					}
				}
				
				if(arrow.rotation < 23 && isBounce){					
					isBounce = false;
					
					tickUp.removeEventListener(TimerEvent.TIMER, upBounce );
			
					tickDown.removeEventListener(TimerEvent.TIMER, downBounce);
				}
				if(arrow.rotation <= 30){					
					temperatureTrigger.temperatureGrowUnderPressure(7,"up");
				}
				if(arrow.rotation > 30 && arrow.rotation <= 50){					
					temperatureTrigger.temperatureGrowUnderPressure(11,"up");
				}
				if(arrow.rotation > 50 && arrow.rotation <= 77.5){					
					temperatureTrigger.temperatureGrowUnderPressure(13,"up");
				}
				if(arrow.rotation > 77.5 && arrow.rotation <= 104){					
					temperatureTrigger.temperatureGrowUnderPressure(14,"up");
				}
			}
			if(wheelRight && handl.rotation >= -135 && handl.rotation < 135){
				handl.rotation += 1.25;
				arrow.rotation += 1.25;
				
				//trace(Math.abs(arrow.rotation) - arrowPosition);
				
				if(Math.abs(Math.abs(handl.rotation) % 27.5) == 0){
					temperatureTrigger.T1.text = String(Math.round((Number(temperatureTrigger.T1.text) + 0.1) * 10) / 10);
					arrowPosition -= 10;
					if(Number(temperatureTrigger.T1.text) % 1 == 0){
						temperatureTrigger.T1.text = temperatureTrigger.T1.text + ".0";
					}
				}	
				if(Math.abs(Math.abs(handl.rotation) % 50) == 0){
					temperatureTrigger.T2.text = String(Math.round((Number(temperatureTrigger.T2.text) - 0.1) * 10) / 10);
					if(Number(temperatureTrigger.T2.text) % 1 == 0){
						temperatureTrigger.T2.text = temperatureTrigger.T2.text + ".0";
					}
				}
				
				
				if(arrow.rotation >= 25 && !isBounce){
					arrowBounce("up");
					isBounce = true;
				}
				if(arrow.rotation >= 25 && arrow.rotation < 50){					
					temperatureTrigger.temperatureGrowUnderPressure(7,"down");
				}
				if(arrow.rotation >= 50 && arrow.rotation < 77.5){					
					temperatureTrigger.temperatureGrowUnderPressure(11,"down");
				}
				if(arrow.rotation >= 77.5 && arrow.rotation < 104){					
					temperatureTrigger.temperatureGrowUnderPressure(13,"down");
				}
				if(arrow.rotation >= 104 && arrow.rotation < 130){					
					temperatureTrigger.temperatureGrowUnderPressure(14,"down");
				}
				if(arrow.rotation >= 130){					
					temperatureTrigger.temperatureGrowUnderPressure(15,"down");
				}
			}
		}
		
		var temperatureUnderPressure:Number = 0;
		
		//вращение по прокрутке колесика
		private function wheelHandl(e:MouseEvent):void{
			if(e.delta > 0 && handl.rotation >= -135 && handl.rotation < 135){
				handl.rotation += 2.5;
				arrow.rotation += 2.5;
				//trace(handl.rotation);
				
				//изменяем температуру
				if(Math.abs(Math.abs(handl.rotation) % 27.5) == 0){
					temperatureTrigger.T1.text = String(Math.round((Number(temperatureTrigger.T1.text) + 0.1) * 10) / 10);
					arrowPosition -= 10;
					if(Number(temperatureTrigger.T1.text) % 1 == 0){
						temperatureTrigger.T1.text = temperatureTrigger.T1.text + ".0";
					}
				}	
				if(Math.abs(Math.abs(handl.rotation) % 50) == 0){
					temperatureTrigger.T2.text = String(Math.round((Number(temperatureTrigger.T2.text) - 0.1) * 10) / 10);
					if(Number(temperatureTrigger.T2.text) % 1 == 0){
						temperatureTrigger.T2.text = temperatureTrigger.T2.text + ".0";
					}
				}
				if(arrow.rotation >= 25 && !isBounce){
					arrowBounce("up");
					isBounce = true;
				}
				if(arrow.rotation >= 25 && arrow.rotation < 50){					
					temperatureTrigger.temperatureGrowUnderPressure(7,"down");
				}
				if(arrow.rotation >= 50 && arrow.rotation < 77.5){					
					temperatureTrigger.temperatureGrowUnderPressure(11,"down");
				}
				if(arrow.rotation >= 77.5 && arrow.rotation < 104){					
					temperatureTrigger.temperatureGrowUnderPressure(13,"down");
				}
				if(arrow.rotation >= 104 && arrow.rotation < 130){					
					temperatureTrigger.temperatureGrowUnderPressure(14,"down");
				}
				if(arrow.rotation >= 130){					
					temperatureTrigger.temperatureGrowUnderPressure(15,"down");
				}
			}
			if(e.delta < 0 && handl.rotation <= 135 && handl.rotation > -135){
				handl.rotation -= 2.5;
				arrow.rotation -= 2.5;
				//trace(handl.rotation);
				//изменяем температуру
				if(Math.abs(Math.abs(handl.rotation) % 27.5) == 0){
					temperatureTrigger.T1.text = String(Math.round((Number(temperatureTrigger.T1.text) - 0.1) * 10) / 10);
					arrowPosition -= 10;
					if(Number(temperatureTrigger.T1.text) % 1 == 0){
						temperatureTrigger.T1.text = temperatureTrigger.T1.text + ".0";
					}
				}
				if(Math.abs(Math.abs(handl.rotation) % 50) == 0){
					temperatureTrigger.T2.text = String(Math.round((Number(temperatureTrigger.T2.text) + 0.1) * 10) / 10);
					if(Number(temperatureTrigger.T2.text) % 1 == 0){
						temperatureTrigger.T2.text = temperatureTrigger.T2.text + ".0";
					}
				}
				if(arrow.rotation < 28 && isBounce && arrow.rotation > 21){					
					isBounce = false;
					
					tickUp.removeEventListener(TimerEvent.TIMER, upBounce );
			
					tickDown.removeEventListener(TimerEvent.TIMER, downBounce);
					//temperatureTrigger.temperatureGrowUnderPressure(7,"up");
				}
				if(arrow.rotation <= 30){					
					temperatureTrigger.temperatureGrowUnderPressure(7,"up");
				}
				if(arrow.rotation > 30 && arrow.rotation <= 50){					
					temperatureTrigger.temperatureGrowUnderPressure(11,"up");
				}
				if(arrow.rotation > 50 && arrow.rotation <= 77.5){					
					temperatureTrigger.temperatureGrowUnderPressure(13,"up");
				}
				if(arrow.rotation > 77.5 && arrow.rotation <= 104){					
					temperatureTrigger.temperatureGrowUnderPressure(14,"up");
				}
				//if(arrow.rotation >= 130){					
					//temperatureTrigger.temperatureGrowUnderPressure("down",15);
				//}
			}
		}
		//получить ссылку на стрелку
		public function getArrowLink():Arrow_mc{
			return arrow;
		}
		
		//Дрожжание стрелки
		private function upBounce(e:TimerEvent):void{
			arrow.rotation += 1.5;
		}
		private function downBounce(e:TimerEvent):void{
			arrow.rotation -= 1.5;
		}
		
		private function arrowBounce(dir:String):void {	
			tickUp.start();
			tickUp.addEventListener(TimerEvent.TIMER_COMPLETE, function():void { 
					tickDown.start();					
				} );
			tickDown.addEventListener(TimerEvent.TIMER_COMPLETE, function():void { 
				tickUp.start(); 
				
				} );
				
			tickUp.addEventListener(TimerEvent.TIMER, upBounce );
			
			tickDown.addEventListener(TimerEvent.TIMER, downBounce);
			
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
			TweenLite.to(handl, 0.5, { rotation: -135 } );
			isBounce = false;
			
			tickUp.removeEventListener(TimerEvent.TIMER, upBounce );
			
			tickDown.removeEventListener(TimerEvent.TIMER, downBounce);
		}
		
		public function setTriggers(temperature:TemperatureTrigger_C){
			temperatureTrigger = temperature;
		}
	}

}