package citrus.nodes;

import ash.core.Node;

import citrus.components.Position;
import citrus.components.Display;

import pixi.core.display.DisplayObject;

class RenderNode extends Node<RenderNode> {

	public var position:Position;
	public var display:Display;

	public var displayObject(get, never):DisplayObject;

	inline function get_displayObject():DisplayObject {

		return display.displayObject;
	}
}