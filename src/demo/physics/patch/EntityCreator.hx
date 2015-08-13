package demo.physics.patch;

import ash.core.Engine;
import ash.core.Entity;

import citrus.components.Display;
import citrus.components.Nape;
import citrus.components.physics.OneWay;
import citrus.components.Physics;
import citrus.components.Position;
import citrus.core.AEntityCreator;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class EntityCreator extends AEntityCreator {

    public function new(engine:Engine) {
        super(engine);
    }

    public function createGame() {

        var bg = new Entity()
            .add(new Position(0, 0, 0))
            .add(new Display(new Sprite(Texture.fromImage("background.jpg"))));

        _engine.addEntity(bg);

        var nape = new Entity()
            .add(new Nape(new Vec2(0, 450)));

        _engine.addEntity(nape);

        var floorBody = new Body(BodyType.STATIC);
        floorBody.shapes.add(new Polygon(Polygon.rect(0, 400, 800, 50)));

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

        var oneWayBody = new Body(BodyType.STATIC);
        oneWayBody.shapes.add(new Polygon(Polygon.rect(0, 200, 800, 50)));

        var oneWay = new Entity()
            .add(new Physics(oneWayBody))
            .add(new OneWay(false, false, true))
            .add(new Position());

        _engine.addEntity(oneWay);
    }
}