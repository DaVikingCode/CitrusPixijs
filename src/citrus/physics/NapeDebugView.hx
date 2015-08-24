package citrus.physics;

import citrus.graphics.AAnimatable;

import nape.space.Space;

import pixi.core.graphics.Graphics;

/**
* A dummy Nape debug view
**/
class NapeDebugView extends AAnimatable {

    var _space:Space;
    var _graphics:Graphics;

    public function new(space:Space) {
        super();

        _space = space;

        _graphics = new Graphics();
        addChild(_graphics);
    }

    override public function animate(time:Float) {

       _graphics.clear();

        _graphics.beginFill(0x00FF00, 0.3);
        _graphics.lineStyle(2, 0xFFFF00, 0.8);

        for (body in _space.bodies) {

            var bounds = body.shapes.at(0).bounds;

            _graphics.moveTo(bounds.x, bounds.y);
            _graphics.lineTo(bounds.x + bounds.width, bounds.y);
            _graphics.lineTo(bounds.x + bounds.width, bounds.y + bounds.height);
            _graphics.lineTo(bounds.x, bounds.y + bounds.height);

            //_graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
        }

       _graphics.endFill();
    }
}