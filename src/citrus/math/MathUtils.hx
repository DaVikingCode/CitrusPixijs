package citrus.math;

class MathUtils {
	
	static var _deg2rad = Math.PI / 180;
	static var _rad2deg = 180 / Math.PI;

	static public function randomInt(min:Int, max:Int):Int {

		return Math.floor(Math.random() * (1 + max - min)) + min;
	}
	
	static inline public function deg2rad(value:Float):Float {
		
		return value * _deg2rad;
	}
	
	static inline public function rad2deg(value:Float):Float {
		
		return value * _rad2deg;
	}
}