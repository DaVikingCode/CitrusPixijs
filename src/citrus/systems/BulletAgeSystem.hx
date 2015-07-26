package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.nodes.BulletAgeNode;

class BulletAgeSystem extends ListIteratingSystem<BulletAgeNode> {

	var _creator:EntityCreator;

	public function new(creator:EntityCreator) {
		super(BulletAgeNode, _updateNode);

		_creator = creator;
	}

	function _updateNode(node:BulletAgeNode, time:Float) {

		var bullet = node.bullet;

		bullet.lifeRemaining -= time;

		if (bullet.lifeRemaining <= 0)
			_creator.destroyEntity(node.entity);
	}
}