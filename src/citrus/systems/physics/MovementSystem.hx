package citrus.systems.physics;

import ash.tools.ListIteratingSystem;

import citrus.nodes.physics.MovementNode;

class MovementSystem extends ListIteratingSystem<MovementNode> {

    public function new() {
        super(MovementNode, _updateNode);
    }

    function _updateNode(node:MovementNode, time:Float) {

        var position = node.position;
        var motion = node.motion;
        var physics = node.physics;
        var direction = node.direction;

        var velocity = physics.body.velocity;

        if (direction.left)
            velocity.x -= motion.velocity.x;

        else if (direction.right)
            velocity.x += motion.velocity.x;

        if (motion.maxVelocity.x != -1) {

            if (velocity.x > motion.maxVelocity.x)
                velocity.x = motion.maxVelocity.x;

            else if (velocity.x < -motion.maxVelocity.x)
                velocity.x = -motion.maxVelocity.x;
        }
    }
}
