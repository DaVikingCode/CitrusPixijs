package citrus.graphics;

import pixi.core.math.Point;

class AnimationData {

    public var name(default, null):String;
    public var anchor(default, null):Point;
    public var loop(default, null):Bool;
    public var animationSpeed(default, null):Float;

    public function new(name:String, anchor:Point, ?loop:Bool = false, ?animationSpeed:Float = 1) {

        this.name = name;
        this.anchor = anchor;
        this.loop = loop;
        this.animationSpeed = animationSpeed;
    }
}
