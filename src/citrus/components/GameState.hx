package citrus.components;

class GameState {
	
	public var lives:Int = 0;
	public var level:Int;
	public var points:Int = 0;
	public var playing:Bool;

	public function new() {
		
	}

	public function setForStart() {
		
		lives = 3;
		level = 0;
		points = 0;
		playing = true;
	}
}