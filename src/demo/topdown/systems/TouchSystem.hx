package demo.topdown.systems;

import ash.tools.ListIteratingSystem;

import citrus.core.CitrusJS;
import citrus.nodes.MotionControlNode;

import pixi.core.display.Container;
import pixi.interaction.EventTarget;

class TouchSystem extends ListIteratingSystem<MotionControlNode> {

    var _stage:Container;

    var _node:MotionControlNode;

    public function new() {
        super(MotionControlNode, null, _addNode, _removeNode);

        _stage = CitrusJS.getInstance().stage;
    }

    function _addNode(node:MotionControlNode) {

        _node = node;

        _stage.interactive = true;
        _stage.tap = _stage.click = _onButtonDown;
    }

    function _removeNode(node:MotionControlNode) {

        _stage.interactive = false;
        _stage.tap = _stage.click = null;
    }

    function _onButtonDown(target:EventTarget) {

        _node.position.position.y = target.data.global.y;
    }
}
