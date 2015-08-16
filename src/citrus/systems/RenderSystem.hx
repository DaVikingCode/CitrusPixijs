package citrus.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.components.Display;
import citrus.nodes.RenderNode;

import pixi.core.display.Container;

class RenderSystem extends System {

	var _container:Container;

	var _nodes:NodeList<RenderNode>;
	
	public function new(container:Container) {
		super();

		_container = container;
	}

	override public function addToEngine(engine:Engine) {

		_nodes = engine.getNodeList(RenderNode);

		for (node in _nodes)
			_addToDisplay(node);

		_nodes.nodeAdded.add(_addToDisplay);
		_nodes.nodeRemoved.add(_removeFromDisplay);
	}

	function _addToDisplay(node:RenderNode) {

		_updateLayerForDisplayObject(node.display);
	}

	function _removeFromDisplay(node:RenderNode) {

		cast (_container.getChildAt(node.display.layer), Container).removeChild(node.displayObject);
	}

	override public function update(time:Float) {

		for (node in _nodes) {

			var displayObject = node.displayObject;
			var position = node.position;

			displayObject.x = position.position.x;
			displayObject.y = position.position.y;
			displayObject.rotation = position.rotation;

			if (node.display._layerChanged)
				_updateLayerForDisplayObject(node.display);
		}
	}

	function _updateLayerForDisplayObject(display:Display) {

		while (display.layer >= _container.children.length)
			_container.addChild(new Container());

		cast (_container.getChildAt(display.layer), Container).addChild(display.displayObject);

		display._layerChanged = false;
	}

	override public function removeFromEngine(engine:Engine) {

		_nodes = null;
	}
}