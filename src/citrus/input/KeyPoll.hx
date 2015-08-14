package citrus.input;

import js.Browser;
import js.html.KeyboardEvent;

class KeyPoll {

    var _states:Map<Int, Bool>;

    public function new() {

        _states = new Map<Int, Bool>();
		
        Browser.document.onkeydown = _keyDownListener;
        Browser.document.onkeyup = _keyUpListener;
    }

    public function destroy() {

        Browser.document.onkeydown = null;
        Browser.document.onkeyup = null;

        _states = null;
    }

    function _keyDownListener(kEvt:KeyboardEvent) {

        _states.set(kEvt.keyCode, true);
    }

    function _keyUpListener(kEvt:KeyboardEvent) {

        _states.set(kEvt.keyCode, false);
    }

    public function isDown(keyCode:Int):Bool {

        return _states.get(keyCode);
    }

    public function isUp(keyCode:Int):Bool {

        var result = _states.get(keyCode);

        return result == false;
    }

    public function getKeysDown():Array<Int> {

        var keyCodes:Array<Int> = new Array<Int>();

        for (key in _states.keys())
            if (isDown(key))
                keyCodes.push(key);

        return keyCodes;
    }
}
