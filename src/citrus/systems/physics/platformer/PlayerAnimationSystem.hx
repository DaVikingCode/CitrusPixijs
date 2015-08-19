package citrus.systems.physics.platformer;

import ash.tools.ListIteratingSystem;

import citrus.nodes.physics.AnimationNode;

class PlayerAnimationSystem extends ListIteratingSystem<AnimationNode> {

    public function new() {
        super(AnimationNode, _updateNode);
    }

    function _updateNode(node:AnimationNode, time:Float) {

        var physics = node.physics;
        var motion = node.motion;
        var animation = node.animation;

        if (physics.body.velocity.y > 1 || physics.body.velocity.y < -1)
            animation.animation.changeAnimation("jump");

        else if (physics.body.velocity.x > motion.velocity.x) {
            animation.animation.changeAnimation("walk");
            animation.animation.flipX(false);

        } else if (physics.body.velocity.x < -motion.velocity.x) {
            animation.animation.changeAnimation("walk");
            animation.animation.flipX(true);

        } else
            animation.animation.changeAnimation("idle");
    }
}