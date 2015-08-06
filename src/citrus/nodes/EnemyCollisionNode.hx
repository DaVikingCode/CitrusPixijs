package citrus.nodes;

import ash.core.Node;

import citrus.components.Audio;
import citrus.components.Enemy;
import citrus.components.Collision;
import citrus.components.Position;

class EnemyCollisionNode extends Node<EnemyCollisionNode> {

	public var enemy:Enemy;
	public var position:Position;
	public var collision:Collision;
}