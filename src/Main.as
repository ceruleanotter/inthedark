package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.debug.Console
	import net.flashpunk.World;

	public class Main extends Engine
	{
		public function Main()
		{
			super(GameConstants.WORLD_WIDTH, GameConstants.WORLD_HEIGHT, 60, false);
			trace("HELLO WORLD");
			GameConstants.initWords();
		}
			
		public static function continueCreation():void {
			FP.world = new DarkWorld();
			//FP.world = new InfoScreen(new Score)
			FP.console.enable();
			FP.console.debug = true;
			

		}
		

		override public function init():void
		{
			trace("FlashPunk has started successfully!");
			
			//var a = Math.atan2(5, 5)
			
			//trace("x is " + )
		}
		

	}
}