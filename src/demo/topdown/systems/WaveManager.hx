package demo.topdown.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.nodes.EnemyCollisionNode;

import demo.topdown.nodes.GameNode;

class WaveManager extends System {

    var _creator:EntityCreator;
    var _config:GameConfig;

    var _gameNodes:NodeList<GameNode>;
    var _enemies:NodeList<EnemyCollisionNode>;

    public function new(creator:EntityCreator, config:GameConfig) {
        super();

        _creator = creator;
        _config = config;
    }

    override public function addToEngine(engine:Engine) {

        _gameNodes = engine.getNodeList(GameNode);
        _enemies = engine.getNodeList(EnemyCollisionNode);
    }

    override public function update(time:Float) {

        if (_enemies.empty)
            _creator.createRandomEnemy();
    }

    override public function removeFromEngine(engine:Engine) {

        _gameNodes = null;
    }
}
