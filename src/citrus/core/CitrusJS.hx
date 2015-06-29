package citrus.core;

import pixi.plugins.app.Application;

class CitrusJS extends Application {
	
	public function new() {
		super();
		
		onUpdate = _onUpdate;
	}
	
	function _onUpdate(elapsedTime:Float) {
		
	}
}
