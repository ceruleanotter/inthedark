package
{
	import net.flashpunk.Entity;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	public class Darkness extends Entity
	{
		import net.flashpunk.utils.Input;
		import net.flashpunk.utils.Key;
		import net.flashpunk.graphics.Image;
		[Embed(source = 'assets/dark_up.png')] private const DARK_UP:Class;
		[Embed(source = 'assets/dark_left.png')] private const DARK_LEFT:Class;
		[Embed(source = 'assets/dark_right.png')] private const DARK_RIGHT:Class;
		[Embed(source = 'assets/dark_down.png')] private const DARK_DOWN:Class;
		
		[Embed(source = 'assets/dark_mask_up_113.png')] private const MASK_UP:Class;
		[Embed(source = 'assets/dark_mask_left_113.png')] private const MASK_LEFT:Class;
		[Embed(source = 'assets/dark_mask_right_113.png')] private const MASK_RIGHT:Class;
		[Embed(source = 'assets/dark_mask_down_113.png')] private const MASK_DOWN:Class;
		
		private static var _mask_up:Pixelmask;
		private static var _mask_down:Pixelmask;
		private static var _mask_left:Pixelmask;
		private static var _mask_right:Pixelmask;
		
		
		private static var _dark_up:Image;
		private static var _dark_down:Image;
		private static var _dark_left:Image;
		private static var _dark_right:Image;

		//private static _mask_up = new Pixelmask(MASK_UP);
		
		public function Darkness()
		{
			
			MASK_RIGHT.prototype
			_mask_up = new Pixelmask(MASK_UP);
			_mask_down = new Pixelmask(MASK_DOWN);
			_mask_left = new Pixelmask(MASK_LEFT);
			_mask_right = new Pixelmask(MASK_RIGHT);
			
			_dark_up = new Image(DARK_UP);
			_dark_down = new Image(DARK_DOWN);
			_dark_left = new Image(DARK_LEFT);
			_dark_right = new Image(DARK_RIGHT);
			
			
			_dark_up.scale = GameConstants.SCALE
			_dark_down.scale = GameConstants.SCALE
			_dark_left.scale = GameConstants.SCALE
			_dark_right.scale = GameConstants.SCALE
			
			
			_mask_down.height *= GameConstants.SCALE 
			_mask_right.height *= GameConstants.SCALE 
			_mask_left.height *= GameConstants.SCALE 
			_mask_up.height *= GameConstants.SCALE 
			
			_mask_down.width *= GameConstants.SCALE 
			_mask_right.width *= GameConstants.SCALE 
			_mask_left.width *= GameConstants.SCALE 
			_mask_up.width *= GameConstants.SCALE 
			trace("the data is " + _mask_down)

			graphic = _dark_down;
			this.mask = _mask_down;
			type = "darkness";
		}
		
		override public function update():void {
				if (Input.pressed(Key.DOWN)) {
					graphic = _dark_down;
					this.mask = _mask_down;
					
				} else if (Input.pressed(Key.UP)) {
					graphic = _dark_up;
					this.mask = _mask_up;
					
				} else if (Input.pressed(Key.LEFT)) {
					graphic = _dark_left;
					this.mask = _mask_left;
					
				} else if (Input.pressed(Key.RIGHT)) {
					graphic = _dark_right;
					this.mask = _mask_right;
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