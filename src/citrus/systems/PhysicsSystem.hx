package citrus.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.math.MathUtils;
import citrus.nodes.NapeNode;
import citrus.nodes.PhysicsNode;

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

        for (nape in _napes)
            node.physics.body.space = nape.nape.space;
    }

    function _removeFromNape(node:PhysicsNode) {

        for (nape in _napes)
            nape.nape.space.bodies.remove(node.physics.body);
    }

    override public function update(time:Float) {

        for (nape in _napes) {

            nape.nape.space.step(nape.nape.deltaTime, nape.nape.velocityIterations, nape.nape.positionIterations);

            for (physicsObject in _physicsObjects) {

                var position = physicsObject.position;
                var physics = physicsObject.physics;

                position.position.x = physics.body.position.x;
                position.position.y = physics.body.position.y;
                position.rotation = MathUtils.rad2deg(physics.body.rotation);
            }
        }
    }

    override public function removeFromEngine(engine:Engine) {

        for (nape in _napes)
            nape.nape.space.clear();

        _napes = null;
        _physicsObjects = null;
    }
}
