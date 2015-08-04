package demo.topdown.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.nodes.BulletCollisionNode;
import citrus.nodes.PlayerNode;

import demo.topdown.EntityCreator;
import demo.topdown.GameConfig;
import demo.topdown.nodes.GameNode;

class GameManager extends System {

    var _creator:EntityCreator;
    var _config:GameConfig;

    var _gameNodes:NodeList<GameNode>;
    var _spaceships:NodeList<PlayerNode>;
    var _bullets:NodeList<BulletCollisionNode>;

    public function new(creator:EntityCreator, config:GameConfig) {
        super();

        _creator = creator;
        _config = config;
    }

    override public function addToEngine(engine:Engine) {

        _gameNodes = engine.getNodeList(GameNode);
        _spaceships = engine.getNodeList(PlayerNode);
        _bullets = engine.getNodeList(BulletCollisionNode);
    }

    override public function update(time:Float) {

        var node = _gameNodes.head;

        if (node != null && node.state.playing) {

            if (_spaceships.empty) {

                if (node.state.lives > 0) {

                    _creator.createSpaceship();
                }
            }
        } else
            node.state.setForStart();

    }

    override public function removeFromEngine(engine:Engine) {

        _gameNodes = null;
        _spaceships = null;
        _bullets = null;
    }
}
