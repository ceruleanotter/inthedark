package 
{
	import adobe.utils.CustomActions;
	import flash.utils.Dictionary;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Lyla
	 */
	
	public class DefinitionScreen extends World 
	{
		
		private static const DEF_START_POS:Number = GameConstants.WORLD_HEIGHT * 0.4;
		private static const DEF_POS_INCREMENT:Number = (GameConstants.WORLD_HEIGHT * 0.2) / 4;
		private static const DEF_POS_X:Number = (GameConstants.WORLD_WIDTH * 0.1);
		private static const LETTERS:Array = [ "a", "b", "c", "d" ];
		private static const PICK_COLOR = 0xFF8000;
		private static const NORMAL_COLOR = 0xFFFFFF;
		
		private var _word:Word;
		private var _calledGhost:Ghost;
		private var _choices:Dictionary;
		private var _correct:Number;
		private var _pos:Number;
		private var _timeRunning:Number;
		private var _timerText:Text;
		private static var totalTime:Number = 5;
	
		
		public function DefinitionScreen(g:Ghost) {
			_word = g.getWord();
			_timeRunning = 0;
			_calledGhost = g;
			trace("Def screen was created; This happened");
			var defs:Array = GameConstants.getRandomDefs(_word);
			_choices = new Dictionary(true);
			_pos = 0;
			
			
			_timerText = new Text("0");
			_timerText.scale = 2;
			_timerText.x = GameConstants.WORLD_WIDTH - _timerText.textWidth * _timerText.scale;
			_timerText.y = 10;
			this.addGraphic(_timerText);
			
			for (var i:int = 0; i < defs.length; i++) {
				//trace("Word is " + _word);
				

				var d:Text = new Text(LETTERS[i]+") "+(defs[i] as Word).getDefText().text );
				d.y = DEF_START_POS + DEF_POS_INCREMENT * i;
				d.x = DEF_POS_X;
				this.addGraphic(d);
				_choices[LETTERS[i]] = d;
				if ((defs[i] as Word) == _word) _correct = i;
			}
			
			var question:Text = new Text("Type the definition of " + _word.getWordString());
			question.size = 20;
			question.y = DEF_START_POS - DEF_POS_INCREMENT;
			question.x = DEF_POS_X / 2;
			this.addGraphic(question);
		
		}
		
		override public function update():void {
			if (Input.pressed(Key.DOWN)) {
				(_choices[LETTERS[_pos]] as Text).color = NORMAL_COLOR;
				_pos = (_pos + 1) % 4;
				(_choices[LETTERS[_pos]] as Text).color = PICK_COLOR;
			}
			if (Input.pressed(Key.UP)) {
				(_choices[LETTERS[_pos]] as Text).color = NORMAL_COLOR;
				_pos = ((_pos - 1) + 4) % 4;
				(_choices[LETTERS[_pos]] as Text).color = PICK_COLOR;
				
			}
			
			if (Input.pressed(Key.ENTER)) {
				if (_pos == _correct) {
					trace("right!");
					_calledGhost.definitionWin();
					
				} else {
					trace("wrong!");
					_calledGhost.definitionLose();
				}
			}
			
			_timeRunning += FP.elapsed;
			_timerText.text = (Math.floor(_timeRunning)).toString();
			if (_timeRunning > totalTime) _calledGhost.definitionLose();
			
		}
		
	}
	
}