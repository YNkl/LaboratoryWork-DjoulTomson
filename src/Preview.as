package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Preview extends Sprite
	{
		private var connection:NetConnection;
		private var stream:NetStream;
		public var video:Video;
		private var videoURL:String;
		
		private var _stage:Stage;
		private var _this:*;
		
		public function Preview(_Stage:Stage) 
		{
			_stage = _Stage;
			_this = this;
			
			videoURL = "preview.flv";
			connection = new NetConnection();
			
			//connection.client = this;
			connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.connect(null);
			
			stream = new NetStream(connection);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.client = new Object();
			var video:Video = new Video();
			
			video.attachNetStream(stream);
			stream.bufferTime = 1;
			stream.receiveVideo(true);
			stream.play(videoURL);
			addChild(video);
						
			video.smoothing = true;
			stream.addEventListener(NetStatusEvent.NET_STATUS, again);
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
            switch (event.info.code) {
                case "NetStream.Play.StreamNotFound":
                    trace("Unable to locate video: " + videoURL);
                    break;
            }
        }
		
		public function again(e:NetStatusEvent):void {
			var code:String= e.info.code;
 		   	 switch(code)
            {
                case "NetStream.Buffer.Empty":
                    stream.seek(0);
					//seekToBeginning();
                    break;
			}
		}
		
		public function setActive():void {
		    this.alpha = 0;	
			_stage.addChildAt(this, 0);
			TweenLite.to(this, 1, {alpha:1 } );
		}
		public function setUnActive():void{
			TweenLite.to(this, 0.2, {alpha:0, onComplete:function():void{_stage.removeChild(_this) }} );//_stage.removeChild(this);
		}
		
		public function asyncErrorHandler(event:AsyncErrorEvent):void {
 		   trace(event.text);
		}
		
		
		
		public function onRes(Width:Number, Height:Number):void {
			this.y = 42;	
			this.height = Height - 48;
			this.width = this.height * 16 / 9;
			this.x = Width / 2 - this.width / 2;	
		}
	}

}