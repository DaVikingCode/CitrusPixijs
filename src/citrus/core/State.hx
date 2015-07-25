package citrus.core;

import pixi.core.display.Container;

class State extends Container {
	
	var _citrusJS:CitrusJS;

	public function new() {
		super();

		_citrusJS = CitrusJS.getInstance();
	}
	
	public function initialize() {
		
	}
	
	public function onUpdate(elapsedTime:Float) {
		
	}
	
	public function destroy() {
		
	}
}
