package demo.asteroids.graphics;

import citrus.graphics.IAnimatable;

import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import pixi.core.math.Point;

class AsteroidDeathView extends Container implements IAnimatable {

	static inline var _numDots = 8;

	var _dots:Array<Dot>;

	public function new(radius:Float) {
		super();

		_dots = new Array<Dot>();

		for (i in 0..._numDots) {

			var dot = new Dot(radius);
			addChild(dot.image);
			_dots.push(dot);
		}
	}

	public function animate(time:Float) {

		for (dot in _dots) {

			dot.image.x += dot.velocity.x * time;
			dot.image.y += dot.velocity.y * time;
		}
	}
}


class Dot {

	public var velocity:Point;
	public var image:Graphics;

	public function new(maxDistance:Float) {

		image = new Graphics();
		image.beginFill(0xFFFFFF);
		image.drawCircle(0, 0, 1);
		image.endFill();

		var angle = Math.random() * 2 * Math.PI;
		var distance = Math.random() * maxDistance;

		image.x = Math.cos(angle) * distance;
		image.y = Math.sin(angle) * distance;

		var speed = Math.random() * 10 + 10;
		velocity = new Point(Math.cos(angle) * speed, Math.sin(angle) * speed);
	}
}