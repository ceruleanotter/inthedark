package
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text
	public class InfoScreen extends World
	{
		public function InfoScreen(score:Score)
		{
			trace("END OF GAME RUN")
			//var s:Score = new Score

			score.scoreLose()
			add(score)
			
			FP.screen.color = 0x000000;
			trace("score is" + Score._amount + " X is " + score.x + " y is " + score.y)
			trace("score graphic is " + score.graphic)
			var scoretext:Text = new Text("Game Over. Your score is:", 30, 150);
			scoretext.scale = 2.5;
			scoretext.color = 0xFF8000;
			this.addGraphic(scoretext)

		}
	}
}