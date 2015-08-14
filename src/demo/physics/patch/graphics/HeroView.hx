package demo.physics.patch.graphics;

import citrus.graphics.AnimationData;
import citrus.graphics.AnimationSequence;

import pixi.core.display.Container;
import pixi.core.math.Point;

class HeroView extends Container {

    public function new() {
        super();

        var anim = new AnimationSequence([new AnimationData("Patch/walk", new Point(0.5), true, 0.5), new AnimationData("Patch/idle", new Point(0.5), 0.5)], "Patch/idle");

        addChild(anim);
    }
}
