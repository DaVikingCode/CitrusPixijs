package demo.physics.patch.systems;

import ash.tools.ListIteratingSystem;

import demo.physics.patch.nodes.PlayerAnimationNode;

class PlayerAnimationSystem extends ListIteratingSystem<PlayerAnimationNode> {

    public function new() {
        super(PlayerAnimationNode, _updateNode);
    }

    function _updateNode(node:PlayerAnimationNode, time:Float) {

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