package citrus.nodes;

import ash.core.Node;

import citrus.components.Audio;
import citrus.components.Collision;
import citrus.components.Position;
import citrus.components.Player;

class PlayerCollisionNode extends Node<PlayerCollisionNode> {

	public var player:Player;
	public var position:Position;
	public var collision:Collision;
}