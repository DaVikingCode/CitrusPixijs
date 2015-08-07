package citrus.systems;

import ash.fsm.EntityStateMachine;
import ash.tools.ListIteratingSystem;

import citrus.nodes.TimeOutChangeStateNode;

class TimeOutChangeStateSystem extends ListIteratingSystem<TimeOutChangeStateNode> {

    public function new() {
        super(TimeOutChangeStateNode, _updateNode, _addNode);
    }

    function _addNode(node:TimeOutChangeStateNode) {

        node.timeout.resetTimeout();
    }

    function _updateNode(node:TimeOutChangeStateNode, time:Float) {

        node.timeout.timeout -= time;

        if (node.timeout.timeout <= 0) {

            node.timeout.fsm.changeState(node.timeout.state);
        }

    }
}
