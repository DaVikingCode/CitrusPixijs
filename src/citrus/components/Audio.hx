package citrus.components;

import howler.Howl;

class Audio {

	public var toPlay = new Array<HowlOptions>();

	public function new() {
	}

	@:keep
	public function play(sound:HowlOptions) {

		toPlay.push(sound);
	}
}