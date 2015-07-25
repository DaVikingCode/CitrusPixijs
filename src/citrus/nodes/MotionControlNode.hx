package citrus.nodes;

import ash.core.Node;

import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Position;

class MotionControlNode extends Node<MotionControlNode> {

	public var control:MotionControls;
	public var position:Position;
	public var motion:Motion;
}