package Trriggers 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class WebTrigger_C extends But2_mc
	{
		private var isOn:Boolean = false;
		private var butMask:Sprite;
		private var compressorTrigger:CompressorTrigger_C;
		private var temperatureTrigger:TemperatureTrigger_C;
		
		private var _this:*;
		
		public function WebTrigger_C() 
		{
			_this = this;
			gotoAndStop(1);
			
			butMask = new Sprite();
			butMask.graphics.beginFill(0x00ff00, 0.3);
			butMask.graphics.drawRoundRect(0, 0, this.width, this.height, 10, 10);
			butMask.buttonMode = true;
			butMask.addEventListener(MouseEvent.MOUSE_OVER, function():void { TweenLite.to(butMask,0.2,{alpha:0} ); } );
			butMask.addEventListener(MouseEvent.MOUSE_OUT, function():void { TweenLite.to(butMask, 0.2, { alpha:1 } ); } );
			butMask.addEventListener(MouseEvent.CLICK, turnCurrent);
			addChild(butMask);
		}
		
		private function turnCurrent(e:MouseEvent):void{
			if(!isOn){
				isOn = true;
				gotoAndStop(2);
				//if(temperatureTrigger.isReadyToMeasure){
					//compressorTrigger.setActive();
				//}
				temperatureTrigger.setActive();
			}
			else{
				isOn = false;
				gotoAndStop(1);
				//compressorTrigger.setUnActive();
				if(temperatureTrigger.isOnTemperature)
					temperatureTrigger.turn(null);
				temperatureTrigger.setUnActive();				
			}
		}
		
		
		public function get isOnWeb():Boolean{
			return isOn;
		}
		
		public function set isOnWeb(value:Boolean):void{
			isOn = value;
		}
		
		public function setTriggers(compressor:CompressorTrigger_C, temperature:TemperatureTrigger_C):void{
			compressorTrigger = compressor;
			temperatureTrigger = temperature
		}
		
		public function setActive():void {
			_this.addChild(butMask);	
			TweenLite.to(butMask, 0.5, { alpha:1 } );			
		}
		
		public function setUnActive():void{
			TweenLite.to(butMask, 0.5, { alpha:0, onComplete:function():void { _this.removeChild(butMask); }} );
		}
	}

}