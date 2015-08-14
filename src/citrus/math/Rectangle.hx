package citrus.math;

class Rectangle extends pixi.core.math.shapes.Rectangle {

    public var left:Float;
    public var right:Float;
    public var top:Float;
    public var bottom:Float;

    public function new(x:Float, y:Float, width:Float, height:Float) {
        super(x, y, width, height);

        left = x;
        right = x + width;
        top = y;
        bottom = y + height;
    }

    public function set(x:Float, y:Float, width:Float, height:Float) {

        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }

    /**
    * Calculates the intersection between two Rectangles.
    * @param rect1 The first rectangle to check intersection.
    * @param rect2 The second rectangle to check intersection.
    * @param result If supplied and the rectangles intersect, will be set to the calculated intersection rectangle.
    */
    static public function intersect(rect1:Rectangle, rect2:Rectangle, ?result:Rectangle):Bool {

        var left = rect1.x > rect2.x ? rect1.x : rect2.x;
        var right = rect1.right < rect2.right ? rect1.right : rect2.right;

        if (left > right)
            return false;

        var top = rect1.y > rect2.y ? rect1.y : rect2.y;
        var bottom = rect1.bottom < rect2.bottom ? rect1.bottom : rect2.bottom;

        if (top > bottom)
            return false;

        if (result != null)
            result.set(left, top, right - left, bottom - top);

        return true;
    }
}
