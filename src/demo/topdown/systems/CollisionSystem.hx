package demo.topdown.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.components.Display;
import citrus.math.MathUtils;
import citrus.math.Point;
import citrus.nodes.BulletCollisionNode;
import citrus.nodes.PlayerCollisionNode;
import citrus.nodes.EnemyCollisionNode;

import demo.topdown.nodes.GameNode;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

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
                    _hurtPlayer(player);

                    break;
                }

            }
        }

        for (bullet in _bullets) {

            if (bullet.bullet.target == "enemy")
                for (enemy in _enemies) {

                    if (Point.distance(bullet.position.position, enemy.position.position) <= enemy.collision.radius) {

                        enemy.enemy.fsm.changeState("destroyed");
                        _creator.destroyEntity(bullet.entity);

                        break;
                    }
                }

            else if (bullet.bullet.target == "player")
                for (player in _players) {

                    if (Point.distance(bullet.position.position, player.position.position) <= player.collision.radius) {

                        _hurtPlayer(player);
                        _creator.destroyEntity(bullet.entity);

                        break;
                    }
                }

        }

    }

    function _hurtPlayer(player:PlayerCollisionNode) {

        player.player.fsm.changeState("hurt");

        ++_games.head.state.hurt;

        if (_games.head.state.hurt > 3)
            trace("game over");

        else {

            if (_games.head.state.hurt > 1)
                player.entity.get(Display).displayObject.removeChildAt(1);

            var sprite = new Sprite(Texture.fromImage("Damage/playerShip1_damage" + _games.head.state.hurt + ".png"));
            sprite.anchor.set(0.5, 0.5);
            sprite.rotation = MathUtils.deg2rad(90);

            player.entity.get(Display).displayObject.addChild(sprite);
        }
    }

    override public function removeFromEngine(engine:Engine) {

        _games = null;
        _players = null;
        _enemies = null;
        _bullets = null;
    }
}
