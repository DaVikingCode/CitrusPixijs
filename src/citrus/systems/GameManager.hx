package citrus.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.math.Point;
import citrus.nodes.AsteroidCollisionNode;
import citrus.nodes.BulletCollisionNode;
import citrus.nodes.GameNode;
import citrus.nodes.SpaceshipNode;

class GameManager extends System {

	var _creator:EntityCreator;
	var _config:GameConfig;

	var _gameNodes:NodeList<GameNode>;
	var _spaceships:NodeList<SpaceshipNode>;
	var _asteroids:NodeList<AsteroidCollisionNode>;
	var _bullets:NodeList<BulletCollisionNode>;

	public function new(creator:EntityCreator, config:GameConfig) {
		super();

		_creator = creator;
		_config = config;
	}

	override public function addToEngine(engine:Engine) {

		_gameNodes = engine.getNodeList(GameNode);
		_spaceships = engine.getNodeList(SpaceshipNode);
		_asteroids = engine.getNodeList(AsteroidCollisionNode);
		_bullets = engine.getNodeList(BulletCollisionNode);
	}

	override public function update(time:Float) {

		for (node in _gameNodes) {

			if (_spaceships.empty) {

				if (node.state.lives > 0) {

					var newSpaceshipPosition = new Point(_config.width * 0.5, _config.height * 0.5);
					var clearToAddSpaceship = true;

					for (asteroid in _asteroids) {

						if (Point.distance(asteroid.position.position, newSpaceshipPosition) <= asteroid.collision.radius + 50) {

							clearToAddSpaceship = false;
							break;
						}
					}

					if (clearToAddSpaceship) {

						_creator.createSpaceship();
						--node.state.lives;
					}

				} else {

					// game over
				}
			}

			if (_asteroids.empty && _bullets.empty && !_spaceships.empty) {

				//next level
				var spaceship = _spaceships.head;
				++node.state.level;
				var asteroidCount = 2 + node.state.level;

				for (i in 0...asteroidCount) {

					// check not on top of spaceship
					var position:Point;

					do {
						
						position = new Point(Math.random() * _config.width, Math.random() * _config.height);

					} while (Point.distance(position, spaceship.position.position) <= 80);

					_creator.createAsteroid(30, position.x, position.y);
				}
			}
		}
	}

	override public function removeFromEngine(engine:Engine) {
		
		_gameNodes = null;
		_spaceships = null;
		_asteroids = null;
		_bullets = null;
	}
}