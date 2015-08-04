package demo.asteroids;

import ash.core.Entity;
import ash.core.Engine;
import ash.fsm.EntityStateMachine;

import citrus.core.AEntityCreator;
import citrus.components.Animation;
import citrus.components.Enemy;
import citrus.components.Audio;
import citrus.components.Collision;
import citrus.components.DeathThroes;
import citrus.components.Display;
import citrus.components.Gun;
import citrus.components.GunControls;
import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Player;
import citrus.components.Position;

import demo.asteroids.components.GameState;
import demo.asteroids.components.Hud;
import demo.asteroids.components.WaitForStart;
import demo.asteroids.graphics.AsteroidDeathView;
import demo.asteroids.graphics.AsteroidView;
import demo.asteroids.graphics.BulletView;
import demo.asteroids.graphics.HudView;
import demo.asteroids.graphics.SpaceshipDeathView;
import demo.asteroids.graphics.SpaceshipView;
import demo.asteroids.graphics.WaitForStartView;

import js.html.KeyboardEvent;

class EntityCreator extends AEntityCreator {

	var _config:GameConfig;
	var _waitEntity:Entity;

	public function new(engine:Engine, config:GameConfig) {
		super(engine);
		
		_config = config;
	}

	public function createGame():Entity {

		var hud = new HudView();

		var gameEntity = new Entity("game").add(new GameState()).add(new Hud(hud)).add(new Display(hud)).add(new Position(0, 0, 0));

		_engine.addEntity(gameEntity);

		return gameEntity;
	}

	public function createWaitForClick():Entity {

		if (_waitEntity == null) {

			var waitView = new WaitForStartView();

			_waitEntity = new Entity("wait").add(new WaitForStart(waitView)).add(new Display(waitView)).add(new Position(0, 0, 0));
		}

		_waitEntity.get(WaitForStart).startGame = false;

		_engine.addEntity(_waitEntity);

		return _waitEntity;
	}

	public function createAsteroid(radius:Float, x:Float, y:Float):Entity {

		var asteroid = new Entity();

		var fsm = new EntityStateMachine(asteroid);

		fsm.createState("alive")
			.add(Motion).withInstance(new Motion((Math.random() - 0.5) * 4 * (50 - radius), (Math.random() - 0.5) * 4 * (50 - radius), Math.random() * 2 - 1, 0))
			.add(Collision).withInstance(new Collision(radius))
			.add(Display).withInstance(new Display(new AsteroidView(radius)));

		var deathView = new AsteroidDeathView(radius);

		fsm.createState("destroyed")
			.add(DeathThroes).withInstance(new DeathThroes(3))
			.add(Display).withInstance(new Display(deathView))
			.add(Animation).withInstance(new Animation(deathView));

		asteroid
			.add(new Enemy(fsm))
			.add(new Position(x, y, 0))
			.add(new Audio());

		fsm.changeState("alive");

		_engine.addEntity(asteroid);

		return asteroid;
	}

	public function createSpaceship():Entity {

		var spaceship = new Entity();

		var fsm = new EntityStateMachine(spaceship);

		fsm.createState("playing")
			.add(Motion).withInstance(new Motion(0, 0, 0, 15))
			.add(MotionControls).withInstance(new MotionControls(KeyboardEvent.DOM_VK_LEFT, KeyboardEvent.DOM_VK_RIGHT, -1, -1, KeyboardEvent.DOM_VK_UP, 100, 3))
			.add(Gun).withInstance(new Gun(8, 0, 0.3, 2))
			.add(GunControls).withInstance(new GunControls(KeyboardEvent.DOM_VK_SPACE))
			.add(Collision).withInstance(new Collision(9))
			.add(Display).withInstance(new Display(new SpaceshipView()));

		var deathView = new SpaceshipDeathView();
		fsm.createState("destroyed")
			.add(DeathThroes).withInstance(new DeathThroes(5))
			.add(Display).withInstance(new Display(deathView))
			.add(Animation).withInstance(new Animation(deathView));

		spaceship
			.add(new Player(fsm))
			.add(new Position(_config.width * 0.5, _config.height * 0.5, 0))
			.add(new Audio());

		fsm.changeState("playing");

		_engine.addEntity(spaceship);

		return spaceship;
	}

	override public function createUserBullet(gun:Gun, parentPosition:Position):Entity {
		
		var bullet = super.createUserBullet(gun, parentPosition);
		
		bullet
			.add(new Display(new BulletView()))
			.add(new Motion(Math.cos(parentPosition.rotation) * 150, Math.sin(parentPosition.rotation) * 150, 0, 0));

		_engine.addEntity(bullet);

		return bullet;
	}
}