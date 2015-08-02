package citrus.nodes;

import ash.core.Node;

import citrus.components.Asteroid;
import citrus.components.Audio;
import citrus.components.Collision;
import citrus.components.Position;

class AsteroidCollisionNode extends Node<AsteroidCollisionNode> {

	public var asteroid:Asteroid;
	public var position:Position;
	public var collision:Collision;
	public var audio:Audio;
}