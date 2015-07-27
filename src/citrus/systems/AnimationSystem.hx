package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.nodes.AnimationNode;

class AnimationSystem extends ListIteratingSystem<AnimationNode> {

	public function new() {
		super(AnimationNode, _updateNode);
	}

	function _updateNode(node:AnimationNode, time:Float) {

		node.animation.animation.animate(time);
	}
}