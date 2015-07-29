package citrus.graphics;

import pixi.core.graphics.Graphics;

class AsteroidView extends Graphics {

    public function new(radius:Float) {
        super();

        var angle:Float = 0;
        beginFill(0xFFFFFF);
        moveTo(radius, 0);

        while (angle < Math.PI * 2) {

            var length:Float = (0.75 + Math.random() * 0.25) * radius;
            var posX:Float = Math.cos(angle) * length;
            var posY:Float = Math.sin(angle) * length;
            lineTo(posX, posY);
            angle += Math.random() * 0.5;
        }
        
        lineTo(radius, 0);
        endFill();
    }
}
