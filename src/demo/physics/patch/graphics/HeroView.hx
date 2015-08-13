package demo.physics.patch.graphics;

import citrus.graphics.AnimationData;
import citrus.graphics.AnimationSequence;

import pixi.core.display.Container;

class HeroView extends Container {

    public function new() {
        super();

        var anim = new AnimationSequence([new AnimationData("Patch/walk", true, 0.5), new AnimationData("Patch/idle",  0.5)], "Patch/idle");

        addChild(anim);
    }
}
