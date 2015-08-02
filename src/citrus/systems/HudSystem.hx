package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.nodes.HudNode;

class HudSystem extends ListIteratingSystem<HudNode> {

	public function new() {
		super(HudNode, _updateNode);
	}

	function _updateNode(node:HudNode, time:Float) {

		node.hud.view.setLives(node.state.lives);
		node.hud.view.setScore(node.state.points);
	}
}