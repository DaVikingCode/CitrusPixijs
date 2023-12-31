package demo.physics.patch;

import citrus.core.Scene;
import citrus.systems.AnimationSystem;
import citrus.systems.CameraSystem;
import citrus.systems.physics.MotionControlSystem;
import citrus.systems.physics.MovementSystem;
import citrus.systems.physics.OneWaySystem;
import citrus.systems.physics.PhysicsSystem;
import citrus.systems.RenderSystem;
import citrus.systems.SystemPriorities;

import demo.physics.patch.systems.EnemyAnimationSystem;
import demo.physics.patch.systems.PlayerAnimationSystem;

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
        _engine.addSystem(new MovementSystem(), SystemPriorities.move);
        _engine.addSystem(new CameraSystem(this), SystemPriorities.move);
        _engine.addSystem(new AnimationSystem(), SystemPriorities.animate);
        _engine.addSystem(new PlayerAnimationSystem(), SystemPriorities.animate);
        _engine.addSystem(new EnemyAnimationSystem(), SystemPriorities.animate);
        _engine.addSystem(new RenderSystem(this), SystemPriorities.render);

        _creator.createGame();
    }
}
