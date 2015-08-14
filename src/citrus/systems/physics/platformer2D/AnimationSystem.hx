package citrus.systems.physics.platformer2D;

import ash.tools.ListIteratingSystem;

import citrus.nodes.physics.AnimationNode;

class AnimationSystem extends ListIteratingSystem<AnimationNode> {

    public function new() {
        super(AnimationNode, _updateNode);
    }

    function _updateNode(node:AnimationNode, time:Float) {

        var physics = node.physics;
        var motion = node.motion;
        var animation = node.animation;

        if (physics.body.velocity.y > 1 || physics.body.velocity.y < -1)
            animation.animation.changeAnimation("jump");

        else if (physics.body.velocity.x > motion.velocity.x)
            animation.animation.changeAnimation("walk");

        else if (physics.body.velocity.x < -motion.velocity.x)
            animation.animation.changeAnimation("walk");

        else
            animation.animation.changeAnimation("idle");
    }
}