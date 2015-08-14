package demo.asteroids;

import citrus.core.Scene;
import citrus.physics.CollisionCategories;
import citrus.systems.AnimationSystem;
import citrus.systems.AudioSystem;
import citrus.systems.BulletAgeSystem;
import citrus.systems.DeathThroesSystem;
import citrus.systems.GunControlSystem;
import citrus.systems.MotionControlSystem;
import citrus.systems.MovementSystem;
import citrus.systems.RenderSystem;
import citrus.systems.SystemPriorities;

import demo.asteroids.systems.CollisionSystem;
import demo.asteroids.systems.GameManager;
import demo.asteroids.systems.HudSystem;
import demo.asteroids.systems.WaitForStartSystem;

import howler.Howl;

class Asteroids extends Scene {

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

		CollisionCategories.add("Enemy");
		
		var gunSound:HowlOptions = {};
		gunSound.urls = ["assets/spaceshooter/sound/sfx_laser1.ogg"];

		var asteroidExplosionSound:HowlOptions = {};
		asteroidExplosionSound.urls = ["assets/spaceshooter/sound/sfx_twoTone.ogg"];

		var shipExplosionSound:HowlOptions = {};
		shipExplosionSound.urls = ["assets/spaceshooter/sound/sfx_lose.ogg"];

		_engine.addSystem(new WaitForStartSystem(_creator), SystemPriorities.preUpdate);
		_engine.addSystem(new GameManager(_creator, _config), SystemPriorities.preUpdate);
		_engine.addSystem(new MotionControlSystem(_keyPoll), SystemPriorities.update);
		_engine.addSystem(new GunControlSystem(_keyPoll, _creator, gunSound), SystemPriorities.update);
		_engine.addSystem(new BulletAgeSystem(_creator), SystemPriorities.update);
		_engine.addSystem(new DeathThroesSystem(_creator), SystemPriorities.update);
		_engine.addSystem(new MovementSystem(_config), SystemPriorities.move);
		_engine.addSystem(new CollisionSystem(_creator, asteroidExplosionSound, shipExplosionSound), SystemPriorities.resolveCollisions);
		_engine.addSystem(new AnimationSystem(), SystemPriorities.animate);
		_engine.addSystem(new HudSystem(), SystemPriorities.animate);
		_engine.addSystem(new RenderSystem(this), SystemPriorities.render);
		_engine.addSystem(new AudioSystem(), SystemPriorities.render);

		_creator.createWaitForClick();
		_creator.createGame();
	}
}
