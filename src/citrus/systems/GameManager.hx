package citrus.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.nodes.BulletCollisionNode;
import citrus.nodes.GameNode;
import citrus.nodes.SpaceshipNode;

import pixi.core.math.Point;

class GameManager extends System {

	var _creator:EntityCreator;
	var _config:GameConfig;

	var _gameNodes:NodeList<GameNode>;
	var _spaceships:NodeList<SpaceshipNode>;
	var _bullets:NodeList<BulletCollisionNode>;

	public function new(creator:EntityCreator, config:GameConfig) {
		super();

		_creator = creator;
		_config = config;
	}

	override public function addToEngine(engine:Engine) {

		_gameNodes = engine.getNodeList(GameNode);
		_spaceships = engine.getNodeList(SpaceshipNode);
		_bullets = engine.getNodeList(BulletCollisionNode);
	}

	override public function update(time:Float) {

		for (node in _gameNodes) {

			if (_spaceships.empty) {

				if (node.state.lives > 0) {

					_creator.createSpaceship();
					--node.state.lives;
				}
			}
		}
	}

	override public function removeFromEngine(engine:Engine) {
		
		_gameNodes = null;
		_spaceships = null;
		_bullets = null;
	}
}