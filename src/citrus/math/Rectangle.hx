package citrus.math;

class Rectangle extends pixi.core.math.shapes.Rectangle {

    @:isVar public var left(get, null):Float;
    @:isVar public var right(get, null):Float;
    @:isVar public var top(get, null):Float;
    @:isVar public var bottom(get, null):Float;

    public function set(x:Float, y:Float, width:Float, height:Float) {

        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }

    public function get_left():Float {

        return left = x;
    }

    public function get_right():Float {

        return right = x + width;
    }

    public function get_top():Float {

        return top = y;
    }

    public function get_bottom():Float {

        return bottom = y + height;
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
