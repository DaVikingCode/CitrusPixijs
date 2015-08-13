package demo.physics.patch;

import citrus.core.State;
import citrus.systems.physics.OneWaySystem;
import citrus.systems.PhysicsSystem;
import citrus.systems.RenderSystem;
import citrus.systems.SystemPriorities;

class Patch extends State {

    var _creator:EntityCreator;

    public function new() {
        super();
    }

    override public function initialize() {
        super.initialize();

        _creator = new EntityCreator(_engine);

        _engine.addSystem(new PhysicsSystem(), SystemPriorities.update);
        _engine.addSystem(new OneWaySystem(), SystemPriorities.update);
        _engine.addSystem(new RenderSystem(this), SystemPriorities.render);

        _creator.createGame();
    }
}
