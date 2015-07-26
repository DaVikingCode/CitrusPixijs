package citrus.components;

import pixi.core.math.Point;

class Position {

	public var position:Point;
	public var rotation(get, set):Float;
	var _rotation:Float;

	public function new(x:Float, y:Float, rotation:Float) {

		position = new Point(x, y);
		_rotation = rotation;
	}

	function get_rotation():Float {

		return _rotation * Math.PI / 180;
	}

	function set_rotation(value:Float):Float {

		return _rotation = value * 180 / Math.PI;
	}
}