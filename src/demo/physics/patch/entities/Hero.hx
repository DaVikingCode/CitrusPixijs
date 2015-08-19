package demo.physics.patch.entities;

import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.components.Animation;
import citrus.components.Display;
import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.physics.Physics;
import citrus.components.Player;
import citrus.components.Position;

import demo.physics.patch.graphics.HeroView;

import js.html.KeyboardEvent;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;

class Hero extends Entity {

    public var fsm:EntityStateMachine;
    public var display:HeroView;

    public function new(name:String = "", ?x:Float, ?y:Float) {
        super(name);

        fsm = new EntityStateMachine(this);

        display = new HeroView();

        var material = new Material(0.65, 0.57, 1.2, 1, 0);
        material.staticFriction = 0;
        material.elasticity = 0;

        var body = new Body(BodyType.DYNAMIC);
        body.shapes.add(new Polygon(Polygon.box(60, 120), material));
        body.position.setxy(x, y);
        body.allowRotation = false;

        fsm.createState("playing")
            .add(MotionControls).withInstance(new MotionControls(KeyboardEvent.DOM_VK_LEFT, KeyboardEvent.DOM_VK_RIGHT, KeyboardEvent.DOM_VK_SPACE));

        this
            .add(new Player(fsm))
            .add(new Physics(body))
            .add(new Position())
            .add(new Motion(30, 330))
            .add(new Display(display))
            .add(new Animation(display));

        fsm.changeState("playing");
    }
}
