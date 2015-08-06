package citrus.core;

import ash.core.Engine;
import ash.core.Entity;

import citrus.components.Bullet;
import citrus.components.Collision;
import citrus.components.Gun;
import citrus.components.Position;

class AEntityCreator {
	
	var _engine:Engine;
	
	public function new(engine:Engine) {

		_engine = engine;
	}
	
	public function destroyEntity(entity:Entity) {

		_engine.removeEntity(entity);
	}
	
	public function createUserBullet(gun:Gun, parentPosition:Position, collisionCategories:UInt = 0):Entity {
		
		var cos = Math.cos(parentPosition.rotation);
		var sin = Math.sin(parentPosition.rotation);
		
		var bullet = new Entity()
			.add(new Bullet(gun.bulletLifetime, collisionCategories))
			.add(new Position(cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x, sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, 0))
			.add(new Collision(0));

		// think to add on your EntityCreator a Display & Motion components
		
		return bullet;
	}

	public function createEnemyBullet(gun:Gun, parentPosition:Position, collisionCategories:UInt = 0):Entity {

		var cos = Math.cos(parentPosition.rotation);
		var sin = Math.sin(parentPosition.rotation);

		var bullet = new Entity()
			.add(new Bullet(gun.bulletLifetime, collisionCategories))
			.add(new Position(cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x, sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, 0))
			.add(new Collision(0));

		// think to add on your EntityCreator a Display & Motion components

		return bullet;
	}
}