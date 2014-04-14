package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.motion.LinearPath;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;	
	public class Girl extends Entity
	{
		import net.flashpunk.graphics.Image;
		[Embed(source = 'assets/girl_forward.png')] private const GIRL_FORWARD:Class;
		[Embed(source = 'assets/girl_left.png')] private const GIRL_LEFT:Class;
		[Embed(source = 'assets/girl_right.png')] private const GIRL_RIGHT:Class;
		[Embed(source = 'assets/girl_forward.png')] private const GIRL_BACK:Class;
		private static var _girl_back:Image;
		private static var _girl_forward:Image;
		private static var _girl_left:Image;
		private static var _girl_right:Image;

		private var _switch_to:Image;
		private var _jump:LinearPath;
		public function Girl()
		{
			
			_girl_forward = new Image(GIRL_FORWARD)
			_girl_back = new Image(GIRL_BACK)			
			_girl_left = new Image(GIRL_LEFT)
			_girl_right = new Image(GIRL_RIGHT)
			
			graphic = new Image(GIRL_FORWARD);
			
			graphic.x = -GameConstants.GIRL_WIDTH / 2;
			graphic.y = -GameConstants.GIRL_HEIGHT / 2;
			setHitbox(GameConstants.GIRL_WIDTH*.7, GameConstants.GIRL_HEIGHT*.9);
			setOrigin(GameConstants.GIRL_WIDTH*.7 / 2, GameConstants.GIRL_HEIGHT*.9 / 2);
			type = "girl";
			
			_switch_to = null
		}
		
		
		override public function update():void {
			if (Input.pressed(Key.ANY)) {
				var jump:LinearPath = null
				if (Input.pressed(Key.DOWN)) {
					jump = LinearPath(this.addTween(new LinearPath()))
					_switch_to = _girl_forward
					
				} else if (Input.pressed(Key.UP)) {
					jump = LinearPath(this.addTween((new LinearPath())))					
					_switch_to = _girl_back;
					
				} else if (Input.pressed(Key.LEFT)) {
					jump = LinearPath(this.addTween((new LinearPath())))
					_switch_to = _girl_left;

					
				} else if (Input.pressed(Key.RIGHT)) {
					jump = LinearPath(this.addTween((new LinearPath())))
					_switch_to = _girl_right;
				}
				if (jump != null) {
					jump.addPoint(-GameConstants.GIRL_WIDTH / 2,(-GameConstants.GIRL_HEIGHT / 2)-GameConstants.GIRL_JUMP_Y)
					jump.addPoint(-GameConstants.GIRL_WIDTH / 2,(-GameConstants.GIRL_HEIGHT / 2))
					jump.object = this.graphic
					jump.setMotion(0.3)
					_jump = jump
				
				}
			}
			this.updateTweens()
			if(_jump != null && _jump.percent > 0.5) switchGraphic()
		}
		
		private function switchGraphic():void {
			graphic = _switch_to
			graphic.x = -GameConstants.GIRL_WIDTH / 2;
			graphic.y = -GameConstants.GIRL_HEIGHT / 2;			
		}
		
		
	}
}