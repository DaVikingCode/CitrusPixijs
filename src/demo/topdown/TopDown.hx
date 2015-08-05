package demo.topdown;

import citrus.core.State;
import citrus.systems.AnimationSystem;
import citrus.systems.AudioSystem;
import citrus.systems.BulletAgeSystem;
import citrus.systems.DeathThroesSystem;
import citrus.systems.GunControlSystem;
import citrus.systems.KillOutOfScreenSystem;
import citrus.systems.MotionControlSystem;
import citrus.systems.MovementSystem;
import citrus.systems.SystemPriorities;
import citrus.systems.RenderSystem;

import demo.topdown.systems.CollisionSystem;
import demo.topdown.systems.GameManager;
import demo.topdown.systems.WaveManager;

class TopDown extends State {

    var _config:GameConfig;
    var _creator:EntityCreator;

    public function new() {
        super();
    }

    override public function initialize() {
        super.initialize();

        _config = new GameConfig();
        _config.width = _citrusJS.width;
        _config.height = _citrusJS.height;
        _creator = new EntityCreator(_engine, _config);

        _engine.addSystem(new WaveManager(_creator, _config), SystemPriorities.preUpdate);
        _engine.addSystem(new GameManager(_creator, _config), SystemPriorities.preUpdate);
        _engine.addSystem(new KillOutOfScreenSystem(_creator, _config), SystemPriorities.preUpdate);
        _engine.addSystem(new MotionControlSystem(_keyPoll), SystemPriorities.update);
        _engine.addSystem(new GunControlSystem(_keyPoll, _creator), SystemPriorities.update);
        _engine.addSystem(new BulletAgeSystem(_creator), SystemPriorities.update);
        _engine.addSystem(new DeathThroesSystem(_creator), SystemPriorities.update);
        _engine.addSystem(new CollisionSystem(_creator), SystemPriorities.resolveCollisions);
        _engine.addSystem(new MovementSystem(_config, true), SystemPriorities.move);
        _engine.addSystem(new AnimationSystem(), SystemPriorities.animate);
        _engine.addSystem(new RenderSystem(this), SystemPriorities.render);
        _engine.addSystem(new AudioSystem(), SystemPriorities.render);

        _creator.createGame();
    }
}
