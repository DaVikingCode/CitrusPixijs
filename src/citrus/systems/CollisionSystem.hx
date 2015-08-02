package citrus.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.math.Point;
import citrus.nodes.AsteroidCollisionNode;
import citrus.nodes.BulletCollisionNode;
import citrus.nodes.SpaceshipCollisionNode;

import howler.Howl;

class CollisionSystem extends System {

	var _creator:EntityCreator;

	var _spaceships:NodeList<SpaceshipCollisionNode>;
    var _asteroids:NodeList<AsteroidCollisionNode>;
    var _bullets:NodeList<BulletCollisionNode>;

    var _soundExplosionAsteroid:HowlOptions;

	public function new(creator:EntityCreator, ?soundExplosionAsteroid:HowlOptions) {
		super();

		_creator = creator;
		_soundExplosionAsteroid = soundExplosionAsteroid;
	}

	override public function addToEngine(engine:Engine) {

		_spaceships = engine.getNodeList(SpaceshipCollisionNode);
		_asteroids = engine.getNodeList(AsteroidCollisionNode);
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

					asteroid.asteroid.fsm.changeState("destroyed");

					if (_soundExplosionAsteroid != null)
						asteroid.audio.play(_soundExplosionAsteroid);

					break;
				}
			}
		}

		for (spaceship in _spaceships) {

			for (asteroid in _asteroids) {

				if (Point.distance(asteroid.position.position, spaceship.position.position) <= asteroid.collision.radius + spaceship.collision.radius) {

					spaceship.spaceship.fsm.changeState("destroyed");
					break;
				}
			}
		}
	}

	 override public function removeFromEngine(engine:Engine) {
		
		_spaceships = null;
		_asteroids = null;
		_bullets = null;
    }
}