package citrus.components;

import ash.fsm.EntityStateMachine;

class TimeOutChangeState {

    public var timeout:Float;
    public var fsm:EntityStateMachine;
    public var state:String;

    var _timeout:Float;

    public function new(timeout:Float, fsm:EntityStateMachine, state:String) {

        this.timeout = _timeout = timeout;
        this.fsm = fsm;
        this.state = state;
    }

    public function resetTimeout() {

        timeout = _timeout;
    }
}
