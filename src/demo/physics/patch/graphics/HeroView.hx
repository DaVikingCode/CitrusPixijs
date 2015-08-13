package demo.physics.patch.graphics;

import citrus.graphics.AnimationSequence;

import pixi.core.display.Container;

class HeroView extends Container {

    public function new() {
        super();

        var anim = new AnimationSequence(["Patch/walk", "Patch/idle"], "Patch/idle", 0.5);

        addChild(anim);
    }
}
