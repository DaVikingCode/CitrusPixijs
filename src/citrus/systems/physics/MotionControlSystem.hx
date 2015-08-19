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

        var velocity = physics.body.velocity;

        if (_keyPoll.isDown(control.left))
            velocity.x -= motion.velocity.x;

        if (_keyPoll.isDown(control.right))
            velocity.x += motion.velocity.x;

        if (_keyPoll.justPressed(control.up))
            velocity.y = - motion.velocity.y;

        if (motion.maxVelocity.x != -1) {

            if (velocity.x > motion.maxVelocity.x)
                velocity.x = motion.maxVelocity.x;

            else if (velocity.x < -motion.maxVelocity.x)
                velocity.x = -motion.maxVelocity.x;
        }
    }
}