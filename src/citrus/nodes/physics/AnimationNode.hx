package citrus.nodes.physics;

import ash.core.Node;

import citrus.components.Animation;
import citrus.components.Motion;
import citrus.components.physics.Physics;

class AnimationNode extends Node<AnimationNode> {

    public var animation:Animation;
    public var motion:Motion;
    public var physics:Physics;
}