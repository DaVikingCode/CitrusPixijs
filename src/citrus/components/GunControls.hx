package citrus.components;

class GunControls {

	public var trigger(default, null):Int;

	public function new(trigger:Int = -1) {

		this.trigger = trigger;
	}
}