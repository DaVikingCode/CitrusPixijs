package citrus.components;

import citrus.core.CitrusJS;
import citrus.math.Rectangle;

import pixi.core.math.Point;

class Camera {

    /**
     * The thing that the camera will follow.
     */
    public var target:Point;

    /**
     * The distance from the top-left corner of the screen that the camera should offset the target.
     */
    public var offset:Point;

    /**
     * A rectangle specifying the minimum and maximum area that the camera is allowed to follow the target in.
     */
    public var bounds:Rectangle;

    /**
     * A value between 0 and 1 that specifies the speed at which the camera catches up to the target.
     * 0 makes the camera not follow the target at all and 1 makes the camera follow the target exactly.
     */
    public var easing = new Point(0.25, 0.05);

    /**
     * The width of the visible game screen. This will usually be the same as your stage width unless your game has a border.
     */
    public var lensWidth(default, null):Float;

    /**
     * The height of the visible game screen. This will usually be the same as your stage width unless your game has a border.
     */
    public var lensHeight(default, null):Float;

    public function new(target:Point, offset:Point, bounds:Rectangle, easing:Point = null) {

        this.target = target;
        this.offset = offset;
        this.bounds = bounds;

        if (easing != null)
            this.easing = easing;

        this.lensWidth = CitrusJS.getInstance().width;
        this.lensHeight = CitrusJS.getInstance().height;
    }
}
