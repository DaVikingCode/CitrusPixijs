package net.richardlord.asteroids.graphics;

import pixi.core.graphics.Graphics;

class BulletView extends Graphics
{
    public function new()
    {
        super();
        beginFill(0xFFFFFF);
        drawCircle(0, 0, 2);
        endFill();
    }
}
