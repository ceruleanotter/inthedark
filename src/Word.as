package 
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Lyla
	 */
	public class Word extends Entity 
	{
		import net.flashpunk.graphics.Text;

		private var _defText:Text;
		private var _word:String;
		public function Word(w:String, def:String) { 
			_defText = new Text(def);
			_word = w;
		}
		
		public function getWordString():String {
			return _word;
		}
		public function getDefText():Text {
			return _defText;
		}
		
		//override public function update():void {
			
		//}
	}
	
}