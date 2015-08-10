package demo.physics.patch;

import ash.core.Engine;
import ash.core.Entity;

import citrus.components.Display;
import citrus.components.Position;
import citrus.core.AEntityCreator;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class EntityCreator extends AEntityCreator {

    public function new(engine:Engine) {
        super(engine);
    }

    public function createGame() {

        var bg = new Entity()
            .add(new Position(0, 0, 0))
            .add(new Display(new Sprite(Texture.fromImage("background.jpg"))));

        _engine.addEntity(bg);
    }
}