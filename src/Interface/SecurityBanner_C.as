package Interface 
{
	import fl.text.TLFTextField;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class SecurityBanner_C extends Sprite
	{
		private var background:Sprite;
		private var secText:TextField;
		
		public function SecurityBanner_C(_Width:Number) 
		{
			//background = new Sprite();
			//background.graphics.beginFill(0xffff00, 0.9);
			//background.graphics.drawRect(0, 0, _Width, 30);
			//addChild(background);
			
			var textFormat:TextFormat = new TextFormat(null, 14, 0xff0000, "bold",null,null,null,null,"center");
			
			
			secText = new TextField();
			
			secText.autoSize = TextFieldAutoSize.CENTER;
			// if it should not be singleline then add this aswell
			secText.wordWrap = true;
			secText.multiline = true;
			secText.background = true;
			secText.backgroundColor = 0xFFFF00;
			//secText.multiline = true;
			//secText.wordWrap = true;
			////secText.autoSize = TextFieldAutoSize.LEFT;
			////secText.height = 20;
			secText.width = _Width;
			secText.text = "Использование этой программы в данном контексте не санкционировано правообладателем (ФГБОУ ВПО НИ ТПУ) и является нарушением ст. 1229 Гражданского кодекса РФ.";
			secText.setTextFormat(textFormat);
			//secText.mouseEnabled = false;
			//secText.mouseChildren = false;
			//secText.y = 7;
			//
			//background.height = secText.numLines * 30;
			
			addChild(secText);
		}
		
		public function onRes(_Width:Number):void{
			//background.width = _Width;
			secText.width = _Width;
			secText.x = _Width / 2 - secText.width / 2;
			//background.height = secText.numLines * 30;
		}
		
	}

}