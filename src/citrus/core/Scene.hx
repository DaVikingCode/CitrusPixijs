package citrus.core;

import ash.core.Engine;

import citrus.input.KeyPoll;

import pixi.core.display.Container;

class Scene extends Container {
	
	var _citrusJS:CitrusJS;

	var _engine:Engine;
	var _keyPoll:KeyPoll;

	public function new() {
		super();

		_citrusJS = CitrusJS.getInstance();
	}
	
	public function initialize() {

		_engine = new Engine();
		_keyPoll = new KeyPoll();
	}
	
	public function onUpdate(elapsedTime:Float) {

		_engine.update(elapsedTime * 0.001);
		_keyPoll.update();
	}
	
	public function destroy() {

		_keyPoll.destroy();

		_engine.removeAllSystems();
		_engine.removeAllEntities();
	}
}
