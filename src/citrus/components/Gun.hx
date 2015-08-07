package citrus.components;

import pixi.core.math.Point;

class Gun {

	public var shooting = false;
	public var offsetFromParent:Point;
	public var timeSinceLastShot:Float = 0;
	public var minimumShotInterval:Float;
	public var bulletLifetime:Float;
	public var shootAtStart = false;
	public var type = 0;

	public function new(offsetX:Float, offsetY:Float, minimumShotInterval:Float, bulletLifetime:Float, shootAtStart:Bool = false, type:Int = 0) {

		offsetFromParent = new Point(offsetX, offsetY);
		this.minimumShotInterval = minimumShotInterval;
		this.bulletLifetime = bulletLifetime;
		this.shootAtStart = shootAtStart;
		this.type = type;
	}
}