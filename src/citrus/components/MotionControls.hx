package citrus.components;

class MotionControls {
	
	public var left:Int;
	public var right:Int;
	public var up:Int;
	public var down:Int;
	public var accelerate:Int;

	public var accelerationRate:Float;
	public var rotationRate:Float;

	public function new(left:Int, right:Int, up:Int, down:Int, accelerate:Int, accelerationRate:Float, rotationRate:Float) {

		this.left = left;
		this.right = right;
		this.up = up;
		this.down = down;
		this.accelerate = accelerate;
		this.accelerationRate = accelerationRate;
		this.rotationRate = rotationRate;
	}
}