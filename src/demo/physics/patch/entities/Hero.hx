package demo.physics.patch.entities;

import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.components.Display;
import citrus.components.Player;
import citrus.components.Position;

import demo.physics.patch.graphics.HeroView;

class Hero extends Entity {

    public var fsm:EntityStateMachine;
    public var display:HeroView;

    public function new(name:String = "", ?x:Float, ?y:Float) {
        super(name);

        fsm = new EntityStateMachine(this);

        display = new HeroView();

        /*fsm.createState("playing")
            .add(DeathThroes).withInstance(new DeathThroes(0.5))*/

        this
            .add(new Player(fsm))
            .add(new Position(x, y, 0))
            .add(new Display(display));

        //fsm.changeState("playing");
    }
}
