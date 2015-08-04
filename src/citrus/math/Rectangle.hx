package citrus.math;

class Rectangle extends pixi.core.math.shapes.Rectangle {

    /**
    * Calculates the intersection between two Rectangles.
    * @param rect1 The first rectangle to check intersection.
    * @param rect2 The second rectangle to check intersection.
    * @param result If supplied and the rectangles intersect, will be set to the calculated intersection rectangle.
    */
    static public function intersect(rect1:pixi.core.math.shapes.Rectangle, rect2:pixi.core.math.shapes.Rectangle, ?result:pixi.core.math.shapes.Rectangle):Bool {

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
