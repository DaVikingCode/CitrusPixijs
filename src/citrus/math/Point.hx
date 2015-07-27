package citrus.math;

class Point extends pixi.core.math.Point {

	static public function distance(pt1:pixi.core.math.Point, pt2:pixi.core.math.Point):Float {

		var resultX = pt2.x - pt1.x;
		resultX *= resultX;

		var resultY = pt2.y - pt1.y;
		resultY *= resultY;

		return Math.sqrt(resultX + resultY);
	}
}