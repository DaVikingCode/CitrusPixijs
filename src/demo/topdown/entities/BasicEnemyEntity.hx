package demo.topdown.entities;

import ash.core.Entity;
import ash.fsm.EntityStateMachine;

import citrus.components.Animation;
import citrus.components.Audio;
import citrus.components.Collision;
import citrus.components.DeathThroes;
import citrus.components.Display;
import citrus.components.Enemy;
import citrus.components.KillOutOfScreen;
import citrus.components.Motion;
import citrus.components.Position;
import citrus.core.CitrusJS;

import demo.topdown.graphics.BasicEnemyView;

class BasicEnemyEntity extends Entity {

    public var fsm:EntityStateMachine;
    public var display:BasicEnemyView;

    public function new(name:String = "", color:String = "") {
        super(name);

        fsm = new EntityStateMachine(this);

        display = new BasicEnemyView(color);

        var ce = CitrusJS.getInstance();

        _addPlayingState();

        fsm.createState("destroyed")
            .add(DeathThroes).withInstance(new DeathThroes(0.5))
            .add(Animation).withInstance(new Animation(display));

        this
            .add(new Enemy(fsm))
            .add(new Position(ce.width, 50 + Math.random() * (ce.height - 50), 0))
            .add(new Audio())
            .add(new Display(display));

        fsm.changeState("playing");
    }

    function _addPlayingState() {

        fsm.createState("playing")
            .add(Collision).withInstance(new Collision(50))
            .add(Motion).withInstance(new Motion(-250, 0, 0, 0))
            .add(KillOutOfScreen).withInstance(new KillOutOfScreen(true, false));
    }
}
