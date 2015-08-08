package demo.physics.patch.graphics;

import pixi.core.display.Container;
import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class BgView extends Container  {

    public function new() {
        super();

        var display = new Sprite(Texture.fromImage("background.jpg"));

        addChild(display);
    }
}
