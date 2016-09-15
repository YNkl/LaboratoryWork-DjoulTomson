package 
{
	import fl.text.TLFTextField;
	import flash.display.Stage;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import com.greensock.TweenLite;
	import Trriggers.CompressorHandler_C;
	import Trriggers.CompressorHandlerSequence_C;
	import Trriggers.CompressorTrigger_C;
	import Trriggers.TemperatureTrigger_C;
	import Trriggers.WebTrigger_C;
	import flash.utils.setInterval;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class MainMachine_C extends MainMachine_mc
	{
		private var T1:TLFTextField;
		private var T2:TLFTextField;
		private var T1sub:TLFTextField;
		private var T2sub:TLFTextField;
		private var textFormat:TextFormat;
		private var textFormat1:TextFormat;
		
		
		
		public function MainMachine_C(stage:Stage) 
		{
			textFormat = new TextFormat("a_LCDNova", 24, 0xff0000, true);
			textFormat1 = new TextFormat("a_LCDNova", 19, 0x00aaff, true);
			
			var textFormatsub = new TextFormat("a_LCDNova", 54, 0xff0000, true);
			var textFormat1sub = new TextFormat("a_LCDNova",38, 0x00aaff, true);
			
			//температура 1
			T1 = new TLFTextField();
			T1.setTextFormat(textFormat);
			T1.alpha = 0;
			T1.y = 180;
			T1.x = 90;
			T1.autoSize = TextFieldAutoSize.RIGHT;
			T1.height = 130;
			T1.text = "25.0";
			addChild(T1);
			
			T1sub = new TLFTextField();
			T1sub.setTextFormat(textFormatsub);
			T1sub.alpha = 0;
			T1sub.y = 97;
			T1sub.x = -270;
			T1sub.autoSize = TextFieldAutoSize.RIGHT;
			T1sub.height = 130;
			T1sub.text = "25.0";
			addChild(T1sub);
			
			//температура 2
			T2 = new TLFTextField();
			T2.setTextFormat(textFormat1);
			T2.alpha = 0;
			T2.y = 210;
			T2.x = 73;
			T2.autoSize = TextFieldAutoSize.RIGHT;
			T2.height = 130;
			T2.text = "24.5";
			addChild(T2);
			
			T2sub = new TLFTextField();
			T2sub.setTextFormat(textFormat1sub);
			T2sub.alpha = 0;
			T2sub.y = 167;
			T2sub.x = -305;
			T2sub.autoSize = TextFieldAutoSize.RIGHT;
			T2sub.height = 110;
			T2sub.text = "24.5";
			addChild(T2sub);
			
			zoomedTemperature.alpha = 0;
			////включатель
			//this.trigger.gotoAndStop(1);
			//this.trigger.buttonMode = true;
			//this.trigger.addEventListener(MouseEvent.CLICK, function():void { 
				////trace((this.but1.currentFrame).toString() );
				//if(trigger.currentFrame == 1){
					//trigger.gotoAndStop(2);
					//TweenLite.to(T1, 1, { alpha:0.9 } );
				//}
				//else{
					//trigger.gotoAndStop(1);
					//TweenLite.to(T1, 1, { alpha:0 } );
				//}
			//} );
			//removeChild(trigger);
			
			
			var temperatureTrigger:TemperatureTrigger_C = new TemperatureTrigger_C(T1,T2,zoomedTemperature);
			temperatureTrigger.x = 272;
			temperatureTrigger.y = 207;
			addChild(temperatureTrigger);
			
			//регулировка компрессора			
			var compressorHandl:CompressorHandler_C = new CompressorHandler_C(this.arrow,stage);
			compressorHandl.y = 791;
			compressorHandl.x = 179;
			addChild(compressorHandl);
			
			//стрелка
			this.arrow.rotation = -135;
			
			//кнопка включения компрессора
			var compressorTrigger:CompressorTrigger_C = new CompressorTrigger_C();
			compressorTrigger.y = 949.3;
			compressorTrigger.x = 249;			
			addChild(compressorTrigger);
			
			//кнопка включения сети
			var webTrigger:WebTrigger_C = new WebTrigger_C();
			webTrigger.y = 949.3;
			webTrigger.x = 73;
			addChild(webTrigger);	
			
			//обмениваем кнопки между собой
			compressorTrigger.setWebTrigger(webTrigger);
			compressorTrigger.setCompressorHandler(compressorHandl,temperatureTrigger);
			temperatureTrigger.setTriggers(compressorTrigger,webTrigger);
			webTrigger.setTriggers(compressorTrigger, temperatureTrigger);
			compressorHandl.setTriggers(temperatureTrigger);
			
			setInterval(synchTemp, 100);
		}
		
		private function synchTemp():void{
			T1sub.text = T1.text;
			T2sub.text = T2.text;
			
			T1sub.alpha = T1.alpha;
			T2sub.alpha = T2.alpha;
		}
		
	}

}