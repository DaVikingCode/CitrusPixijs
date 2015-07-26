package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.nodes.MotionControlNode;

class MotionControlSystem extends ListIteratingSystem<MotionControlNode> {

	var _keyPoll:KeyPoll;

	public function new(keyPoll:KeyPoll) {
		super(MotionControlNode, _updateNode);

		_keyPoll = keyPoll;
	}

	function _updateNode(node:MotionControlNode, time:Float) {

		var control = node.control;
		var position = node.position;
		var motion = node.motion;

		if (_keyPoll.isDown(control.left))
			position.rotation -= control.rotationRate * time;

		if (_keyPoll.isDown(control.right))
			position.rotation += control.rotationRate * time;

		if (_keyPoll.isDown(control.accelerate)) {

			motion.velocity.x += Math.cos(position.rotation) * control.accelerationRate * time;
			motion.velocity.y += Math.sin(position.rotation) * control.accelerationRate * time;
		}
	}
}