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

    var _numEnemies = 0;

    public function new(creator:EntityCreator, config:GameConfig) {
        super();

        _creator = creator;
        _config = config;
    }

    override public function addToEngine(engine:Engine) {

        _gameNodes = engine.getNodeList(GameNode);
        _enemies = engine.getNodeList(EnemyCollisionNode);

        _enemies.nodeRemoved.add(_enemyRemoved);
    }

    override public function update(time:Float) {

        if (_gameNodes.head.state.playing && _numEnemies < _gameNodes.head.state.numMaxEnemies) {

            ++_numEnemies;

            var posY = 50 + Math.random() * (_config.height - 50);

            if (!_enemies.empty) {
                //no overlaping
                var posYs = new Array<Float>();

                for (enemy in _enemies)
                    posYs.push(enemy.position.position.y);

                var goodPositionning = false;

                while (!goodPositionning) {

                    for (pos in posYs)
                        if (posY - 150 < pos && posY + 150 > pos) {
                            posY = 50 + Math.random() * (_config.height - 50);
                            goodPositionning = false;
                            break;
                        } else
                            goodPositionning = true;
                }
            }

            _creator.createRandomEnemy(posY);
        }
    }

    function _enemyRemoved(node) {

        --_numEnemies;
    }

    override public function removeFromEngine(engine:Engine) {

        _gameNodes = null;
        _enemies.nodeRemoved.removeAll();
        _enemies = null;
    }
}
