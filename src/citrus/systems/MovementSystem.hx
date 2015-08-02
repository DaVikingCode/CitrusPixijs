package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.core.AGameConfig;
import citrus.nodes.MovementNode;

class MovementSystem extends ListIteratingSystem<MovementNode> {

	var _config:AGameConfig;

	public function new(config:AGameConfig) {
		super(MovementNode, _updateNode);

		_config = config;
	}

	function _updateNode(node:MovementNode, time:Float) {

		var position = node.position;
		var motion = node.motion;

		position.position.x += motion.velocity.x * time;
		position.position.y += motion.velocity.y * time;

		if (position.position.x < 0)
			position.position.x += _config.width;

		if (position.position.x > _config.width)
			position.position.x -= _config.width;

		if (position.position.y < 0)
			position.position.y += _config.height;

		if (position.position.y > _config.height)
			position.position.y -= _config.height;

		position.rotation += motion.angularVelocity * time;

		if (motion.damping > 0) {

			var xDamp = Math.abs(Math.cos(position.rotation) * motion.damping * time);
			var yDamp = Math.abs(Math.sin(position.rotation) * motion.damping * time);

			if (motion.velocity.x > xDamp)
				motion.velocity.x -= xDamp;

			else if (motion.velocity.x < -xDamp)
				motion.velocity.x += xDamp;

			else
				motion.velocity.x = 0;

			if (motion.velocity.y > yDamp)
				motion.velocity.y -= yDamp;

			else if (motion.velocity.y < -yDamp)
				motion.velocity.y += yDamp;

			else
				motion.velocity.y = 0;
		}
	}
}