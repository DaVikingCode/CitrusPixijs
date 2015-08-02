package demo.asteroids.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.nodes.AsteroidCollisionNode;

import demo.asteroids.EntityCreator;
import demo.asteroids.nodes.GameNode;
import demo.asteroids.nodes.WaitForStartNode;

class WaitForStartSystem extends System {

	var _engine:Engine;
	var _creator:EntityCreator;

	var _gameNodes:NodeList<GameNode>;
	var _waitNodes:NodeList<WaitForStartNode>;
	var _asteroids:NodeList<AsteroidCollisionNode>;

	public function new(creator:EntityCreator) {
		super();

		_creator = creator;
	}

	override public function addToEngine(engine:Engine) {

		_engine = engine;

		_waitNodes = _engine.getNodeList(WaitForStartNode);
		_gameNodes = _engine.getNodeList(GameNode);
		_asteroids = _engine.getNodeList(AsteroidCollisionNode);
	}

	override public function update(time:Float) {

		var node = _waitNodes.head;
		var game = _gameNodes.head;

		if (node != null && node.wait.startGame && game != null) {

			for (asteroid in _asteroids)
				_creator.destroyEntity(asteroid.entity);

			game.state.setForStart();
			node.wait.startGame = false;
			_engine.removeEntity(node.entity);
		}
	}

	override public function removeFromEngine(engine:Engine) {

		_gameNodes = null;
		_waitNodes = null;
	}
}