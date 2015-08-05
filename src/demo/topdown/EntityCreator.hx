package demo.topdown;

import ash.core.Engine;
import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.core.AEntityCreator;
import citrus.components.Audio;
import citrus.components.Collision;
import citrus.components.Display;
import citrus.components.Enemy;
import citrus.components.Gun;
import citrus.components.GunControls;
import citrus.components.KillOutOfScreen;
import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Player;
import citrus.components.Position;
import citrus.math.MathUtils;

import demo.topdown.components.GameState;
import demo.topdown.graphics.BasicEnemyView;
import demo.topdown.graphics.BulletView;
import demo.topdown.graphics.SpaceshipView;

import js.html.KeyboardEvent;

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

        var fsm = new EntityStateMachine(spaceship);

        fsm.createState("playing")
        .add(Motion).withInstance(new Motion(0, 0, 0, 50))
        .add(MotionControls).withInstance(new MotionControls(-1, -1, KeyboardEvent.DOM_VK_UP, KeyboardEvent.DOM_VK_DOWN, -1, 200, 0))
        .add(Gun).withInstance(new Gun(60, 0, 0.5, 5))
        .add(GunControls).withInstance(new GunControls(KeyboardEvent.DOM_VK_SPACE))
        .add(Collision).withInstance(new Collision(9))
        .add(Display).withInstance(new Display(new SpaceshipView()));

        spaceship
            .add(new Player(fsm))
            .add(new Position(_config.width * 0.15, _config.height * 0.5, MathUtils.deg2rad(0)))
            .add(new Audio());

        fsm.changeState("playing");

        _engine.addEntity(spaceship);

        return spaceship;
    }

    public function createBasicEnemy():Entity {

        var enemy = new Entity();
        enemy
            .add(new Enemy(new EntityStateMachine(enemy)))
            .add(new Collision(50))
            .add(new Position(_config.width, Math.random() * _config.height, 0))
            .add(new Motion(-250, 0, 0, 0))
            .add(new KillOutOfScreen(true, false))
            .add(new Audio())
            .add(new Display(new BasicEnemyView()));

        _engine.addEntity(enemy);

        return enemy;
    }

    override public function createUserBullet(gun:Gun, parentPosition:Position):Entity {

        var bullet = super.createUserBullet(gun, parentPosition);

        bullet
            .add(new Display(new BulletView()))
            .add(new Motion(Math.cos(parentPosition.rotation) * 500, Math.sin(parentPosition.rotation) * 500, 0, 0))
            .add(new KillOutOfScreen(true, false));

        _engine.addEntity(bullet);

        return bullet;
    }
}
