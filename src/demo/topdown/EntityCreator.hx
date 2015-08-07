package demo.topdown;

import ash.core.Engine;
import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.core.AEntityCreator;
import citrus.components.Animation;
import citrus.components.Audio;
import citrus.components.Bullet;
import citrus.components.Collision;
import citrus.components.Display;
import citrus.components.Gun;
import citrus.components.GunControls;
import citrus.components.KillOutOfScreen;
import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Player;
import citrus.components.Position;
import citrus.components.TimeOutChangeState;
import citrus.math.MathUtils;

import demo.topdown.components.GameState;
import demo.topdown.entities.BasicEnemyEntity;
import demo.topdown.entities.OneBulletEnemyEntity;
import demo.topdown.entities.ThreeBulletsEnemyEntity;
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

        var display = new SpaceshipView();

        fsm.createState("playing")
            .add(Gun).withInstance(new Gun(60, 0, 0.5, 5))
            .add(GunControls).withInstance(new GunControls(KeyboardEvent.DOM_VK_SPACE))
            .add(Collision).withInstance(new Collision(40));

        fsm.createState("hurt")
            .add(TimeOutChangeState).withInstance(new TimeOutChangeState(1, fsm, "playing"))
            .add(Animation).withInstance(new Animation(display));


        fsm.changeState("playing");

        spaceship
            .add(new Player(fsm))
            .add(new Position(_config.width * 0.15, _config.height * 0.5, MathUtils.deg2rad(0)))
            .add(new Motion(0, 0, 0, 50))
            .add(new MotionControls(-1, -1, KeyboardEvent.DOM_VK_UP, KeyboardEvent.DOM_VK_DOWN, -1, 300, 0))
            .add(new Display(display))
            .add(new Audio());

        fsm.changeState("playing");

        _engine.addEntity(spaceship);

        return spaceship;
    }

    public function createRandomEnemy(posY:Float) {

        var rdm = Math.random();

        if (rdm < 0.33)
            createBasicEnemy(posY)
        else if (rdm < 0.66)
            createOneBulletEnemy(posY);
        else
            createThreesBulletEnemy(posY);
    }

    public function createBasicEnemy(posY):Entity {

        var enemy = new BasicEnemyEntity("", "Black", posY);

        _engine.addEntity(enemy);

        return enemy;
    }

    public function createOneBulletEnemy(posY):Entity {

        var enemy = new OneBulletEnemyEntity("", "Green", posY);

        _engine.addEntity(enemy);

        return enemy;
    }

    public function createThreesBulletEnemy(posY):Entity {

        var enemy = new ThreeBulletsEnemyEntity("", "Red", posY);

        _engine.addEntity(enemy);

        return enemy;
    }

    override public function createUserBullet(gun:Gun, parentPosition:Position, collisionCategories:UInt = 0):Entity {

        var bullet = super.createUserBullet(gun, parentPosition, collisionCategories);

        bullet
            .add(new Display(new BulletView("laserBlue01")))
            .add(new Motion(500, 0, 0, 0))
            .add(new KillOutOfScreen(true, false));

        _engine.addEntity(bullet);

        return bullet;
    }

    override public function createEnemyBullet(gun:Gun, parentPosition:Position, collisionCategories:UInt = 0):Entity {

        var bullet = super.createEnemyBullet(gun, parentPosition, collisionCategories);

        bullet
            .add(new Display(new BulletView("laserGreen16")))
            .add(new Motion(-400, 0, 0, 0))
            .add(new KillOutOfScreen(true, false));

        _engine.addEntity(bullet);

        return bullet;
    }

    public function createEnemyThreeBullets(gun:Gun, parentPosition:Position, collisionCategories:UInt, angle:Float):Entity {

        var cos = Math.cos(parentPosition.rotation);
        var sin = Math.sin(parentPosition.rotation);

        var bullet = new Entity()
            .add(new Bullet(gun.bulletLifetime, collisionCategories))
            .add(new Position(cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x, sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, angle))
            .add(new Collision(0))
            .add(new Display(new BulletView("laserRed08")))
            .add(new Motion(-300, angle * 5, 0, 0))
            .add(new KillOutOfScreen(true, false));

        _engine.addEntity(bullet);

        return bullet;
    }
}
