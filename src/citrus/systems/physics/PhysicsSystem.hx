package citrus.systems.physics;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.nodes.physics.NapeNode;
import citrus.nodes.physics.PhysicsNode;

class PhysicsSystem extends System {

    var _napes:NodeList<NapeNode>;
    var _physicsObjects:NodeList<PhysicsNode>;

    public function new() {
        super();
    }

    override public function addToEngine(engine:Engine) {

        _napes = engine.getNodeList(NapeNode);
        _physicsObjects = engine.getNodeList(PhysicsNode);

        for (physicsObject in _physicsObjects)
            _addToNape(physicsObject);

        _physicsObjects.nodeAdded.add(_addToNape);
        _physicsObjects.nodeRemoved.add(_removeFromNape);
    }

    function _addToNape(node:PhysicsNode) {

        var nape = _napes.head;

        node.physics.body.space = nape.nape.space;
    }

    function _removeFromNape(node:PhysicsNode) {

        var nape = _napes.head;

        nape.nape.space.bodies.remove(node.physics.body);
    }

    override public function update(time:Float) {

        var nape = _napes.head;

        nape.nape.space.step(nape.nape.deltaTime, nape.nape.velocityIterations, nape.nape.positionIterations);

        for (physicsObject in _physicsObjects) {

            var position = physicsObject.position;
            var physics = physicsObject.physics;

            position.position.x = physics.body.position.x;
            position.position.y = physics.body.position.y;
            position.rotation = physics.body.rotation;
        }
    }

    override public function removeFromEngine(engine:Engine) {

        var nape = _napes.head;

        nape.nape.space.clear();

        _napes = null;
        _physicsObjects = null;
    }
}
