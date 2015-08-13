package citrus.graphics;

class AnimationData {

    public var name(default, null):String;
    public var loop(default, null):Bool;
    public var animationSpeed(default, null):Float;

    public function new(name:String, ?loop:Bool = false, ?animationSpeed:Float = 1) {

        this.name = name;
        this.loop = loop;
        this.animationSpeed = animationSpeed;
    }
}
