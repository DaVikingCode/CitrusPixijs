package demo.topdown;

import citrus.core.State;
import citrus.input.KeyPoll;
import citrus.systems.AudioSystem;
import citrus.systems.MotionControlSystem;
import citrus.systems.MovementSystem;
import citrus.systems.SystemPriorities;
import citrus.systems.RenderSystem;

import demo.topdown.systems.GameManager;

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

        _engine.addSystem(new GameManager(_creator, _config), SystemPriorities.preUpdate);
        _engine.addSystem(new MotionControlSystem(_keyPoll), SystemPriorities.update);
        _engine.addSystem(new MovementSystem(_config), SystemPriorities.move);
        _engine.addSystem(new RenderSystem(this), SystemPriorities.render);
        _engine.addSystem(new AudioSystem(), SystemPriorities.render);

        _creator.createGame();
    }
}
