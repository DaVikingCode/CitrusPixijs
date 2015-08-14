package citrus.components;

import pixi.core.math.Point;

class Motion {

	public var velocity:Point;
	public var angularVelocity:Float;
	public var damping:Float;

	public function new(velocityX:Float = 0, velocityY:Float = 0, angularVelocity:Float = 0, damping:Float = 0) {

		velocity = new Point(velocityX, velocityY);
		this.angularVelocity = angularVelocity;
		this.damping = damping;
	}
}