package demo.physics.patch;

import citrus.core.Scene;
import citrus.systems.PhysicsSystem;
import citrus.systems.physics.MotionControlSystem;
import citrus.systems.physics.OneWaySystem;
import citrus.systems.physics.platformer2D.AnimationSystem;
import citrus.systems.RenderSystem;
import citrus.systems.SystemPriorities;

class Patch extends Scene {

    var _creator:EntityCreator;

    public function new() {
        super();
    }

    override public function initialize() {
        super.initialize();

        _creator = new EntityCreator(_engine);

        _engine.addSystem(new MotionControlSystem(_keyPoll), SystemPriorities.update);
        _engine.addSystem(new PhysicsSystem(), SystemPriorities.update);
        _engine.addSystem(new OneWaySystem(), SystemPriorities.update);
        _engine.addSystem(new AnimationSystem(), SystemPriorities.animate);
        _engine.addSystem(new RenderSystem(this), SystemPriorities.render);

        _creator.createGame();
    }
}
