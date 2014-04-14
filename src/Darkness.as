package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.AngleTween;
	public class Darkness extends Entity
	{
		import net.flashpunk.utils.Input;
		import net.flashpunk.utils.Key;
		import net.flashpunk.graphics.Image;
		[Embed(source = 'assets/dark_large.png')] private const DARK:Class;
		[Embed(source = 'assets/light_large.png')] private const LIGHT:Class;
		
		[Embed(source = 'assets/dark_mask_up_113.png')] private const MASK_UP:Class;
		[Embed(source = 'assets/dark_mask_left_113.png')] private const MASK_LEFT:Class;
		[Embed(source = 'assets/dark_mask_right_113.png')] private const MASK_RIGHT:Class;
		[Embed(source = 'assets/dark_mask_down_113.png')] private const MASK_DOWN:Class;
		
		private static var _mask_up:Pixelmask;
		private static var _mask_down:Pixelmask;
		private static var _mask_left:Pixelmask;
		private static var _mask_right:Pixelmask;
		
		
		private static var _dark:Image;
		private static var _light:Image;
		private static var _totalDark:Graphiclist;
		
		private var _tween:AngleTween;
		public function Darkness()
		{
			
			
			_mask_up = new Pixelmask(MASK_UP);
			_mask_down = new Pixelmask(MASK_DOWN);
			_mask_left = new Pixelmask(MASK_LEFT);
			_mask_right = new Pixelmask(MASK_RIGHT);
			
			_dark = new Image(DARK)
			_light = new Image(LIGHT)
			_dark.scale = GameConstants.SCALE
			_light.scale = GameConstants.SCALE
			
			_light.centerOO()
			_dark.centerOO()
			_light.x = GameConstants.WORLD_WIDTH/ 2
			_light.y = GameConstants.WORLD_HEIGHT/ 2
			_dark.x = GameConstants.WORLD_WIDTH / 2
			_dark.y = GameConstants.WORLD_HEIGHT/2
			_light.alpha = 0.5
			
			
			_totalDark = new Graphiclist()
			_totalDark.add(_dark)
			_totalDark.add(_light)
			_tween = null



			graphic = _totalDark
			this.mask = _mask_down;
			type = "darkness";
		}
		
		private function finishTween():void {
			_tween = null
		}
		
		override public function update():void {
				var angleRot:Number = -1
				if (Input.pressed(Key.DOWN)) {
					this.mask = _mask_down;
					angleRot = 0
				} else if (Input.pressed(Key.UP)) {
					this.mask = _mask_up;
					angleRot = 180 
				} else if (Input.pressed(Key.LEFT)) {
					this.mask = _mask_left;
					angleRot = 270					
				} else if (Input.pressed(Key.RIGHT)) {
					this.mask = _mask_right;
					angleRot = 90					
				}
				
				
				//trace("light angle " + _light.angle)
				
				if (angleRot > -1) {
					trace("angle is " + angleRot);
					trace("darkness turning");
					
					//for each (var picpart:Image in _totalDark.children) {
						//picpart.angle = angleRot;
					_tween = new AngleTween(finishTween) // am I doing this correctly?
					_tween.tween(_light.angle, angleRot, 0.15)
					
					//}
				}
				
				if (_tween != null) {
					_tween.update()
					for each (var picpart:Image in _totalDark.children)	picpart.angle = _tween.angle
				}
				
					
				//need to check what ghosts collide
				var allghosts:Array = [];
				FP.world.getClass(Ghost, allghosts);
				var showghosts:Array = [];
				collideInto("ghost", 0, 0, showghosts);
				//var hideghosts:Array = [];
				(FP.world as DarkWorld).setVisibleGhosts(showghosts);
				for each (var g:Ghost in allghosts) {
					if (g.collidable == false) continue;
					if (showghosts.indexOf(g) == -1) { // if it's not in show ghosts, it's in hide
						//hideghosts.push(g);
						g.hide();
					} else {
						g.unhide();
					}
				}
				
				
				

				//get the difference
				/*for each (var g:Ghost in allghosts) {
					if (!g.hidden) {
						g._hidden = true;
					}
				}
				var numCollided:Number = 0;
				for each (var g:Ghost in ghosts) {
					if (g.hidden) {
						g._hidden = false;
						g._changed = true;
					}
				}
				*/

				//trace(numCollided);
		}
		
		


		
	}
}