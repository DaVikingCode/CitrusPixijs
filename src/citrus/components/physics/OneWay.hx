package citrus.components.physics;

class OneWay {

    public var left:Bool;
    public var right:Bool;
    public var top:Bool;
    public var bottom:Bool;

    public function new(left:Bool = false, right:Bool = false, top:Bool = false, bottom:Bool = false) {

        this.left = left;
        this.right = right;
        this.top = top;
        this.bottom = bottom;
    }
}
