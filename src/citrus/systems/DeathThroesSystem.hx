package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.core.AEntityCreator;
import citrus.nodes.DeathThroesNode;

class DeathThroesSystem extends ListIteratingSystem<DeathThroesNode> {

	var _creator:AEntityCreator;

	public function new(creator:AEntityCreator) {
		super(DeathThroesNode, _updateNode);

		_creator = creator;
	}

	function _updateNode(node:DeathThroesNode, time:Float) {

		node.death.countdown -= time;

		if (node.death.countdown <= 0)
			_creator.destroyEntity(node.entity);
	}
}