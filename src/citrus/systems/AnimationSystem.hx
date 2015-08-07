package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.nodes.AnimationNode;

class AnimationSystem extends ListIteratingSystem<AnimationNode> {

	public function new() {
		super(AnimationNode, _updateNode, _addNode, _removeNode);
	}

	function _addNode(node:AnimationNode) {

		node.animation.animation.animationStarted();
	}

	function _updateNode(node:AnimationNode, time:Float) {

		node.animation.animation.animate(time);
	}

	function _removeNode(node:AnimationNode) {

		node.animation.animation.animationEnded();
	}
}