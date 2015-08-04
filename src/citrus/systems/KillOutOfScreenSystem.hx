package citrus.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.core.AEntityCreator;
import citrus.core.AGameConfig;
import citrus.nodes.BulletCollisionNode;

class KillOutOfScreenSystem extends System {

    var _creator:AEntityCreator;
    var _config:AGameConfig;

    var _bullets:NodeList<BulletCollisionNode>;

    public function new(creator:AEntityCreator, config:AGameConfig) {
        super();

        _creator = creator;
        _config = config;
    }

    override public function addToEngine(engine:Engine) {

        _bullets = engine.getNodeList(BulletCollisionNode);
    }

    override public function update(time:Float) {

        for (bullet in _bullets)
            if (bullet.position.position.x < 0 || bullet.position.position.x > _config.width || bullet.position.position.y < 0 || bullet.position.position.y > _config.height)
                _creator.destroyEntity(bullet.entity);
    }

    override public function removeFromEngine(engine:Engine) {

        _bullets = null;
    }
}
