package;

import ash.core.Engine;
import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.components.Display;
import citrus.components.GameState;
import citrus.components.Position;
import citrus.components.Spaceship;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class EntityCreator {

	var _engine:Engine;

	public function new(engine:Engine) {

		_engine = engine;
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

		var display = new Sprite(Texture.fromImage("assets/bunny.png"));
		display.anchor.set(0.5);

		var fsm = new EntityStateMachine(spaceship);

		fsm.createState("playing")
		.add(Display).withInstance(new Display(display));

		spaceship.add(new Spaceship(fsm)).add(new Position(50, 55, 0));

		fsm.changeState("playing");

		_engine.addEntity(spaceship);

		return spaceship;
	}
}