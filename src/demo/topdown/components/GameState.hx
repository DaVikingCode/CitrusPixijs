package demo.topdown.components;

class GameState {

    public var lives:Int = 0;
    public var hurt:Int = 0;
    public var level:Int;
    public var points:Int = 0;
    public var playing:Bool;
    public var wave:Int = 0;
    public var numMaxEnemies = 3;

    public function new() {

    }

    public function setForStart() {

        hurt = 0;
        lives = 3;
        level = 0;
        points = 0;
        playing = true;
    }
}