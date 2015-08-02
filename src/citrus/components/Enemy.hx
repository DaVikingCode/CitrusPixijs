package citrus.components;

import ash.fsm.EntityStateMachine;

class Enemy {

	public var fsm:EntityStateMachine;

	public function new(fsm:EntityStateMachine) {

		this.fsm = fsm;
	}
}