package Interface._scrollBar 
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Nikolaev Yuriy
	 */
	public class ScrollBar_C extends ScrollBar
	{
		private var st:Stage;
		private var isHide:Boolean = false;
		private var pageNumber:Number = 1;
		private var scrollStep:Number;
		private var pagesStep:Number;
		private var materialsPageNumber:Number = 2;
		
		private var pageNumberTxt:TextField;
		
		public function ScrollBar_C(_stage:Stage) 
		{
			st = _stage;
			
			this.x = 0;
			this.y = 48;
			this.scrollBarHead.width = 541;
			this.scrollBarHead.height = 36;
			this.program.gotoAndStop(1);
			this.materials.gotoAndStop(2);
			this.instructions.gotoAndStop(2);
			
			//поле с номером страницы
			pageNumberTxt = new TextField();
			pageNumberTxt.defaultTextFormat = new TextFormat("Arial", 25, 0xffffff,true);
			pageNumberTxt.x = 420;
			pageNumberTxt.y = 1;
			pageNumberTxt.mouseEnabled = false;
			pageNumberTxt.alpha = 0;
			pageNumberTxt.height = 36;
			pageNumberTxt.text = "1 / 4";
			addChild(pageNumberTxt);
			
			//кнопка следующей страницы
			this.txtNext.gotoAndStop(1);
			this.txtNext.width = 30;
			this.txtNext.height = 36;
			this.txtNext.x = 473;
			this.txtNext.alpha = 0;
			this.txtNext.buttonMode = false;
			this.txtNext.mouseEnabled = false;
			this.txtNext.mouseChildren = false;
			this.txtNext.addEventListener(MouseEvent.CLICK, function():void{
				if (materialsPageNumber < 5){
					materialsPageNumber += 1;
					pageNumberTxt.text = String(materialsPageNumber - 1) + " / 4";
					changePage(materialsPageNumber);
					if(materialsPageNumber == 5){
						TweenLite.to(txtNext, 0.5, { alpha:0 } )
						txtNext.buttonMode = false;	
					}
					if(materialsPageNumber > 2){
						TweenLite.to(txtPrev, 0.5, { alpha:1 } )
						txtPrev.buttonMode = true;	
					}
				}
				
			});
			//кнопка следующей страницы
			this.txtPrev.gotoAndStop(1);
			this.txtPrev.width = 30;
			this.txtPrev.height = 36;
			this.txtPrev.x = 387;
			this.txtPrev.alpha = 0;
			this.txtPrev.buttonMode = false;
			this.txtPrev.addEventListener(MouseEvent.CLICK, function():void{
				if (materialsPageNumber > 2){
					materialsPageNumber -= 1;
					pageNumberTxt.text = String(materialsPageNumber - 1) + " / 4";
					changePage(materialsPageNumber);
					if(materialsPageNumber < 5){
						TweenLite.to(txtNext, 0.5, { alpha:1 } )
						txtNext.buttonMode = true;	
					}
					if(materialsPageNumber == 2){
						TweenLite.to(txtPrev, 0.5, { alpha:0 } )
						txtPrev.buttonMode = false;	
					}
				}
				
			});
			//рамка справа
			this.border.width = 1;
			this.border.x = 540;
			this.border.y = 36;
			this.border.height = st.stageHeight;
			//кнопка скрытия панели
			this.hideBut.buttonMode = true;
			this.hideBut.addEventListener(MouseEvent.CLICK, hide);
			this.hideBut.y = 17;
			this.hideBut.x = 523;
			this.hideBut.width = 35;
			this.hideBut.height = 38;
			//кнопка программа
			this.program.height = 36;		
			this.program.width = 125;
			this.program.x = 12;
			this.program.buttonMode = true;
			this.program.addEventListener(MouseEvent.CLICK, function():void {
				program.gotoAndStop(1);
				materials.gotoAndStop(2);
				instructions.gotoAndStop(2);
				TweenLite.to(txtNext, 1, { alpha:0 } );	
				TweenLite.to(txtPrev, 1, { alpha:0 } );
				TweenLite.to(pageNumberTxt, 1, { alpha:0} );
				txtNext.buttonMode = false;
				txtPrev.buttonMode = false;
				txtNext.mouseEnabled = false;
				txtPrev.mouseEnabled = false;
				pageNumber = 1;
				changePage(pageNumber);
			});
			//кнопка материалы
			this.materials.height = 36;		
			this.materials.width = 125;
			this.materials.x = 262;
			this.materials.buttonMode = true;
			//this.txtNext.mouseEnabled = true;
			//this.txtNext.mouseChildren = true;
			this.materials.addEventListener(MouseEvent.CLICK, function():void {
				program.gotoAndStop(2);
				materials.gotoAndStop(1);
				instructions.gotoAndStop(2);
				//TweenLite.to(txtNext, 1, { alpha:1 } );
				if(materialsPageNumber < 5){
					TweenLite.to(txtNext, 1, { alpha:1 } );
				}
				if(materialsPageNumber != 2){
					TweenLite.to(txtPrev, 1, { alpha:1 } );
				}
				TweenLite.to(pageNumberTxt, 1, { alpha:1} );
				txtNext.buttonMode = true;
				txtPrev.buttonMode = true;
				txtNext.mouseEnabled = true;
				txtPrev.mouseEnabled = true;
				//pageNumber = 2;
				changePage(materialsPageNumber);
			});			
			//кнопка указания
			this.instructions.height = 36;		
			this.instructions.width = 125;
			this.instructions.x = 137;
			this.instructions.buttonMode = true;
			this.instructions.addEventListener(MouseEvent.CLICK, function():void {
				program.gotoAndStop(2);
				materials.gotoAndStop(2);
				instructions.gotoAndStop(1);
				TweenLite.to(txtNext, 1, { alpha:0 } );	
				TweenLite.to(txtPrev, 1, { alpha:0 } );
				TweenLite.to(pageNumberTxt, 1, { alpha:0} );
				txtNext.buttonMode = false;
				txtPrev.buttonMode = false;
				txtNext.mouseEnabled = false;
				txtPrev.mouseEnabled = false;
				pageNumber = 6;
				changePage(pageNumber);
			});
			//фон
			this.bg.x = 0;
			this.bg.alpha = 0.9;
			this.bg.width = 540;
			this.bg.height = st.stageHeight;
			//страница Программа
			this.pages.gotoAndStop(1);
			this.pages.alpha = 1;
			this.pages.y = 0;
			this.pages.x = -8;
			this.pages.addEventListener(MouseEvent.MOUSE_WHEEL, wheelText);
			//страница Материалы
			
			//страница Указания
			
			//скролл
			this.scrollBG.alpha = 0;
			this.scrollBG.width = 20;
			this.Scroll.alpha = 0;
			this.Scroll.width = 20;
			this.Scroll.buttonMode = true;
			this.Scroll.y = 36;
			this.Scroll.addEventListener(MouseEvent.MOUSE_WHEEL, wheelText);
			this.Scroll.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			
			st.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onDown(e:MouseEvent):void {
			var bounds:Rectangle = new Rectangle(this.pages.width - Scroll.width, 36, 0, stage.stageHeight - Scroll.height - 78); 					
			Scroll.startDrag(false, bounds);	
			stage.addEventListener(MouseEvent.MOUSE_MOVE, moveTxt);
		}
		
		private function onUp(e:MouseEvent):void{
			Scroll.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveTxt);
		}
		var currYScroll:Number;
		
		private function moveTxt(e:MouseEvent):void{
			//trace(Scroll.y - 30);
			//посчитать сколько процентов прошел скролл
			currYScroll = Math.round(Scroll.y - 36) * 100 / Math.round(scrollBG.height - Scroll.height);
			pages.y = - (pages.height - scrollBG.height) / 100 * currYScroll;
			//trace(currYScroll = (((scrollBG.height - Scroll.height) / 100) * (Scroll.y - 30) ));
		}
		private function wheelText(e:MouseEvent):void{
			if(e.delta > 0 && (scrollBG.height / this.pages.height <= 1)){
				
				if (Scroll.y <= 36) Scroll.y = 36;
				else{
					Scroll.y -= scrollStep;
					this.pages.y += pagesStep;
				}
			}
			if(e.delta < 0 && (scrollBG.height / this.pages.height <= 1)){
				//!!!! ошибка!!!
				if (Scroll.y + Scroll.height + 1 >= stage.stageHeight - 48){
					Scroll.y = stage.stageHeight - Scroll.height - 48;
				}
				else{
					this.pages.y -= pagesStep;
					Scroll.y += scrollStep;
				}
			}
		}
		
		private function changePage(_pageNumber:Number):void{
			this.pages.gotoAndStop(_pageNumber);
			pages.y = 0;
			Scroll.y = 36;
		}
		
		//скрываем панель
		private function hide(e:MouseEvent):void
		{
			if (isHide)
			{
				hideBut.rotation = 0;
				TweenLite.to(this, 1, { x:0, y:48 } );
				TweenLite.to(this.hideBut, 1, { x:523} );
				isHide = !isHide;
			}
			else
			{
				hideBut.rotation = -180;
				TweenLite.to(this, 1, { x: -541, y:48 } );
				TweenLite.to(this.hideBut, 1, { x:555 } );
				isHide = !isHide;
			}			
		}
		
		public function onRes(_height:Number):void
		{
			this.border.height = _height;
			this.bg.height = st.stageHeight;
			
			//отрисовываем скролл если не влазит текст
			if(pages.height > stage.stageHeight - 84){
				TweenLite.to(scrollBG, 0.5, { alpha:1 } );
				TweenLite.to(Scroll, 0.5, { alpha:1 } );
				
				scrollBG.y = 36;
				scrollBG.x = pages.width - scrollBG.width;
				Scroll.x = pages.width - Scroll.width;
				scrollBG.height = stage.stageHeight - 84;
				this.Scroll.buttonMode = true;
				Scroll.height = scrollBG.height - (pages.height - scrollBG.height);
			}
			else{
				TweenLite.to(scrollBG, 1, { alpha:0 } );
				TweenLite.to(Scroll, 1, { alpha:0 } );
				this.Scroll.buttonMode = false;
			}
			scrollStep = (pages.height - scrollBG.height) * 0.1;
			pagesStep = (pages.height - scrollBG.height) * 0.1;
		}
	}

}