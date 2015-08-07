package demo.topdown.systems;

import citrus.core.AEntityCreator;
import citrus.components.Audio;
import citrus.components.Enemy;
import citrus.components.Player;
import citrus.input.KeyPoll;
import citrus.nodes.GunControlNode;
import citrus.physics.CollisionCategories;

import demo.topdown.EntityCreator;

import howler.Howl;

class GunControlSystem extends citrus.systems.GunControlSystem {

    public function new(keyPoll:KeyPoll, creator:AEntityCreator, ?sound:HowlOptions) {
        super(keyPoll, creator, sound);
    }

    override function _shoot(node:GunControlNode) {

        if (node.entity.has(Player))
            _creator.createUserBullet(node.gun, node.position, CollisionCategories.get(["Enemy"]));

        else if (node.entity.has(Enemy)) {

            if (node.gun.type == 0)
                _creator.createEnemyBullet(node.gun, node.position, CollisionCategories.get(["Player"]));
            else
                for (i in 0...3)
                   cast (_creator, EntityCreator).createEnemyThreeBullets(node.gun, node.position, CollisionCategories.get(["Player"]), -22.5 + i * 22.5);
        }


        if (_sound != null)
            node.entity.get(Audio).play(_sound);
    }
}