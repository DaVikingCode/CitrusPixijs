package citrus.math;

class MathUtils {

	static public function randomInt(min:Int, max:Int):Int {

		return Math.floor(Math.random() * (1 + max - min)) + min;
	}
}