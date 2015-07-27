package;

import ash.core.Engine;
import ash.core.Entity;
import ash.fsm.EntityStateMachine;
import ash.tools.ComponentPool;

import citrus.components.Asteroid;
import citrus.components.Audio;
import citrus.components.Bullet;
import citrus.components.Collision;
import citrus.components.Display;
import citrus.components.GameState;
import citrus.components.Gun;
import citrus.components.GunControls;
import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Position;
import citrus.components.Spaceship;
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

		if (entity.has(Asteroid))
			ComponentPool.dispose(entity.get(Asteroid));

	}

	public function createGame():Entity {

		var gameEntity = new Entity().add(new GameState());

		_engine.addEntity(gameEntity);

		return gameEntity;
	}

	public function createAsteroid(radius:Float, x:Float, y:Float):Entity {

		var indice = MathUtils.randomInt(1, 4);

		var display = new Sprite(Texture.fromFrame("Meteors/meteorBrown_big" + indice + ".png"));
		display.anchor.set(0.5);

		var asteroid:Entity = new Entity()
		.add(ComponentPool.get(Asteroid))
		.add(new Position(x, y, 0))
		.add(new Collision(radius))
		.add(new Motion((Math.random() - 0.5) * 4 * (50 - radius), (Math.random() - 0.5) * 4 * (50 - radius), Math.random() * 2 - 1, 0))
		.add(new Display(display));

		_engine.addEntity(asteroid);

		return asteroid;
	}

	public function createSpaceship():Entity {

		var spaceship = new Entity();

		var display = new Sprite(Texture.fromFrame("playerShip1_orange.png"));
		display.anchor.set(0.5);
		display.rotation = 90 * Math.PI / 180;
		var container = new Container();
		container.addChild(display);

		var fsm = new EntityStateMachine(spaceship);

		fsm.createState("playing")
		.add(Motion).withInstance(new Motion(0, 0, 0, 15))
		.add(MotionControls ).withInstance(new MotionControls(KeyboardEvent.DOM_VK_LEFT, KeyboardEvent.DOM_VK_RIGHT, KeyboardEvent.DOM_VK_UP, 100, 3))
		.add(Gun).withInstance(new Gun(55, 0, 0.3, 2))
		.add(GunControls).withInstance(new GunControls(KeyboardEvent.DOM_VK_SPACE))
		.add(Display).withInstance(new Display(container));

		spaceship.add(new Spaceship(fsm)).add(new Position(_config.width * 0.5, _config.height * 0.5, 0)).add(new Audio());

		fsm.changeState("playing");

		_engine.addEntity(spaceship);

		return spaceship;
	}

	public function createUserBullet(gun:Gun, parentPosition:Position):Entity {

		var cos = Math.cos(parentPosition.rotation);
		var sin = Math.sin(parentPosition.rotation);

		var display = new Sprite(Texture.fromFrame("Effects/fire01.png"));
		display.anchor.set(0.5);
		display.rotation = -90 * Math.PI / 180;
		var container = new Container();
		container.addChild(display);
		
		var bullet = new Entity()
		.add(new Bullet(gun.bulletLifetime))
		.add(new Position(cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x, sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, parentPosition.rotation * 180 / Math.PI))
		.add(new Motion(cos * 150, sin * 150, 0, 0))
		.add(new Display(container));

		_engine.addEntity(bullet);

		return bullet;
	}
}