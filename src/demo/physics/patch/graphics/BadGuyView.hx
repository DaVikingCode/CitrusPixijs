package demo.physics.patch.graphics;

import citrus.graphics.AAnimatable;
import citrus.graphics.AnimationData;
import citrus.graphics.AnimationSequence;

import pixi.core.math.ObservablePoint;

class BadGuyView extends AAnimatable {

    var _anim:AnimationSequence;

    public function new() {
        super();

        _anim = new AnimationSequence([
            new AnimationData("Monster/walk", new ObservablePoint(0.5, 0.5), true, 0.5),
            new AnimationData("Monster/die", new ObservablePoint(0.5, 0.5), 0.5)],
        "Monster/walk");

        addChild(_anim);
    }

    override public function changeAnimation(animation:String) {

        _anim.changeAnimation("Monster/" + animation);
    }
}
