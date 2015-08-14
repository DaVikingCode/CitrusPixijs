package citrus.components;

class MotionControls {
	
	public var left:Int;
	public var right:Int;
	public var up:Int;
	public var down:Int;
	public var accelerate:Int;

	public var accelerationRate:Float;
	public var rotationRate:Float;

	public function new(left = -1, right = -1, up = -1, down = -1, accelerate = -1, accelerationRate:Float = 0, rotationRate:Float = 0) {

		this.left = left;
		this.right = right;
		this.up = up;
		this.down = down;
		this.accelerate = accelerate;
		this.accelerationRate = accelerationRate;
		this.rotationRate = rotationRate;
	}
}