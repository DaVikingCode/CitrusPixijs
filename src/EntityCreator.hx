package;

import ash.core.Engine;
import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.components.Audio;
import citrus.components.Display;
import citrus.components.GameState;
import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Position;
import citrus.components.Spaceship;

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

		var gameEntity = new Entity().add(new GameState());

		_engine.addEntity(gameEntity);

		return gameEntity;
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
		.add(Display).withInstance(new Display(container));

		spaceship.add(new Spaceship(fsm)).add(new Position(_config.width * 0.5, _config.height * 0.5, 0)).add(new Audio());

		fsm.changeState("playing");

		_engine.addEntity(spaceship);

		return spaceship;
	}
}