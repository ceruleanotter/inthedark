package
{
	import flash.display.Sprite;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	public class Ghost extends Entity
	{
		import net.flashpunk.graphics.Image;
		import net.flashpunk.graphics.Graphiclist;
		import net.flashpunk.graphics.Text;
		[Embed(source = 'assets/ghost.png')] private const GHOST:Class;
		[Embed(source = 'assets/ghost_hidden.png')] private const GHOST_HIDDEN:Class;
		[Embed(source = 'assets/ghostdieanim.png')] private const GHOST_DIE:Class;		
		public static const K_DEAD:int = 2;
		public static const K_CORRECT:int = 1;
		public static const K_WRONG:int = 0;
		private static const DIE_SPEED:Number = 20;

		
		public static var _max_speed:Number;
		public var _accel:Number = 1;
		public var _v:Number = 0;
		public var _xdiff:Number = 0;
		public var _ydiff:Number = 0;

		public var _angle:Number;
		private var _word:Word;
		private var _text:Text;
		private var _textGlow:Text;
		private var _gList:Graphiclist;
		private var _hidden_pic:Image;
		private var _dieAnim:Spritemap;
		private var _hidden:Boolean;
		private var _changed:Boolean;
		private var _boost:Number;
		
		private var _darkWorld:DarkWorld;
		
		
		public function Ghost( dk:DarkWorld)
		{
			
			_darkWorld = dk;

			//sets up all the movement stuff
			var randA:Number = ((Math.random() * Math.PI/8)-Math.PI/16)+(Math.PI/2)*Math.floor(Math.random()*4);
			var y:Number = Math.sin(randA) * GameConstants.GHOST_START_DIST + GameConstants.WORLD_HEIGHT/2;
			var x:Number = Math.cos(randA) * GameConstants.GHOST_START_DIST + GameConstants.WORLD_WIDTH / 2;
			_max_speed = 10;
			_boost = 5;
			this.x = x;
			this.y = y;
			_xdiff = DarkWorld._girl.x - this.x ;
			_ydiff = DarkWorld._girl.y - this.y;
			_angle = Math.atan2(_ydiff, _xdiff)
			
			
			
			//gets all the graphics set up
			_gList = new Graphiclist();
			var ghostI:Image = new Image(GHOST);
			_hidden_pic = new Image(GHOST_HIDDEN);
			_dieAnim = new Spritemap(GHOST_DIE, 62, 80,removeFromWorld);
			_dieAnim.add("die", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], DIE_SPEED, false);
			_dieAnim.centerOrigin();
			if (x < GameConstants.WORLD_WIDTH / 2) {
				_hidden_pic.flipped = true;
				ghostI.flipped = true;
				_dieAnim.flipped = true;
			}
			_gList.add(ghostI);
			generateWord();


			
			//makes the hitbox

			setHitbox(GameConstants.GHOST_WIDTH, GameConstants.GHOST_HEIGHT);
			setOrigin(GameConstants.GHOST_WIDTH / 2, GameConstants.GHOST_HEIGHT / 2);
			type = "ghost";
			
			//gets the correct image
			_hidden = false;
			this.hide();

			
		}
		
		
		
		/**
		 * Generates the word for the ghost
		 */
		private function generateWord():void {
			var word:Word = GameConstants.getWord();
			//word = word + " ";
			_word = word;
			_text = new Text(word.getWordString());
			_text.y = GameConstants.GHOST_HEIGHT / 2;
			_text.color = 0xB8B421;
			_textGlow = new Text("");
			_textGlow.y = GameConstants.GHOST_HEIGHT / 2;
			_textGlow.color = 0x272503;
			_gList.add(_text);

			_gList.add(_textGlow);
			
			
		}
		
		public function getWord():Word {
			return _word;
		}
		
		
		override public function update():void {
			if (this.collidable == false) {
				//trace("The frame is " + _dieAnim.frame);
				_dieAnim.alpha=((15 - _dieAnim.frame) / 15.0);
				return;
			}
		
			//check if we've hit the girl
			if (collide("girl", x, y)) {
				if (GameConstants.DEFINITIONS_ON) FP.world = new DefinitionScreen(this); //removed definitions
				else this.definitionLose();
				return;
			}
			
			/*prevSpeed = Math.sqrt(Math.pow(speedx, 2) + Math.pow(speedy, 2));
			nowSpeed = prevSpeed++;*/
			_xdiff = DarkWorld._girl.x - this.x ;
			_ydiff = DarkWorld._girl.y - this.y;
			_angle = Math.atan2(_ydiff, _xdiff)
			var distance:Number = Math.sqrt(Math.pow(_xdiff, 2) + Math.pow(_ydiff, 2))
			
			if (!_hidden) FP.world.sendToBack(this); // deal with problem of ghosts created on screen being above light, even though they were send back
			if (distance < 5) {
				return;
			}

			_v = distance / 20 + _boost ; //pixels per second
			
			if (_v > _max_speed) _v = _max_speed;
			if (_v < 5) _v = 5;
			
			var d:Number = _v * FP.elapsed;
			this.y += (d * Math.sin(_angle));
			this.x += (d * Math.cos(_angle));
			//trace("speed " + _v);
			/*
			if (distance <= GameConstants.GHOST_START_DIST/2) {
				_accel = -0.02;
			} else {
				_accel = 0.02;
			}
			var d = _v * FP.elapsed + _accel * Math.pow(FP.elapsed, 2);
			_v += _accel*FP.elapsed;
			
			
			
			this.y += (d * Math.sin(_angle));
			this.x += (d * Math.cos(_angle));
			*/
			this.y += Math.random()*2-1;
			this.x += Math.random()*2-1;
			
		}

		
		/**
		 * hides the ghost
		 */
		public function hide():void {
			
			if (!_hidden){
				graphic = _hidden_pic;
				FP.world.bringToFront(this);
				graphic.x = -GameConstants.GHOST_WIDTH / 2;
				graphic.y = -GameConstants.GHOST_HEIGHT / 2;
				_hidden = true;
			}
			
		}
		
		/**
		 * makes the ghost visible
		 */
		public function unhide():void {
			if (_hidden) {
				graphic = _gList;
				FP.world.sendToBack(this);
			//	FP.world.bringToFront(this);
				graphic.x = -GameConstants.GHOST_WIDTH / 2;
				graphic.y = -GameConstants.GHOST_HEIGHT / 2;
				_hidden = false;
			}
			
		}
		
		
		/**
		 * Checks whether the key progresses the killing of the Ghost
		 */
		public function checkKey(keyPressed:String, pos:int):Number {
			//trace("text :" + _text);
			if (_text.richText.charAt(pos) == keyPressed) {
				//check if totally dead or just progress
				if (pos == _text.richText.length - 1) return K_DEAD;
				else {
					_textGlow.text = (_text.text.substring(0, pos+1));
					return K_CORRECT;
				}
			} else {
				_textGlow.text = ("");
				return K_WRONG;
			}
		}
		
		/**
		 * Kills the ghost.
		 */
		public function die():void {
			//could start an animation

			GameConstants.score.ghostKilled();
			this.animDeath();
	
		}
		
		
		private function animDeath():void {
			this.collidable = false;
			graphic = _dieAnim;
			_dieAnim.play("die");

		}
		
		private function removeFromWorld():void {

			FP.world.remove(this);		
		}
		
		public function definitionWin():void {
			FP.world = _darkWorld;
			this.animDeath();
			
		}
		
		public function definitionLose():void {
			//FP.world.removeAll()
			_darkWorld.removeAll()
			FP.world = new InfoScreen();
			//_darkWorld.removeAll()

		}
	}
}