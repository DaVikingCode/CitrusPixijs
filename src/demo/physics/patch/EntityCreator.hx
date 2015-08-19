package demo.physics.patch;

import ash.core.Engine;
import ash.core.Entity;

import citrus.components.Animation;
import citrus.components.Camera;
import citrus.components.Display;
import citrus.components.physics.Nape;
import citrus.components.physics.OneWay;
import citrus.components.physics.Physics;
import citrus.components.Position;
import citrus.core.AEntityCreator;
import citrus.math.Rectangle;
import citrus.physics.NapeDebugView;

import demo.physics.patch.entities.Hero;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Circle;
import nape.shape.Polygon;

import pixi.core.math.Point;
import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class EntityCreator extends AEntityCreator {

    public function new(engine:Engine) {
        super(engine);
    }

    public function createGame() {

        var bg = new Entity()
            .add(new Position())
            .add(new Display(new Sprite(Texture.fromImage("background.jpg"))));

        _engine.addEntity(bg);

        var nape = new Entity()
            .add(new Nape(new Vec2(0, 450)));

        _engine.addEntity(nape);

        var napeDebugView = new NapeDebugView(nape.get(Nape).space);

        var napeDebug = new Entity()
            .add(new Position())
            .add(new Display(napeDebugView))
            .add(new Animation(napeDebugView));

        _engine.addEntity(napeDebug);

        var floorMaterial = new Material(0.65, 0.57, 1.2, 1, 0);
        floorMaterial.elasticity = 0;
        var floorBody = new Body(BodyType.STATIC);
        floorBody.shapes.add(new Polygon(Polygon.rect(0, 380, 1000, 50), floorMaterial));

        var floor = new Entity()
            .add(new Physics(floorBody))
            .add(new Position());

        _engine.addEntity(floor);

        var dball = new Sprite(Texture.fromImage("assets/ball.png"));
        dball.anchor.set(0.5, 0.5);

        var pball = new Body(BodyType.DYNAMIC);
        pball.shapes.add(new Circle(10));
        pball.position.setxy(300, 100);

        var ball = new Entity()
            .add(new Physics(pball))
            .add(new Display(dball))
            .add(new Position());

        _engine.addEntity(ball);

        var hero = new Hero(50, 100);
        _engine.addEntity(hero);

        var oneWayBody = new Body(BodyType.STATIC);
        oneWayBody.shapes.add(new Polygon(Polygon.rect(1015, 240, 180, 20), floorMaterial));

        var oneWay = new Entity()
            .add(new Physics(oneWayBody))
            .add(new OneWay(false, false, false, false))
            .add(new Position());

        _engine.addEntity(oneWay);

        var floor2Body = new Body(BodyType.STATIC);
        floor2Body.shapes.add(new Polygon(Polygon.rect(960, 340, 580, 30), floorMaterial));

        var floor2 = new Entity()
            .add(new Physics(floor2Body))
            .add(new Position());

        _engine.addEntity(floor2);

        var camera = new Entity()
            .add(new Camera(hero.get(Position).position, new Point(320, 315), new Rectangle(0, 0, 1550, 450), new Point(0.25, 0.05)));

        _engine.addEntity(camera);
    }
}