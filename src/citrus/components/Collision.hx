package citrus.components;

import pixi.core.math.shapes.Rectangle;

class Collision {

	public var radius:Float;
	public var rectangle:Rectangle;

	public function new(?radius:Float, ?rectangle:Rectangle) {

		this.radius = radius;
		this.rectangle = rectangle;
	}
}