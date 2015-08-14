package citrus.components;

import citrus.core.CitrusJS;
import citrus.math.Rectangle;

import pixi.core.math.Point;

class Camera {

    public var target:Point;
    public var bounds:Rectangle;
    public var offset:Point;
    public var easing:Point;
    public var lensWidth(default, null):Float;
    public var lensHeight(default, null):Float;

    public function new(target:Point, offset:Point, bounds:Rectangle, easing:Point) {

        this.target = target;
        this.offset = offset;
        this.bounds = bounds;
        this.easing = easing;

        this.lensWidth = CitrusJS.getInstance().width;
        this.lensHeight = CitrusJS.getInstance().height;
    }
}
