package
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text
	public class InfoScreen extends World
	{
		
		private var _score:Score;
		public function InfoScreen()
		{
			trace("END OF GAME RUN def def")

			var s:Score = new Score //no idea why I need to make a new score
			s.scoreLose()
			//_score = GameConstants.score;
			//_score.scoreLose()
			//trace("Score is " + _score.getText())
			//_score = GameConstants.score
			
			//_score.scoreLose()
			//_score.visible = true;
			//_score.render()
			//_score.graphic.visible = true;
			

			FP.screen.color = 0x000000;
			//trace("score is" + Score._amount + " X is " + _score.x + " y is " + _score.y)
			//trace("score graphic is " + _score + " on camera is "+ _score.renderTarget)
			var scoretext:Text = new Text("Game Over. Your score is:", 30, 150);
			scoretext.scale = 2.5;
			scoretext.color = 0xFF8000;
			this.addGraphic(scoretext)
			
			
			this.add(s)
			
			//trace(_score.world)
		
		}
		
		
		
	}
}