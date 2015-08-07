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

import demo.topdown.graphics.EnemyView;

class BasicEnemyEntity extends Entity {

    public var fsm:EntityStateMachine;
    public var display:EnemyView;

    public function new(name:String = "", color:String = "", posY:Float = 0) {
        super(name);

        fsm = new EntityStateMachine(this);

        display = new EnemyView(color);

        var ce = CitrusJS.getInstance();

        _addPlayingState();

        fsm.createState("destroyed")
            .add(DeathThroes).withInstance(new DeathThroes(0.5))
            .add(Animation).withInstance(new Animation(display));

        this
            .add(new Enemy(fsm))
            .add(new Position(ce.width, posY, 0))
            .add(new Audio())
            .add(new Display(display));

        fsm.changeState("playing");
    }

    function _addPlayingState() {

        fsm.createState("playing")
            .add(Collision).withInstance(new Collision(50))
            .add(Motion).withInstance(new Motion(-450, 0, 0, 0))
            .add(KillOutOfScreen).withInstance(new KillOutOfScreen(true, false));
    }
}
