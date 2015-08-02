package citrus.nodes;

import ash.core.Node;

import citrus.components.GameState;
import citrus.components.Hud;

class HudNode extends Node<HudNode> {

	public var state:GameState;
	public var hud:Hud;
}