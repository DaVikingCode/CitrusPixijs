package citrus.nodes;

import ash.core.Node;

import citrus.components.Audio;
import citrus.components.Collision;
import citrus.components.Position;
import citrus.components.Spaceship;

class SpaceshipCollisionNode extends Node<SpaceshipCollisionNode> {

	public var spaceship:Spaceship;
	public var position:Position;
	public var collision:Collision;
	public var audio:Audio;
}