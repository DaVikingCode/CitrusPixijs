package citrus.graphics;

interface IAnimatable {

	function animationStarted():Void;
	function animate(time:Float):Void;
	function animationEnded():Void;
	function changeAnimation(animation:String):Void;
	function flipX(invert:Bool):Void;
	function flipY(invert:Bool):Void;
}
