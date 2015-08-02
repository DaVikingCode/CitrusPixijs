package citrus.systems;

import ash.tools.ListIteratingSystem;

import citrus.core.AEntityCreator;
import citrus.nodes.GunControlNode;

import demo.asteroids.KeyPoll;

import howler.Howl;

class GunControlSystem extends ListIteratingSystem<GunControlNode> {

	var _keyPoll:KeyPoll;
	var _creator:AEntityCreator;
	var _sound:HowlOptions;

	public function new(keyPoll:KeyPoll, creator:AEntityCreator, ?sound:HowlOptions) {
		super(GunControlNode, _updateNode);

		_keyPoll = keyPoll;
		_creator = creator;
		_sound = sound;
	}

	function _updateNode(node:GunControlNode, time:Float) {

		var control = node.control;
		var position = node.position;
		var gun = node.gun;

		gun.shooting = _keyPoll.isDown(control.trigger);
		gun.timeSinceLastShot += time;

		if (gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval) {

			_creator.createUserBullet(gun, position);
			
			if (_sound != null)
				node.audio.play(_sound);
			
			gun.timeSinceLastShot = 0;
		}
	}
}