package demo.topdown.graphics;

import pixi.core.display.Container;
import pixi.core.text.Text;

class HudView extends Container {

    var _scores:Text;
    var _lives:Text;

    public function new() {
        super();

        _scores = _createTextField();
        _scores.x = 680;
        _scores.y = 5;
        addChild(_scores);

        _lives = _createTextField();
        _lives.x = 15;
        _lives.y = 5;
        addChild(_lives);

        setScore(0);
        setLives(3);
    }

    public function setScore(value:Int) {

        _scores.text = "SCORE: " + value;
    }

    public function setLives(value:Int) {

        _lives.text = "LIVES: " + value;
    }

    function _createTextField():Text {

        var tf = new Text("", {font:'bold 18px Helvetica', fill:'white', align:'center'});

        return tf;
    }
}