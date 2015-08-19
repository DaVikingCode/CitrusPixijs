package citrus.components;

import pixi.core.math.Point;

class Motion {

	public var velocity:Point;
	public var maxVelocity:Point;
	public var angularVelocity:Float;
	public var maxAngularVelocity:Float;
	public var damping:Float;

	public function new(velocityX:Float = 0, velocityY:Float = 0, maxVelocityX:Float = -1, maxVelocityY:Float = -1, angularVelocity:Float = 0, maxAngularVelocity:Float = -1, damping:Float = 0) {

		velocity = new Point(velocityX, velocityY);
		maxVelocity = new Point(maxVelocityX, maxVelocityY);
		this.angularVelocity = angularVelocity;
		this.maxAngularVelocity = maxAngularVelocity;
		this.damping = damping;
	}
}