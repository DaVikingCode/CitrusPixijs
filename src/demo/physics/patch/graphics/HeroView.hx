package demo.physics.patch.graphics;

import citrus.graphics.AAnimatable;
import citrus.graphics.AnimationData;
import citrus.graphics.AnimationSequence;

import pixi.core.math.ObservablePoint;

class HeroView extends AAnimatable {

    var _anim:AnimationSequence;

    public function new() {
        super();

        _anim = new AnimationSequence([
            new AnimationData("Patch/walk", new ObservablePoint(0.5, 0.5), true, 0.5),
            new AnimationData("Patch/jump", new ObservablePoint(0.5, 0.5), 0.5),
            new AnimationData("Patch/idle", new ObservablePoint(0.5, 0.5), 0.5)],
        "Patch/idle");

        addChild(_anim);
    }

    override public function changeAnimation(animation:String) {

        _anim.changeAnimation("Patch/" + animation);
    }
}
