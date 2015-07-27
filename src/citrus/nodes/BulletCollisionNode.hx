package citrus.nodes;

import ash.core.Node;

import citrus.components.Bullet;
import citrus.components.Collision;
import citrus.components.Position;

class BulletCollisionNode extends Node<BulletCollisionNode> {

	public var bullet:Bullet;
	public var position:Position;
	public var collision:Collision;
}