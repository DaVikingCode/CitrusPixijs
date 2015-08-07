package citrus.graphics;

interface IAnimatable {

	function animationStarted():Void;
	function animate(time:Float):Void;
	function animationEnded():Void;
}
