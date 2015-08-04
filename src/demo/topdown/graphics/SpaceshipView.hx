package demo.topdown.graphics;

import citrus.math.MathUtils;

import pixi.core.display.Container;
import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class SpaceshipView extends Container {

    public function new() {
        super();

        var display = new Sprite(Texture.fromImage("playerShip1_blue.png"));
        display.anchor.set(0.5);
        display.rotation = MathUtils.deg2rad(90); // the ship is oriented to the North, rotate to the East as expected by systems.

        addChild(display);
    }
}
