package citrus.core;

import ash.core.Engine;
import ash.core.Entity;

import citrus.components.Bullet;
import citrus.components.Collision;
import citrus.components.Gun;
import citrus.components.Motion;
import citrus.components.Position;

class AEntityCreator {
	
	var _engine:Engine;
	
	public function new(engine:Engine) {

		_engine = engine;
	}
	
	public function destroyEntity(entity:Entity) {

		_engine.removeEntity(entity);
	}
	
	public function createUserBullet(gun:Gun, parentPosition:Position):Entity {
		
		var cos = Math.cos(parentPosition.rotation);
		var sin = Math.sin(parentPosition.rotation);
		
		var bullet = new Entity()
		.add(new Bullet(gun.bulletLifetime))
		.add(new Position(cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x, sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, 0))
		.add(new Collision(0))
		.add(new Motion(cos * 150, sin * 150, 0, 0));
		
		return bullet;
	}
}