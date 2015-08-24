package citrus.nodes.physics;

import ash.core.Node;

import citrus.components.Direction;
import citrus.components.Motion;
import citrus.components.physics.Physics;
import citrus.components.Position;

class MovementNode extends Node<MovementNode> {

    public var position:Position;
    public var motion:Motion;
    public var physics:Physics;
    public var direction:Direction;
}
