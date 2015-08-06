package citrus.components;

class Bullet {

	public var lifeRemaining:Float;
	public var collisionCategories:UInt;

	public function new(lifetime:Float, collisionCategories:UInt = 0) {

		lifeRemaining = lifetime;
		this.collisionCategories = collisionCategories;
	}
}