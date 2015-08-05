package demo.topdown.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.math.Point;
import citrus.nodes.BulletCollisionNode;
import citrus.nodes.PlayerCollisionNode;
import citrus.nodes.EnemyCollisionNode;

import demo.topdown.nodes.GameNode;

class CollisionSystem extends System {

    var _creator:EntityCreator;

    var _games:NodeList<GameNode>;
    var _players:NodeList<PlayerCollisionNode>;
    var _enemies:NodeList<EnemyCollisionNode>;
    var _bullets:NodeList<BulletCollisionNode>;

    public function new(creator:EntityCreator) {
        super();

        _creator =  creator;
    }

    override public function addToEngine(engine:Engine) {

        _games = engine.getNodeList(GameNode);
        _players = engine.getNodeList(PlayerCollisionNode);
        _enemies = engine.getNodeList(EnemyCollisionNode);
        _bullets = engine.getNodeList(BulletCollisionNode);
    }

    override public function update(time:Float) {

        for (player in _players) {

            for (enemy in _enemies) {

                if (Point.distance(player.position.position, enemy.position.position) <= player.collision.radius + enemy.collision.radius) {

                    enemy.enemy.fsm.changeState("destroyed");

                    break;
                }

            }
        }

        for (bullet in _bullets) {

            for (enemy in _enemies) {

                if (Point.distance(bullet.position.position, enemy.position.position) <= enemy.collision.radius) {

                    enemy.enemy.fsm.changeState("destroyed");
                    _creator.destroyEntity(bullet.entity);

                    break;
                }
            }

        }

    }

    override public function removeFromEngine(engine:Engine) {

        _games = null;
        _players = null;
        _enemies = null;
        _bullets = null;
    }
}
