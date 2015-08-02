package citrus.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.math.Point;
import citrus.nodes.AsteroidCollisionNode;
import citrus.nodes.BulletCollisionNode;
import citrus.nodes.GameNode;
import citrus.nodes.SpaceshipCollisionNode;

import howler.Howl;

class CollisionSystem extends System {

	var _creator:EntityCreator;

	var _games:NodeList<GameNode>;
	var _spaceships:NodeList<SpaceshipCollisionNode>;
    var _asteroids:NodeList<AsteroidCollisionNode>;
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

					if (_games.head != null)
						++_games.head.state.points;

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

					if (_games.head != null)
						--_games.head.state.lives;

					if (_soundExplosionShip != null)
						spaceship.audio.play(_soundExplosionShip);

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