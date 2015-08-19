package demo.topdown.entities;

import citrus.components.Collision;
import citrus.components.Gun;
import citrus.components.GunControls;
import citrus.components.KillOutOfScreen;
import citrus.components.Motion;

class OneBulletEnemyEntity extends BasicEnemyEntity {

    public function new(name:String = "", color:String = "", posY:Float = 0) {
        super(name, color, posY);
    }

    override function _addPlayingState() {
        super._addPlayingState();

        fsm.createState("playing")
            .add(Collision).withInstance(new Collision(50))
            .add(Motion).withInstance(new Motion(-250))
            .add(KillOutOfScreen).withInstance(new KillOutOfScreen(true, false))
            .add(Gun).withInstance(new Gun(-60, 0, 2, 5, true))
            .add(GunControls).withInstance(new GunControls());
    }
}
