package demo.physics.patch.systems;

import ash.tools.ListIteratingSystem;

import demo.physics.patch.nodes.EnemyAnimationNode;

class EnemyAnimationSystem extends ListIteratingSystem<EnemyAnimationNode> {

    public function new() {
        super(EnemyAnimationNode, _updateNode);
    }

    function _updateNode(node:EnemyAnimationNode, time:Float) {

        var physics = node.physics;
        var motion = node.motion;
        var animation = node.animation;

        if (physics.body.velocity.x > motion.velocity.x) {
            animation.animation.changeAnimation("walk");
            animation.animation.flipX(false);

        } else if (physics.body.velocity.x < -motion.velocity.x) {
            animation.animation.changeAnimation("walk");
            animation.animation.flipX(true);

        }
    }
}