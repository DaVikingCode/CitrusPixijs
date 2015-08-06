package demo.asteroids.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.components.Audio;
import citrus.math.Point;
import citrus.nodes.EnemyCollisionNode;
import citrus.nodes.BulletCollisionNode;
import citrus.nodes.PlayerCollisionNode;

import demo.asteroids.EntityCreator;
import demo.asteroids.nodes.GameNode;

import howler.Howl;

class CollisionSystem extends System {

	var _creator:EntityCreator;

	var _games:NodeList<GameNode>;
	var _spaceships:NodeList<PlayerCollisionNode>;
    var _asteroids:NodeList<EnemyCollisionNode>;
    var _bullets:NodeList<BulletCollisionNode>;

    var _soundExplosionAsteroid:HowlOptions;
    var _soundExplosionShip:HowlOptions;

	public function new(creator:EntityCreator, ?soundExplosionAsteroid:HowlOptions, ?soundExplosionShip:HowlOptions) {
		super();

		_creator = creator;
		_soundExplosionAsteroid = soundExplosionAsteroid;
		_soundExplosionShip = soundExplosionShip;
	}

	override public function addToEngine(engine:Engine) {

		_games = engine.getNodeList(GameNode);
		_spaceships = engine.getNodeList(PlayerCollisionNode);
		_asteroids = engine.getNodeList(EnemyCollisionNode);
		_bullets = engine.getNodeList(BulletCollisionNode);
	}

	override public function update(time:Float) {

		for (bullet in _bullets) {

			for (asteroid in _asteroids) {

				if (Point.distance(asteroid.position.position, bullet.position.position) <= asteroid.collision.radius) {

					_creator.destroyEntity(bullet.entity);

					if (asteroid.collision.radius > 10) {

						_creator.createAsteroid(asteroid.collision.radius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5);
						_creator.createAsteroid(asteroid.collision.radius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5);
					}

					asteroid.enemy.fsm.changeState("destroyed");

					if (_games.head != null)
						++_games.head.state.points;

					if (_soundExplosionAsteroid != null)
						asteroid.entity.get(Audio).play(_soundExplosionAsteroid);

					break;
				}
			}
		}

		for (spaceship in _spaceships) {

			for (asteroid in _asteroids) {

				if (Point.distance(asteroid.position.position, spaceship.position.position) <= asteroid.collision.radius + spaceship.collision.radius) {

					spaceship.player.fsm.changeState("destroyed");

					if (_games.head != null)
						--_games.head.state.lives;

					if (_soundExplosionShip != null)
						spaceship.entity.get(Audio).play(_soundExplosionShip);

					break;
				}
			}
		}
	}

	 override public function removeFromEngine(engine:Engine) {
		
		_games = null;
		_spaceships = null;
		_asteroids = null;
		_bullets = null;
    }
}