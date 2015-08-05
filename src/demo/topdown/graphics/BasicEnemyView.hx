package demo.topdown.graphics;

import citrus.math.MathUtils;

import pixi.core.display.Container;
import pixi.core.sprites.Sprite;
import pixi.core.textures.Texture;

class BasicEnemyView extends Container{

    public function new() {
        super();

        var display = new Sprite(Texture.fromImage("Enemies/enemyBlack5.png"));
        display.anchor.set(0.5);
        display.rotation = MathUtils.deg2rad(90); // the ship is oriented to the South, rotate to the West as expected by systems.

        addChild(display);
    }
}
