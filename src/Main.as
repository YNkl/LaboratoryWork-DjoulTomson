package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Interface._scrollBar.ScrollBar_C;
	import Interface.ExitQuestion_C;
	import Interface.MainBanner;
	import Interface.PhazesInfo;
	import Interface.SecurityBanner_C;
	import flash.external.ExternalInterface;
	import flash.display.LoaderInfo;

	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var _this:*;
		private var preview:Preview;
		private var mainBan:MainBanner;
		private var phazesInfo:PhazesInfo;
		private var exitQuestion:ExitQuestion_C;
		private var scrollBar:ScrollBar_C;
		private var stages:Array = new Array();
		
		private var stageOne:StageOne_C;
		private var securityBanner:SecurityBanner_C;

		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_this = this;
			stage.addEventListener(Event.RESIZE, onResStage);
			// entry point
			
			//ИНТЕРФЕЙС//	
			//кнопка выхода
			exitQuestion = new ExitQuestion_C(stage.stageWidth, stage.stageHeight, _this);
			//рисуем баннер
			mainBan = new MainBanner(stage.stageWidth, stage.stageHeight);
			addChild(mainBan);	
			//рисуем информацию о сценах и кнопки переключения
			phazesInfo = new PhazesInfo(stage.stageWidth, stage.stageHeight, _this, exitQuestion);
			addChildAt(phazesInfo,0);			
			//рисуем скроллбар
			scrollBar = new ScrollBar_C(stage);	
			scrollBar.alpha = 1;
			addChildAt(scrollBar, 1);
			
			//превью
			preview = new Preview(stage);
			stages[0] = preview;
			preview.setActive();
			
			
			//СЦЕНА//
			stageOne = new StageOne_C(stage);
			stages[1] = stageOne;
			//addChildAt(stageOne,0);
			
			
			//устанавливаем сцены на кнопки переключения
			phazesInfo.setStages(stages);
			exitQuestion.phazes = phazesInfo;
			
			//проверяем откуда запущен
			//var myUrl:String = unescape(LoaderInfo(this.root.loaderInfo).url);
			//if (myUrl.search("tpu.ru") == -1) {
				//securityBanner = new SecurityBanner_C(stage.stageWidth);
				//securityBanner.y = 48;
				//addChildAt(securityBanner, 3);
			//}
			//
			//перерисовываем
			onResStage(null);
		}

		
		
		public function onResStage(e:Event):void{
			mainBan.onRes(stage.stageWidth, stage.stageHeight);
			phazesInfo.onRes(stage.stageWidth, stage.stageHeight);
			scrollBar.onRes(stage.stageHeight);
			exitQuestion.onRes(stage.stageWidth, stage.stageHeight);
			
			//resize stages
			stageOne.onRes(stage.stageWidth, stage.stageHeight);
			preview.onRes(stage.stageWidth, stage.stageHeight);
			
			if(securityBanner){
				securityBanner.onRes(stage.stageWidth);
			}
			//afterFirst.onRes(stage.stageWidth, stage.stageHeight);
			//afterSec.onRes(stage.stageWidth, stage.stageHeight);
			//afterThird.onRes(stage.stageWidth, stage.stageHeight);
			//afterFourth.onRes(stage.stageWidth, stage.stageHeight);
			//afterFifth.onRes(stage.stageWidth, stage.stageHeight);
		}
		
		public function reboot():void {
			
			//рисуем информацию о сценах и кнопки переключения
			removeChild(phazesInfo);
			phazesInfo = null;
			phazesInfo = new PhazesInfo(stage.stageWidth, stage.stageHeight, _this, exitQuestion);
			addChild(phazesInfo);
			//первая сцена
			stageOne = null;
			stageOne = new StageOne_C(stage);			
			//addChildAt(stageOne, 1);
			stages[1] = stageOne;
			//stageOne.setUnActive();
			
			phazesInfo.setStages(stages);
			exitQuestion.phazes = phazesInfo;
			////перерисовка
			onResStage(null);
		}
	}

}