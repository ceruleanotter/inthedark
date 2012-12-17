package
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.IBitmapDrawable;
	import mx.graphics.codec.JPEGEncoder;
	import flash.net.FileReference;
	import flash.geom.Matrix
	import flash.utils.ByteArray
	public class DarkWorld extends World
	{
		public static var _girl:Girl;
		public static var _curGhosts:Array;
		public static var _darkness:Darkness;
		private static var _curLetterPos:int;
		private static var _visibleGhosts:Array;
		private static var _ghostNum:Number = 4;
		private static var _ghostInc:Boolean = false;
		public static var _score:Score;
		public static var _timePlayed:Number;
		public function DarkWorld()
		{
			
			DarkWorld._girl = new Girl();
			DarkWorld._girl.x = GameConstants.WORLD_WIDTH/2;
			DarkWorld._girl.y = GameConstants.WORLD_HEIGHT /2;
			add(DarkWorld._girl);
			FP.screen.color = 0xEBD85B;
			_timePlayed = 0;
			

			
			for (var i:int = 1; i <= _ghostNum; i++) {
				add(new Ghost(this));
			}
			
			add(new KeyChecker(this));
			DarkWorld._curGhosts = new Array();
			DarkWorld._curLetterPos = 0;
			
			_darkness = new Darkness;
			add(_darkness);
			_visibleGhosts = [];
			_score = new Score;
			add(_score);
		}
		
		
		public function snapPic():void {
			
			/*	var bitmapData:BitmapData = FP.buffer;//new BitmapData(GameConstants.WORLD_WIDTH, GameConstants.WORLD_HEIGHT);
				//bitmapData.draw(this,new Matrix());
				var bitmap:Bitmap = new Bitmap(bitmapData);
				var jpg:JPEGEncoder = new JPEGEncoder();
				var ba:ByteArray = jpg.encode(bitmapData);
				var f:FileReference = new FileReference();
				f.save(ba,null);*/
		}
		
		
		override public function update():void {
			super.update();
			var ghosts:Array = [];
			FP.world.getClass(Ghost, ghosts);
			if (_ghostNum > ghosts.length) this.add(new Ghost(this));
			
			_timePlayed += FP.elapsed;
			if (_timePlayed > 20 && _ghostInc) {
				_ghostNum++
				_timePlayed = 0;
				trace ("increasing number of ghosts");
				_ghostInc = ! _ghostInc;
			}
			else if (_timePlayed > 20) {
				_timePlayed = 0;
				Ghost._max_speed += 5;
				trace("increasing speed of ghosts");
				_ghostInc = !_ghostInc;
			}

		}
		
		/**
		 * Looking at the key just pressed, so what to do to the ghosts.
		 */
		public function checkKeyGhosts(keyPressed:String):void {
			trace("passing " + keyPressed);
			//remove the ghosts which are not visible
			var temp:Array = new Array();
			for each (var g:Ghost in _curGhosts) {
				if (_visibleGhosts.indexOf(g) != -1) {
					temp.push(g)
				}	
			}
			_curGhosts = temp;
			if(_curGhosts.length == 0) _curLetterPos = 0;
			
			//if there are ghosts to check...
			if (_curLetterPos != 0) {
				var kept:Array = new Array();
				for each (var gh:Ghost in _curGhosts) {

					switch (gh.checkKey(keyPressed,DarkWorld._curLetterPos))
					{
						case Ghost.K_WRONG: 
							//REMOVE THE GHOST
							break;

						case Ghost.K_CORRECT: 
							//KEEP THE GHOST
							kept.push(gh);

							break;
						case Ghost.K_DEAD:
							gh.die();
							//REMOVE THE GHOST
							break;

						default: 
							trace("ERROR: This wasn't supposed to happen in checkKeyGhosts");
							break; 
					}
				}
				_curGhosts = kept;
				if (_curGhosts.length == 0) {
					_curLetterPos = 0;
				} else {
					_curLetterPos++;
				}
				//do we still have ghosts?
				//if so, they must be correct, and advance the letter
				//if not, then the letter should go to zero
			} else {			
				var ghosts:Array = [];
				for each (var gho:Ghost in _visibleGhosts) {
					if (gho.checkKey(keyPressed, DarkWorld._curLetterPos) == Ghost.K_CORRECT) {
						DarkWorld._curGhosts.push(gho);
						//return;
					}
				}
				if (_curGhosts.length != 0) DarkWorld._curLetterPos++; //if we found a ghost, advance the letter
			}
		}
		
		
		/**
		 * sets the array of visible ghosts
		 */
		public function setVisibleGhosts(g:Array):void {
			_visibleGhosts = g;
		}
		
	}
}