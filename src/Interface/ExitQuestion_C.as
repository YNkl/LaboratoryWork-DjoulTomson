package Interface 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class ExitQuestion_C extends Sprite
	{
		public var bg:Sprite;
		private var question:ExitQuestion_mc;
		private var stg:*;
		private var _this:*;
		public var phazes:PhazesInfo;
		public var isExit:Boolean = false;
		
		public function ExitQuestion_C(_width:Number, _height:Number, _st:*) 
		{
			_this = this;
			stg = _st;
			bg = new Sprite();
			bg.graphics.beginFill(0xcccccc, 0.6);
			bg.graphics.drawRect(0,0,_width,_height);
			bg.graphics.endFill();
			addChild(bg);
			
			question = new ExitQuestion_mc();
			question.yesBut.buttonMode = true;
			question.noBut.buttonMode = true;
			addChild(question);
			
			question.yesBut.addEventListener(MouseEvent.CLICK, function():void { 
				isExit = true;
				phazes.reboot();
				phazes.currStage = 0;
				stg.reboot();
				//TweenLite.to(this, 0.5, { alpha:0, onComplete:function():void { parent.removeChild(_this) }} );//_stage.removeChild(this);
				parent.removeChild(_this)
			} );
			question.noBut.addEventListener(MouseEvent.CLICK, function():void { parent.removeChild(_this ); } );
		}
		
		public function onRes(_width:Number, _height:Number):void{
			bg.width = _width;
			bg.height = _height;
			bg.x = 0;
			bg.y = 0;
			question.x = _width / 2 - question.width / 2;
			question.y = _height / 2 - question.height / 2;
		}
	}

}