package Trriggers 
{
	import fl.text.AuthTLFTextField;
	import fl.text.TLFTextField;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class TemperatureTrigger_C extends Sprite
	{
		private var trigger:Trigger_mc;
		private var triggerMask:Sprite;
		private var isOn:Boolean = false;
		public var T1:TLFTextField;
		public var T2:TLFTextField;
		
		private var compressorTrigger:CompressorTrigger_C;
		private var webTrigger:WebTrigger_C;
		
		//таймеры роста температуры на входе
		private var tickUp:Timer = new Timer(10000,1);
		private var tickDown:Timer = new Timer(10000, 1);
		//готова ли установка для работы (установлены ли температуры)
		private var isReady:Boolean = false;
		
		private var zoomedTemperature:zoomedTemperature_mc;
		private var numTemperature:Number;
		
		public function TemperatureTrigger_C(t1:TLFTextField, t2:TLFTextField, zmdTemperature:zoomedTemperature_mc ) 
		{
			T1 = t1;
			T2 = t2;
			
			
			
			zoomedTemperature = zmdTemperature;
			numTemperature = Math.round((24.7 + (26.1 - 24.7) * Math.random())*10)/10;
			T1.text = String(numTemperature);
			trace(numTemperature);
			
			trigger = new Trigger_mc();
			trigger.gotoAndStop(1);
			addChild(trigger);
			
			triggerMask = new Sprite();
			triggerMask.graphics.beginFill(0x00ff00, 0.3);
			triggerMask.graphics.drawEllipse( -2, -3, trigger.width + 2, trigger.height + 2);
			triggerMask.buttonMode = true;
			triggerMask.addEventListener(MouseEvent.MOUSE_OVER, function():void { TweenLite.to(triggerMask,0.2,{alpha:0} ); } );
			triggerMask.addEventListener(MouseEvent.MOUSE_OUT, function():void { TweenLite.to(triggerMask, 0.2, { alpha:1 } ); } );
			triggerMask.addEventListener(MouseEvent.CLICK, turn);
			addChild(triggerMask);
			
			//дребезг температуры на входе дросселя
			tickUp.start();
			tickUp.addEventListener(TimerEvent.TIMER_COMPLETE, function():void { 
					tickDown.start();					
				} );
			tickDown.addEventListener(TimerEvent.TIMER_COMPLETE, function():void { 
				tickUp.start() 
				
				} );
				
			tickUp.addEventListener(TimerEvent.TIMER, function():void { 
				T1.text = String((Math.round((Number(T1.text) + (1 + Math.random() * 1) / 10) * 10) / 10).toFixed(1));
				TweenLite.to(this, 2, { onComplete: function():void { T2.text = String((Math.round((Number(T2.text) + 0.1) * 10) / 10).toFixed(1) ) }} )
				
				//if(Number(T1.text) % 1 == 0){
					//T1.text = T1.text + ".0";
				//}				
				//if(Number(T2.text) % 1 == 0){
					//T2.text = T2.text + ".0";
				//}
			} );
			
			tickDown.addEventListener(TimerEvent.TIMER,function():void{
				T1.text = String((Math.round((Number(T1.text) - (1 + Math.random() * 1) / 10) * 10) / 10).toFixed(1));
				TweenLite.to(this, 2, { onComplete: function():void { T2.text = String((Math.round((Number(T2.text) - 0.1) * 10) / 10).toFixed(1) ) }} )
				
				//if(Number(T1.text) % 1 == 0){
					//T1.text = T1.text + ".0";
				//}
				//if(Number(T2.text) % 1 == 0){
					//T2.text = T2.text + ".0";
				//}
			} );
			
			//рост температуры на выходе дросселя в начале работы
				upTemperature();
			
			//выключаем тумблер вначале
			setUnActive();
		}
		
		//рост температуры под давлением
		
		var growTimer:Timer;
		
		public function temperatureGrowUnderPressure(steps:Number, _upOrDown:String):void {
			if(growTimer){
				growTimer.stop();
				growTimer = null;
			}
			var curTemp:Number = Number(T2.text);
			var numTemp:Number = numTemperature - 0.1 * steps;
			var timerSteps:Number = Math.abs(numTemp - curTemp) / 0.1;
			trace(timerSteps);
			var upOrdown:String;
			
			if ((curTemp - numTemp) > 0) {
				//trace(curTemp - numTemp);
				upOrdown = "down";
				trace(2222);
			}
			if ((curTemp - numTemp) < 0) {
			trace(curTemp - numTemp);	
				upOrdown = "up";
				trace(11111111);
			}
			growTimer = new Timer(Math.round(120000 / timerSteps));
			growTimer.addEventListener(TimerEvent.TIMER, function():void { 
				if (upOrdown == "down") {
				
					//parent.addChild(new StopWatch_C());	
					curTemp -= 0.1; 
					T2.text = String(Math.round((curTemp * 10)) / 10);
					
					if(Number(T2.text) % 1 == 0){
						T2.text = T2.text + ".0";
					}
					
					trace(curTemp);
					trace(numTemp);
					
					if(curTemp <= numTemp)
						growTimer.stop();
				}
				if(upOrdown == "up"){
					curTemp += 0.1; 
					T2.text = String(Math.round((curTemp * 10)) / 10);
					
					if(Number(T2.text) % 1 == 0){
						T2.text = T2.text + ".0";
					}
					
					//trace(curTemp);
					//trace(numTemp);
					
					if(curTemp >= numTemp)
						growTimer.stop();
				}
				}
				);
			
			growTimer.start();
		}
		
		//рост температуры
		private function upTemperature():void{
			var upTemp:Timer = new Timer(3000, 1);
			
			upTemp.addEventListener(TimerEvent.TIMER, function():void { 
				T2.text = String(Math.round((Number(T2.text) + 0.1) *10) / 10); 
				if(Number(T2.text) % 1 == 0){
					T2.text = T2.text + ".0";
				}
			} );
			
			upTemp.addEventListener(TimerEvent.TIMER_COMPLETE, function():void {
				if(Math.round(Number(T2.text)*10)/10 < Number(T1.text)){
					//T2.text = String(Number(T2.text) + 0.1);
					upTemperature();
				}
				else {
					isReady = true;
					upTemp.stop();
					if(!compressorTrigger.isOnCompressor && webTrigger.isOnWeb && isOn){
						compressorTrigger.setActive();
					}
				}
			} );
			
			upTemp.start();
		}
		
		public function get isReadyToMeasure():Boolean{
			return isReady;
		}		
		
		public function turn(e:MouseEvent):void { 
			if (!isOn) {
				isOn = true;
				trigger.gotoAndStop(2);
				TweenLite.to(T1, 1, { alpha:0.7 } );
				TweenLite.to(T2, 1, { alpha:0.7 } );
				if(isReady){
					compressorTrigger.setActive();
				}
				TweenLite.to(zoomedTemperature, 1, { alpha:1 } );
				//compressorTrigger.setActive();				
			}
			else {
				isOn = false;
				trigger.gotoAndStop(1);
				TweenLite.to(T1, 1, { alpha:0 } );
				TweenLite.to(T2, 1, { alpha:0 } );
				TweenLite.to(zoomedTemperature, 1, { alpha:0 } );
				if(compressorTrigger.isActive)
					compressorTrigger.setUnActive();
			}
		}
		
		public function setActive():void {
			addChild(triggerMask);	
			TweenLite.to(triggerMask, 0.5, { alpha:1 } );			
		}
		
		public function setUnActive():void{
			TweenLite.to(triggerMask, 0.5, { alpha:0, onComplete:function():void { removeChild(triggerMask); }} );
		}
		
		public function setTriggers(compressor:CompressorTrigger_C,web:WebTrigger_C):void{
			compressorTrigger = compressor;
			webTrigger = web;
		}
		
		public function get isOnTemperature():Boolean{
			return isOn;
		}
	}

}