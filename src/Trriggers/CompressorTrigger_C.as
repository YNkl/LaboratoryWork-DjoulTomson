package Trriggers 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class CompressorTrigger_C extends But1_mc
	{
		public var isActive:Boolean = false;
		private var isOn:Boolean = false;
		private var butMask:Sprite;
		private var compressorHandl:CompressorHandler_C;
		private var webTrigger:WebTrigger_C;
		private var temperatureTrigger:TemperatureTrigger_C;
		
		public function CompressorTrigger_C() 
		{
			gotoAndStop(1);
			
			butMask = new Sprite();
			butMask.graphics.beginFill(0x00ff00, 0.3);
			butMask.graphics.drawRoundRect(0, 0, this.width, this.height, 10, 10);
			butMask.buttonMode = true;
			butMask.addEventListener(MouseEvent.MOUSE_OVER, function():void { TweenLite.to(butMask,0.2,{alpha:0} ); } );
			butMask.addEventListener(MouseEvent.MOUSE_OUT, function():void { TweenLite.to(butMask, 0.2, { alpha:1 } ); } );
			butMask.addEventListener(MouseEvent.CLICK, turnCurrent);
			addChild(butMask);
			
			setUnActive();
		}
		
		public function turnCurrent(e:MouseEvent):void{
			if(!isOn){
				isOn = true;
				compressorHandl.setActive();
				webTrigger.setUnActive();
				temperatureTrigger.setUnActive();
				gotoAndStop(2);
			}
			else{
				isOn = false;
				compressorHandl.setUnActive();
				temperatureTrigger.setActive();
				TweenLite.to(compressorHandl.getArrowLink(), 1, { rotation: -135 } );
				webTrigger.setActive();
				gotoAndStop(1);
			}
		}
		
		public function get isOnCompressor():Boolean{
			return isOn;
		}
		
		public function set isOnTrigger(value:Boolean):void{
			isOn = value;
		}
		
		public function setCompressorHandler(value:CompressorHandler_C, temperature:TemperatureTrigger_C):void{
			compressorHandl = value;
			temperatureTrigger = temperature;
		}
		
		public function setWebTrigger(value:WebTrigger_C):void{
			webTrigger = value;
		}
		
		
		public function setActive():void {
			isActive = true;
			addChild(butMask);	
			TweenLite.to(butMask, 0.5, { alpha:1 } );			
		}
		
		public function setUnActive():void {
			isActive = false;
			TweenLite.to(butMask, 0.5, { alpha:0, onComplete:function():void { removeChild(butMask); }} );
		}
	}

}