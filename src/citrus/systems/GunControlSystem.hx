package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.nodes.GunControlNode;

import howler.Howl;

class GunControlSystem extends ListIteratingSystem<GunControlNode> {

	var _keyPoll:KeyPoll;
	var _creator:EntityCreator;

	public function new(keyPoll:KeyPoll, creator:EntityCreator) {
		super(GunControlNode, _updateNode);

		_keyPoll = keyPoll;
		_creator = creator;
	}

	function _updateNode(node:GunControlNode, time:Float) {

		var control = node.control;
		var position = node.position;
		var gun = node.gun;

		gun.shooting = _keyPoll.isDown(control.trigger);
		gun.timeSinceLastShot += time;

		if (gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval) {

			_creator.createUserBullet(gun, position);

			var options:HowlOptions = {};
			options.urls = ["assets/spaceshooter/sound/sfx_laser1.ogg"];

			node.audio.play(options);
			
			gun.timeSinceLastShot = 0;
		}
	}
}