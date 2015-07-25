package citrus.components;

import pixi.core.math.Point;

class Motion {

	public var velocity:Point;
	public var angularVelocity:Float;
	public var damping:Float;

	public function new(velocityX:Float, velocityY:Float, angularVelocity:Float, damping:Float) {

		velocity = new Point(velocityY, velocityY);
		this.angularVelocity = angularVelocity;
		this.damping = damping;
	}
}