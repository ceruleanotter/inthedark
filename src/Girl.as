package
{
	import net.flashpunk.Entity;
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
		}
		
		
		override public function update():void {
			if(Input.pressed(Key.ANY)) {
				if (Input.pressed(Key.DOWN)) {
					graphic = _girl_forward;
					
				} else if (Input.pressed(Key.UP)) {
					graphic = _girl_back;

					
				} else if (Input.pressed(Key.LEFT)) {
					graphic = _girl_left;

					
				} else if (Input.pressed(Key.RIGHT)) {
					graphic = _girl_right;
				}
				graphic.x = -GameConstants.GIRL_WIDTH / 2;
				graphic.y = -GameConstants.GIRL_HEIGHT / 2;
			}
		}
		
	}
}