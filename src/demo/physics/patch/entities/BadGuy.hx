package demo.physics.patch.entities;

import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.components.Animation;
import citrus.components.Direction;
import citrus.components.Display;
import citrus.components.Motion;
import citrus.components.physics.Physics;
import citrus.components.Enemy;
import citrus.components.Position;

import demo.physics.patch.graphics.BadGuyView;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;

class BadGuy extends Entity {

    public var fsm:EntityStateMachine;
    public var display:BadGuyView;

    public function new(name:String = "", ?x:Float, ?y:Float) {
        super(name);

        fsm = new EntityStateMachine(this);

        display = new BadGuyView();

        var material = new Material(0.65, 0.57, 1.2, 1, 0);
        material.staticFriction = 0;
        material.elasticity = 0;

        var body = new Body(BodyType.DYNAMIC);
        body.shapes.add(new Polygon(Polygon.box(60, 70), material));
        body.position.setxy(x, y);
        body.allowRotation = false;

        fsm.createState("walking");

        this
            .add(new Enemy(fsm))
            .add(new Physics(body))
            .add(new Position())
            .add(new Motion(-20, 0, 200))
            .add(new Direction(false, true))
            .add(new Display(display))
            .add(new Animation(display));

        fsm.changeState("walking");
    }
}
