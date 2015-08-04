package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.core.AEntityCreator;
import citrus.core.AGameConfig;
import citrus.nodes.KillOutOfScreenNode;

class KillOutOfScreenSystem extends ListIteratingSystem<KillOutOfScreenNode>  {

    var _creator:AEntityCreator;
    var _config:AGameConfig;

    public function new(creator:AEntityCreator, config:AGameConfig) {
        super(KillOutOfScreenNode, _updateNode);

        _creator = creator;
        _config = config;
    }

    function _updateNode(node:KillOutOfScreenNode, time:Float) {

        var killOutOfScreen = node.killOutOfScreen;
        var position = node.position;

        if (killOutOfScreen.killOutX && (position.position.x < 0 || position.position.x > _config.width))
            _creator.destroyEntity(node.entity);


        if (killOutOfScreen.killOutY && (position.position.y < 0 || position.position.y > _config.height))
            _creator.destroyEntity(node.entity);
    }
}
