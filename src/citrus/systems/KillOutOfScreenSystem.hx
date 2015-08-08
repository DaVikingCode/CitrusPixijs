package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.core.AEntityCreator;
import citrus.nodes.KillOutOfScreenNode;

import pixi.core.math.shapes.Rectangle;

class KillOutOfScreenSystem extends ListIteratingSystem<KillOutOfScreenNode>  {

    var _creator:AEntityCreator;
    var _screenLimit:Rectangle;

    public function new(creator:AEntityCreator, screenLimit:Rectangle) {
        super(KillOutOfScreenNode, _updateNode);

        _creator = creator;
        _screenLimit = screenLimit;
    }

    function _updateNode(node:KillOutOfScreenNode, time:Float) {

        var killOutOfScreen = node.killOutOfScreen;
        var position = node.position;

        if (killOutOfScreen.killOutX && (position.position.x < _screenLimit.x || position.position.x > _screenLimit.width))
            _creator.destroyEntity(node.entity);


        if (killOutOfScreen.killOutY && (position.position.y < _screenLimit.y || position.position.y > _screenLimit.height))
            _creator.destroyEntity(node.entity);
    }
}
