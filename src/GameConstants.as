package 
{
	
	/**
	 * ...
	 * @author Lyla
	 */

	 import flash.events.Event;
	 import flash.net.URLLoader;
	 import flash.net.URLRequest;
	 import net.flashpunk.FP
	public class GameConstants 
	{
	public static const SCALE:Number = 1.13333;
	public static const  WORLD_WIDTH:int = 600*SCALE;
	public static const  WORLD_HEIGHT:int = 600*SCALE;
	public static const GIRL_WIDTH:int = 76;
	public static const GIRL_HEIGHT:int = 154; 
	public static const GHOST_WIDTH:int = 62;
	public static const GHOST_HEIGHT:int = 80;
	public static const GHOST_START_DIST:int = Math.sqrt(Math.pow(WORLD_WIDTH,2)+Math.pow(WORLD_HEIGHT,2))/2.8;
	public static const DEFINITIONS_ON:Boolean = false;
	
	
	private static var WORD_LIST:Array = new Array() ;
	private static var WORD_LOC:int;
	private static var WORD_FILE:String = "./be.xml"//"words.xml"
	
	//[Embed(source='./words.xml',
    //    mimeType="application/octet-stream")]
    //public static const WORDSXML:Class; 
	
	public static function initWords():void {
			var xmlString:URLRequest = new URLRequest(WORD_FILE);
			var xmlLoader:URLLoader = new URLLoader(xmlString);
			xmlLoader.addEventListener("complete", init);
			function init(event:Event):void{
				 var wordList:XML = XML(xmlLoader.data); //new XML(WORDSXML)
				 var w:XMLList = wordList.children().children();
				 for each (var word:XML in w) {
					 var w_info:XMLList = word.children();
					 
					 WORD_LIST.push(new Word(w_info[0].toString(), w_info[1].toString()));
					 

					 
				 }
				 //randomize it
				 randomizeWords();
				 Main.continueCreation();
			}
	}
	
	public static function randomizeWords():void {
		/*var temp:Word;
		for (var i:int; i < WORD_LIST.length; i++) {
				var randIndex1:Number = Math.floor(Math.random() * WORD_LIST.length);
				var randIndex2:Number = Math.floor(Math.random() * WORD_LIST.length);			
				temp = WORD_LIST[randIndex1];
				WORD_LIST[randIndex1] = WORD_LIST[randIndex2];
				WORD_LIST[randIndex2] = temp;
			}*/
		FP.shuffle(WORD_LIST);
		WORD_LOC = 0;
	}
	
	public static function getWord():Word {
		if (WORD_LOC == WORD_LIST.length) randomizeWords();
		WORD_LOC++;
		return WORD_LIST[WORD_LOC - 1];
	}
	
	public static function getRandomDefs(pickedWord:Word):Array {
		var pickedWords:Array = new Array();
		var i:int = 0;
		pickedWords.push(pickedWord)
		while (pickedWords.length < 4) {
			var w:Word = FP.choose(WORD_LIST);
			if (pickedWords.indexOf(w) == -1) pickedWords.push(w);
			i++;
		}
		trace("This happened " + i + " times");
		FP.shuffle(pickedWords);
		return pickedWords;
	}
	

	
	
	
	}
}