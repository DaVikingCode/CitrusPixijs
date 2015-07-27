package;

import ash.core.Engine;

import citrus.core.State;
import citrus.systems.AudioSystem;
import citrus.systems.BulletAgeSystem;
import citrus.systems.GameManager;
import citrus.systems.GunControlSystem;
import citrus.systems.MotionControlSystem;
import citrus.systems.MovementSystem;
import citrus.systems.RenderSystem;
import citrus.systems.SystemPriorities;

import howler.Howl;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class TestState extends State {
	
	var _engine:Engine;
	var _config:GameConfig;
	var _creator:EntityCreator;
	var _keyPoll:KeyPoll;
	
	public function new() {
		super();
	}
	
	override public function initialize() {
		super.initialize();
		
		_engine = new Engine();
		_config = new GameConfig();
		_config.width = 800;//_citrusJS.width;
		_config.height = 600;//_citrusJS.height;
		_creator = new EntityCreator(_engine, _config);
		_keyPoll = new KeyPoll();
		
		var gunSound:HowlOptions = {};
		gunSound.urls = ["assets/spaceshooter/sound/sfx_laser1.ogg"];

		_engine.addSystem(new GameManager(_creator, _config), SystemPriorities.preUpdate);
		_engine.addSystem(new MotionControlSystem(_keyPoll), SystemPriorities.update);
		_engine.addSystem(new GunControlSystem(_keyPoll, _creator, gunSound), SystemPriorities.update);
		_engine.addSystem(new BulletAgeSystem(_creator), SystemPriorities.update);
		_engine.addSystem(new MovementSystem(_config), SystemPriorities.move);
		_engine.addSystem(new RenderSystem(this), SystemPriorities.render);
		_engine.addSystem(new AudioSystem(), SystemPriorities.render);

		_creator.createGame();
	}
	
	override public function onUpdate(elapsedTime:Float) {
		super.onUpdate(elapsedTime);

		_engine.update(elapsedTime * 0.001);
	}
}
