package citrus.graphics;

import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import pixi.core.math.Point;

class SpaceshipDeathView extends Container implements IAnimatable {

    private var shape1:Graphics;
    private var shape2:Graphics;
    private var vel1:Point;
    private var vel2:Point;
    private var rot1:Float;
    private var rot2:Float;

    public function new() {
        super();

        shape1 = new Graphics();
        shape1.beginFill(0xFFFFFF);
        shape1.moveTo(10, 0);
        shape1.lineTo(-7, 7);
        shape1.lineTo(-4, 0);
        shape1.lineTo(10, 0);
        shape1.endFill();
        addChild(shape1);

        shape2 = new Graphics();
        shape2.beginFill(0xFFFFFF);
        shape2.moveTo(10, 0);
        shape2.lineTo(-7, -7);
        shape2.lineTo(-4, 0);
        shape2.lineTo(10, 0);
        shape2.endFill();
        addChild(shape2);

        vel1 = new Point( Math.random() * 10 - 5, Math.random() * 10 + 10 );
        vel2 = new Point( Math.random() * 10 - 5, -( Math.random() * 10 + 10 ) );

        rot1 = Math.random() * 300 - 150;
        rot2 = Math.random() * 300 - 150;
    }

    public function animate(time:Float):Void {
        shape1.x += vel1.x * time;
        shape1.y += vel1.y * time;
        shape1.rotation += rot1 * time;
        shape2.x += vel2.x * time;
        shape2.y += vel2.y * time;
        shape2.rotation += rot2 * time;
    }
}
