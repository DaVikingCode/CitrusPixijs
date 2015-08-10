package citrus.components;

import nape.geom.Vec2;
import nape.space.Broadphase;
import nape.space.Space;

class Nape {

    public var space(default, null):Space;
    public var gravity:Vec2;
    public var broadphase:Broadphase;
    public var deltaTime:Float;
    public var velocityIterations:Int;
    public var positionIterations:Int;

    public function new(?gravity:Vec2, ?broadphase:Broadphase, deltaTime = 1 /60, velocityIterations = 10, positionIterations = 10) {

        this.gravity = gravity;
        this.broadphase = broadphase;
        this.deltaTime = deltaTime;
        this.velocityIterations = velocityIterations;
        this.positionIterations = positionIterations;

        space = new Space(this.gravity, this.broadphase);
    }
}
