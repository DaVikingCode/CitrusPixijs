package demo.topdown.nodes;

import ash.core.Node;

import demo.topdown.components.GameState;
import demo.topdown.components.Hud;

class HudNode extends Node<HudNode> {

    public var state:GameState;
    public var hud:Hud;
}