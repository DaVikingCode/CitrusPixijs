package demo.asteroids.graphics;

import ash.signals.Signal0;

import pixi.core.display.Container;
import pixi.core.text.Text;
import pixi.interaction.EventTarget;

class WaitForStartView extends Container {

	public var clicked = new Signal0();

	var _gameOver:Text;
	var _clickToStart:Text;

	public function new() {
		super();

		_gameOver = _createGameOver();
		addChild(_gameOver);

		_clickToStart = _createClickToStart();
		addChild(_clickToStart);

		interactive = buttonMode = true;

		addListener("added", addedToStage);
		addListener("removed", removedFromStage);
	}

	function addedToStage() {

		tap = click =_onButtonDown;
	}

	function removedFromStage() {

		tap = click = null;

		_gameOver.text = "GAME OVER";
	}

	function _onButtonDown(target:EventTarget) {

		clicked.dispatch();
	}

	function _createGameOver():Text {

		var tf = new Text("ASTEROIDS", {font:'bold 32px Helvetica', fill:'white', align:'center'});

		tf.x = 285;
		tf.y = 200;

		return tf;
	}

	function _createClickToStart():Text {

		var tf = new Text("CLICK TO START", {font:'bold 18px Helvetica', fill:'white', align:'center'});

		tf.x = 300;
		tf.y = 250;

		return tf;
	}
}