package 
{
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.*;
	import flash.events.MouseEvent;
	import com.greensock.easing.*;
	import flash.filters.BlurFilter;
	import flash.filters.*;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class StopWatch_C extends Stopwatch_mc
	{
		private var isPlay:Boolean = false;
		private var tweenArrow1:TweenLite;
		private var tweenArrow2:TweenLite;
		private var isOn:Boolean = false;
		
		
		public function StopWatch_C() 
		{
			
			this.height = 400;
			this.width = this.height * 0.75;
			this.buttonMask.buttonMode = true;
			this.buttonMask.addEventListener(MouseEvent.CLICK, playTimer);
			this.buttonMask.alpha = 0.5;
			this.buttonMask1.alpha = 0;
			this.buttonMask1.addEventListener(MouseEvent.CLICK, resetTimer);
			var blurFilter:BlurFilter = new BlurFilter(1.5, 1, BitmapFilterQuality.LOW);
			arr1.filters = [ blurFilter ];
			arr2.filters = [ blurFilter ];
		}
		
		
		private function playTimer(e:MouseEvent):void {
			
		
			if (!isPlay) {
				isPlay = true;	
				TweenLite.to(but, 0.5, { y: -95 } );
				//TweenLite.to(buttonMask, 0.5, { alpha:0 } );
				tweenArrow1 = TweenLite.to(arr2, 120, { rotation:720, ease:Linear.easeNone, onComplete: function():void { 
						TweenLite.to(buttonMask, 0.5, { alpha:0 });
						buttonMask.mouseEnabled = false;
						
						buttonMask1.buttonMode = true;
						buttonMask1.mouseEnabled = true;
						TweenLite.to(buttonMask1, 0.5, { alpha:0.5 } );
					} 
				});
				tweenArrow2 = TweenLite.to(arr1, 120, { rotation:14, ease:Linear.easeNone } );
				TweenLite.to(buttonMask1, 0.5, { alpha : 0 });
				buttonMask1.mouseEnabled = false;
			    //TweenLite.to(buttonMask,0.5,{scaleY:0.8});
			}
			else {
				isPlay = false;	
				//TweenLite.to(but, 0.5, { y: -95 } );
				TweenLite.to(but, 0.5, { y: -104.15 } );
				tweenArrow1.pause();
				tweenArrow2.pause();
				buttonMask1.buttonMode = true;
				buttonMask1.mouseEnabled = true;
				TweenLite.to(buttonMask1, 0.5, { alpha:0.5 } );
				//TweenLite.to(buttonMask, 0.5, { alpha:0.5 } );
				//TweenLite.to(arr1, 0.2, { rotation:0 } );
				//TweenLite.to(buttonMask, 0.5, { alpha:0 } );
				//TweenLite.to(arr2, 120, { rotation:720, ease:Linear.easeNone, onComplete:function():void{
						//TweenLite.to(but, 0.5, { y: -104.15} );
						//TweenLite.to(buttonMask, 0.5, { alpha:0.5 } );
						//TweenLite.to(arr1, 0.2, { rotation:0 } );
					//}
				//} );
				//TweenLite.to(arr1, 120, { rotation:14, ease:Linear.easeNone } );
			}
		}
		
		private function resetTimer(e:MouseEvent):void {
		buttonMask1.mouseEnabled = false;
		buttonMask1.mouseChildren = false;

		var click:TweenLite = TweenLite.to(button, 0.1, { x:203, y: -24.40, onComplete: function():void { 
				click.reverse();
				buttonMask1.mouseEnabled = true;
				buttonMask1.mouseChildren = true;
			}} );	
			if (Math.abs(arr2.rotation) > 0 || isPlay) {
				TweenLite.to(buttonMask, 0.5, { alpha:0.5 });
				buttonMask.mouseEnabled = true;
				isPlay = false;
				TweenLite.to(but, 0.5, { y: -104.15 } );
				TweenLite.to(arr2, 1, { rotation:0 } );
				TweenLite.to(arr1, 1, { rotation:0 } );
				click.play();
			}
		}
	}

}