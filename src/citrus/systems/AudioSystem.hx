package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.nodes.AudioNode;

import howler.Howl;

class AudioSystem extends ListIteratingSystem<AudioNode> {

	public function new () {
		super(AudioNode, _updateNode);
	}

	function _updateNode(node:AudioNode, time:Float) {

		for (howlOptions in node.audio.toPlay) {

			var snd = new Howl(howlOptions);
			snd.play();
		}


		node.audio.toPlay.splice(0, node.audio.toPlay.length);
	}
}