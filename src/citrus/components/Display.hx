package citrus.components;

import pixi.core.display.DisplayObject;

class Display {

	public var displayObject(default, null):DisplayObject;
	@:isVar public var layer(default, set):UInt;

	@:allow(citrus.systems.RenderSystem)var _layerChanged:Bool;

	public function new(displayObject:DisplayObject, layer = 0) {

		this.displayObject = displayObject;
		this.layer = layer;
	}

	function set_layer(value:UInt):UInt {

		_layerChanged = true;

		return layer = value;
	}
}