package demo.physics.patch.entities;

import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.components.Animation;
import citrus.components.Display;
import citrus.components.Motion;
import citrus.components.MotionControls;
import citrus.components.Physics;
import citrus.components.Player;
import citrus.components.Position;

import demo.physics.patch.graphics.HeroView;

import js.html.KeyboardEvent;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;

class Hero extends Entity {

    public var fsm:EntityStateMachine;
    public var display:HeroView;

    public function new(name:String = "", ?x:Float, ?y:Float) {
        super(name);

        fsm = new EntityStateMachine(this);

        display = new HeroView();

        var body = new Body(BodyType.DYNAMIC);
        body.shapes.add(new Polygon(Polygon.box(60, 120)));
        body.position.setxy(x, y);
        body.allowRotation = false;

        fsm.createState("playing")
            .add(MotionControls).withInstance(new MotionControls(KeyboardEvent.DOM_VK_LEFT, KeyboardEvent.DOM_VK_RIGHT, KeyboardEvent.DOM_VK_SPACE));

        this
            .add(new Player(fsm))
            .add(new Physics(body))
            .add(new Position())
            .add(new Motion(15, 300))
            .add(new Display(display))
            .add(new Animation(display));

        fsm.changeState("playing");
    }
}
