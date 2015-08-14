package citrus.systems.physics;

import ash.tools.ListIteratingSystem;

import citrus.input.KeyPoll;
import citrus.nodes.physics.MotionControlNode;

class MotionControlSystem extends ListIteratingSystem<MotionControlNode> {

    var _keyPoll:KeyPoll;

    public function new(keyPoll:KeyPoll) {
        super(MotionControlNode, _updateNode);

        _keyPoll = keyPoll;
    }

    function _updateNode(node:MotionControlNode, time:Float) {

        var control = node.control;
        var physics = node.physics;
        var motion = node.motion;

        if (_keyPoll.isDown(control.left))
            physics.body.velocity.x -= motion.velocity.x;

        if (_keyPoll.isDown(control.right))
            physics.body.velocity.x += motion.velocity.x;

        if (_keyPoll.isUp(control.up))
            physics.body.velocity.y = - motion.velocity.y;
    }
}