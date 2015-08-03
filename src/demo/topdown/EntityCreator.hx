package demo.topdown;

import pixi.core.sprites.Sprite;
import ash.core.Engine;
import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.core.AEntityCreator;
import citrus.components.Audio;
import citrus.components.Collision;
import citrus.components.Display;
import citrus.components.Gun;
import citrus.components.GunControls;
import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Player;
import citrus.components.Position;
import citrus.math.MathUtils;

import js.html.KeyboardEvent;

import pixi.core.display.Container;
import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class EntityCreator extends AEntityCreator {

    var _config:GameConfig;

    public function new(engine:Engine, config:GameConfig) {
        super(engine);

        _config = config;
    }

    public function createGame():Entity {

        var gameEntity = new Entity("game").add(new GameState());

        _engine.addEntity(gameEntity);

        return gameEntity;
    }

    public function createSpaceship():Entity {

        var spaceship = new Entity();

        var display = new Sprite(Texture.fromImage("playerShip1_blue.png"));
        display.anchor.set(0.5);
        display.rotation = MathUtils.deg2rad(90); // the ship is oriented to the North, rotate to the East as expected by the systems.
        var container = new Container();
        container.addChild(display);

        var fsm = new EntityStateMachine(spaceship);

        fsm.createState("playing")
        .add(Motion).withInstance(new Motion(0, 0, 0, 50))
        .add(MotionControls ).withInstance(new MotionControls(KeyboardEvent.DOM_VK_LEFT, KeyboardEvent.DOM_VK_RIGHT, KeyboardEvent.DOM_VK_UP, 100, 3))
        .add(Gun).withInstance(new Gun(8, 0, 0.3, 2))
        .add(GunControls).withInstance(new GunControls(KeyboardEvent.DOM_VK_SPACE))
        .add(Collision).withInstance(new Collision(9))
        .add(Display).withInstance(new Display(container));

        spaceship.add(new Player(fsm)).add(new Position(_config.width * 0.5, _config.height * 0.5, MathUtils.deg2rad(90))).add(new Audio());

        fsm.changeState("playing");

        _engine.addEntity(spaceship);

        return spaceship;
    }
}
