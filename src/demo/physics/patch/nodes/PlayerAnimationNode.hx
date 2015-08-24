package demo.physics.patch.nodes;

import ash.core.Node;

import citrus.components.Player;
import citrus.components.Animation;
import citrus.components.Motion;
import citrus.components.physics.Physics;

class PlayerAnimationNode extends Node<PlayerAnimationNode> {

    public var player:Player;
    public var animation:Animation;
    public var motion:Motion;
    public var physics:Physics;

}
