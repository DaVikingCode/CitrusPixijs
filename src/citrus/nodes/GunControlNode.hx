package citrus.nodes;

import ash.core.Node;

import citrus.components.Audio;
import citrus.components.Gun;
import citrus.components.GunControls;
import citrus.components.Position;

class GunControlNode extends Node<GunControlNode> {

	public var control:GunControls;
	public var gun:Gun;
	public var position:Position;
	public var audio:Audio;
}