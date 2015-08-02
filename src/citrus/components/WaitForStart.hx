package citrus.components;

import citrus.graphics.WaitForStartView;

class WaitForStart {

	public var waitForStart:WaitForStartView;
	public var startGame:Bool;

	public function new(waitForStart:WaitForStartView) {

		this.waitForStart = waitForStart;
		waitForStart.clicked.add(setStartGame);
	}

	public function setStartGame() {

		startGame = true;
	}
}