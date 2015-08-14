package citrus.graphics;

import pixi.core.display.Container;

class AAnimatable extends Container implements IAnimatable {

    public function new() {
        super();
    }

    public function animate(time:Float) {
    }

    public function animationStarted() {
    }

    public function animationEnded() {
    }

    public function changeAnimation(animation:String) {
    }

    public function flipX(invert:Bool) {

        scale.x = invert ? -1 : 1;
    }

    public function flipY(invert:Bool) {

        scale.y = invert ? -1 : 1;
    }
}
