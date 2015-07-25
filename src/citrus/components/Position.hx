package citrus.components;

import pixi.core.math.Point;

class Position {

	public var position:Point;
	public var rotation:Float;

	public function new(x:Float, y:Float, rotation:Float) {

		position = new Point(x, y);
		this.rotation = rotation;
	}
}