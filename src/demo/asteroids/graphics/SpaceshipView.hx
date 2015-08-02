package demo.asteroids.graphics;

import pixi.core.graphics.Graphics;

class SpaceshipView extends Graphics {

    public function new() {
        super();
        
        beginFill(0xFFFFFF);
        moveTo(10, 0);
        lineTo(-7, 7);
        lineTo(-4, 0);
        lineTo(-7, -7);
        lineTo(10, 0);
        endFill();
    }

}
