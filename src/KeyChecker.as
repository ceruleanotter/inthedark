package
{
	import net.flashpunk.Entity;
	public class KeyChecker extends Entity
	{
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	private var _darkWorld:DarkWorld;
		public function KeyChecker(dw:DarkWorld)
		{
			_darkWorld = dw;
		}
		
		override public function update():void {
			if (Input.pressed(Key.ANY))
			{
				//send that key
				_darkWorld.checkKeyGhosts(Input.keyString.charAt(Input.keyString.length - 1));
				
			}
			if (Input.pressed(Key.P)) {
				_darkWorld.snapPic();

			}
		}
		
	}
}