package citrus.core;

import ash.core.Engine;
import ash.core.Entity;

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
	
	public function createUserBullet(gun:Gun, parentPosition:Position):Entity {
		
		return null;
	}
}