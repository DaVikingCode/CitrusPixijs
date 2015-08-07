package demo.topdown.graphics;

import citrus.graphics.IAnimatable;
import citrus.math.MathUtils;

import pixi.core.display.Container;
import pixi.core.sprites.Sprite;
import pixi.core.textures.Texture;

class EnemyView extends Container implements IAnimatable {

    public function new(color:String) {
        super();

        var display = new Sprite(Texture.fromImage("Enemies/enemy" + color + MathUtils.randomInt(1, 5) + ".png"));
        display.anchor.set(0.5);
        display.rotation = MathUtils.deg2rad(90); // the ship is oriented to the South, rotate to the West as expected by systems.

        addChild(display);
    }

    public function animate(time:Float) {

        alpha -= time * 5;
    }

    public function animationStarted() {
    }

    public function animationEnded() {
    }
}
