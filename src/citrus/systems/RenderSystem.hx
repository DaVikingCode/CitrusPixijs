package citrus.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.components.Position;
import citrus.nodes.RenderNode;

import pixi.core.display.Container;
import pixi.core.display.DisplayObject;

class RenderSystem extends System {

	public var container:Container;

	var _nodes:NodeList<RenderNode>;
	
	public function new(container:Container) {
		super();

		this.container = container;
	}

	override public function addToEngine(engine:Engine) {

		_nodes = engine.getNodeList(RenderNode);

		for (node in _nodes)
			_addToDisplay(node);

		_nodes.nodeAdded.add(_addToDisplay);
		_nodes.nodeRemoved.add(_removeFromDisplay);
	}

	function _addToDisplay(node:RenderNode) {

		container.addChild(node.displayObject);
	}

	function _removeFromDisplay(node:RenderNode) {

		container.removeChild(node.displayObject);
	}

	override public function update(time:Float) {

		for (node in _nodes) {

			var displayObject:DisplayObject = node.displayObject;
			var position:Position = node.position;

			displayObject.x = position.position.x;
			displayObject.y = position.position.y;
			displayObject.rotation = position.rotation;
		}
	}

	override public function removeFromEngine(engine:Engine) {

		_nodes = null;
	}
}