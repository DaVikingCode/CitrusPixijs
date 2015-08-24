package demo.physics.patch.nodes;

import ash.core.Node;

import citrus.components.Animation;
import citrus.components.Enemy;
import citrus.components.Motion;
import citrus.components.physics.Physics;

class EnemyAnimationNode extends Node<EnemyAnimationNode> {

    public var enemy:Enemy;
    public var animation:Animation;
    public var motion:Motion;
    public var physics:Physics;
}
