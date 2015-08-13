package citrus.systems.physics;

import ash.tools.ListIteratingSystem;

import citrus.nodes.physics.OneWayNode;

import nape.callbacks.CbType;
import nape.callbacks.InteractionType;
import nape.callbacks.PreCallback;
import nape.callbacks.PreFlag;
import nape.callbacks.PreListener;

class OneWaySystem extends ListIteratingSystem<OneWayNode> {

    static var _ONEWAY_PLATFORM = new CbType();
    var _oneWayListener:PreListener;

    public function new() {
        super(OneWayNode, null, _addNode, _removeNode);
    }

    function _addNode(node:OneWayNode) {

        node.physics.body.cbTypes.add(_ONEWAY_PLATFORM);
        node.physics.body.userData.oneWay = node.oneWay;

        _oneWayListener = new PreListener(InteractionType.COLLISION, _ONEWAY_PLATFORM, CbType.ANY_BODY, _oneWayHandler);

        node.physics.body.space.listeners.add(_oneWayListener);
    }

    function _oneWayHandler(cb:PreCallback):PreFlag {

        var oneWay = cb.arbiter.body1.userData.oneWay != null ? cb.arbiter.body1.userData.oneWay : cb.arbiter.body2.userData.oneWay;

        var colArb = cb.arbiter.collisionArbiter;

        if (oneWay.left && ((colArb.normal.x < 0 && cb.swapped) || (colArb.normal.x > 0 && cb.swapped)))
            return PreFlag.IGNORE;

        if (oneWay.right && ((colArb.normal.x > 0 && cb.swapped) || (colArb.normal.x < 0 && cb.swapped)))
            return PreFlag.IGNORE;

        if (oneWay.top && ((colArb.normal.y < 0 && cb.swapped) || (colArb.normal.y > 0 && cb.swapped)))
            return PreFlag.IGNORE;

        if (oneWay.bottom && ((colArb.normal.y > 0 && cb.swapped) || (colArb.normal.y < 0 && cb.swapped)))
            return PreFlag.IGNORE;

        return PreFlag.ACCEPT;
    }

    function _removeNode(node:OneWayNode) {

        node.physics.body.space.listeners.remove(_oneWayListener);

        node.physics.body.cbTypes.remove(_ONEWAY_PLATFORM);
        node.physics.body.userData.oneWay = null;
    }
}
