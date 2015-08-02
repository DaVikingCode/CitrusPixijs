package;

import ash.core.Engine;
import ash.core.Entity;
import ash.fsm.EntityStateMachine;
import ash.tools.ComponentPool;

import citrus.components.Animation;
import citrus.components.Asteroid;
import citrus.components.Audio;
import citrus.components.Bullet;
import citrus.components.Collision;
import citrus.components.DeathThroes;
import citrus.components.Display;
import citrus.components.GameState;
import citrus.components.Gun;
import citrus.components.GunControls;
import citrus.components.Hud;
import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Position;
import citrus.components.Spaceship;
import citrus.graphics.AsteroidDeathView;
import citrus.graphics.AsteroidView;
import citrus.graphics.BulletView;
import citrus.graphics.HudView;
import citrus.graphics.SpaceshipDeathView;
import citrus.graphics.SpaceshipView;
import citrus.math.MathUtils;

import js.html.KeyboardEvent;

import pixi.core.display.Container;
import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class EntityCreator {

	var _engine:Engine;
	var _config:GameConfig;

	public function new(engine:Engine, config:GameConfig) {

		_engine = engine;
		_config = config;
	}

	public function destroyEntity(entity:Entity) {

		_engine.removeEntity(entity);
	}

	public function createGame():Entity {

		var hud = new citrus.graphics.HudView();

		var gameEntity = new Entity().add(new GameState()).add(new Hud(hud)).add(new Display(hud)).add(new Position(0, 0, 0));

		_engine.addEntity(gameEntity);

		return gameEntity;
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

		asteroid.add(new Asteroid(fsm)).add(new Position(x, y, 0)).add(new Audio());

		fsm.changeState("alive");

		_engine.addEntity(asteroid);

		return asteroid;
	}

	public function createSpaceship():Entity {

		var spaceship = new Entity();

		var fsm = new EntityStateMachine(spaceship);

		fsm.createState("playing")
		.add(Motion).withInstance(new Motion(0, 0, 0, 15))
		.add(MotionControls ).withInstance(new MotionControls(KeyboardEvent.DOM_VK_LEFT, KeyboardEvent.DOM_VK_RIGHT, KeyboardEvent.DOM_VK_UP, 100, 3))
		.add(Gun).withInstance(new Gun(8, 0, 0.3, 2))
		.add(GunControls).withInstance(new GunControls(KeyboardEvent.DOM_VK_SPACE))
		.add(Collision).withInstance( new Collision(9))
		.add(Display).withInstance(new Display(new SpaceshipView()));

		var deathView = new SpaceshipDeathView();
		fsm.createState("destroyed")
		.add(DeathThroes).withInstance(new DeathThroes(5))
		.add(Display).withInstance(new Display(deathView))
		.add(Animation).withInstance(new Animation(deathView));

		spaceship.add(new Spaceship(fsm)).add(new Position(_config.width * 0.5, _config.height * 0.5, 0)).add(new Audio());

		fsm.changeState("playing");

		_engine.addEntity(spaceship);

		return spaceship;
	}

	public function createUserBullet(gun:Gun, parentPosition:Position):Entity {

		var cos = Math.cos(parentPosition.rotation);
		var sin = Math.sin(parentPosition.rotation);
		
		var bullet = new Entity()
		.add(new Bullet(gun.bulletLifetime))
		.add(new Position(cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x, sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, 0))
		.add(new Collision(0))
		.add(new Motion(cos * 150, sin * 150, 0, 0))
		.add(new Display(new BulletView()));

		_engine.addEntity(bullet);

		return bullet;
	}
}