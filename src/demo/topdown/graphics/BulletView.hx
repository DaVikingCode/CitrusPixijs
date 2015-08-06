package demo.topdown.graphics;

import citrus.math.MathUtils;

import pixi.core.display.Container;
import pixi.core.sprites.Sprite;
import pixi.core.textures.Texture;

class BulletView extends Container {

    public function new(laserName:String) {
        super();

        var display = new Sprite(Texture.fromImage("Lasers/" + laserName + ".png"));
        display.anchor.set(0.5);
        display.rotation = MathUtils.deg2rad(90); // the ship is oriented to the North, rotate to the East as expected by systems.

        addChild(display);
    }
}
