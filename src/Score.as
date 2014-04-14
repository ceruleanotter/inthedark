package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	public class Score extends Entity
	{
		import net.flashpunk.graphics.Text


		public static var _amount:Number;
		private static var _text:Text;
		public function Score()
		{
			_amount = 0;
			_text = new Text(_amount.toString(), 0, 0);
			_text.color = 0xFF8000;
			_text.scale = 2;
			graphic = _text;
			this.x = GameConstants.WORLD_WIDTH - _text.textWidth*_text.scale;
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			this.y = 10;
			FP.world.bringToFront(this);
			
		}
		
		public function getText():String {
			return _text.text
		}
		
		override public function toString():String {
			return "Score";
		}
		public function ghostKilled():void {
			_amount += 10;
			_text.text = _amount.toString();
			this.x = GameConstants.WORLD_WIDTH - _text.textWidth*_text.scale;
		}
		
		public function scoreLose():void {
			_text.scale = 5;
			_text.color = 0xFF8000;

			this.width = _text.textWidth * _text.scale
			this.height = _text.textHeight * _text.scale
			
			
			this.x = (GameConstants.WORLD_WIDTH / 2) - this.width/2  
			this.y = (GameConstants.WORLD_HEIGHT / 2) - this.height / 2
			

			trace("The height is " + _text.height)
			this.visible = true
			

		}
	}
}