package citrus.components;

import citrus.math.MathUtils;

import pixi.core.math.Point;

class Position {

	public var position:Point;
	public var rotation(get, set):Float;
	var _rotation:Float;

	public function new(x:Float = 0, y:Float = 0, rotation:Float = 0) {

		position = new Point(x, y);
		this.rotation = rotation;
	}

	function get_rotation():Float {

		return MathUtils.rad2deg(_rotation);
	}

	function set_rotation(value:Float):Float {

		return _rotation = MathUtils.deg2rad(value);
	}
}