package citrus.systems;

import citrus.components.Enemy;
import ash.tools.ListIteratingSystem;

import citrus.core.AEntityCreator;
import citrus.components.Audio;
import citrus.components.Player;
import citrus.input.KeyPoll;
import citrus.nodes.GunControlNode;

import howler.Howl;

class GunControlSystem extends ListIteratingSystem<GunControlNode> {

	var _keyPoll:KeyPoll;
	var _creator:AEntityCreator;
	var _sound:HowlOptions;

	public function new(keyPoll:KeyPoll, creator:AEntityCreator, ?sound:HowlOptions) {
		super(GunControlNode, _updateNode, _addNode);

		_keyPoll = keyPoll;
		_creator = creator;
		_sound = sound;
	}

	function _addNode(node:GunControlNode) {

		if (node.gun.shootAtStart)
			_shoot(node);
	}

	function _updateNode(node:GunControlNode, time:Float) {

		var control = node.control;
		var position = node.position;
		var gun = node.gun;

		gun.shooting = (control.trigger == -1 ? true : _keyPoll.isDown(control.trigger));
		gun.timeSinceLastShot += time;

		if (gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval) {

			_shoot(node);

			gun.timeSinceLastShot = 0;
		}
	}

	function _shoot(node:GunControlNode) {

		if (node.entity.has(Player))
			_creator.createUserBullet(node.gun, node.position);

		else if (node.entity.has(Enemy))
			_creator.createEnemyBullet(node.gun, node.position);


		if (_sound != null)
			node.entity.get(Audio).play(_sound);
	}
}