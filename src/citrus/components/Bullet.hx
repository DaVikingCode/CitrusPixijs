package citrus.components;

class Bullet {

	public var lifeRemaining:Float;
	public var target:String;

	public function new(lifetime:Float, ?target:String) {

		lifeRemaining = lifetime;
		this.target = target;
	}
}