package demo.asteroids.nodes;

import ash.core.Node;

import demo.asteroids.components.GameState;
import demo.asteroids.components.Hud;

class HudNode extends Node<HudNode> {

	public var state:GameState;
	public var hud:Hud;
}