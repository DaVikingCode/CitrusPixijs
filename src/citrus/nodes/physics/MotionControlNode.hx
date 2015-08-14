package citrus.nodes.physics;

import ash.core.Node;

import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Physics;

class MotionControlNode extends Node<MotionControlNode> {

    public var control:MotionControls;
    public var motion:Motion;
    public var physics:Physics;
}