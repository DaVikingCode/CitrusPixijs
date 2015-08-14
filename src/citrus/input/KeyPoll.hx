package citrus.input;

import js.Browser;
import js.html.KeyboardEvent;

class KeyPoll {

    inline static public var JUST_PRESSED = 0;
    inline static public var DOWN = 1;
    inline static public var JUST_RELEASED = 2;
    inline static public var UP = 3;

    var _keys:Map<Int, Int>;
    var _keysReleased:Array<Int>;

    public function new() {

        _keys = new Map<Int, Int>();
        _keysReleased = new Array<Int>();

        Browser.document.onkeydown = _keyDownListener;
        Browser.document.onkeyup = _keyUpListener;
    }

    public function destroy() {

        Browser.document.onkeydown = null;
        Browser.document.onkeyup = null;

        _keys = null;
        _keysReleased = null;
    }

    public function update() {

        for (key in _keys.keys())
            if (_keys.get(key) == JUST_PRESSED)
                _keys.set(key, DOWN);

        _keysReleased = [];
    }

    function _keyDownListener(kEvt:KeyboardEvent) {

        if (!_keys.exists(kEvt.keyCode))
            _keys.set(kEvt.keyCode, JUST_PRESSED);
    }

    function _keyUpListener(kEvt:KeyboardEvent) {

        _keys.remove(kEvt.keyCode);
        _keysReleased.push(kEvt.keyCode);
    }

    public function isDown(keyCode:Int):Bool {

        return _keys.get(keyCode) == DOWN;
    }

    public function justPressed(keyCode:Int):Bool {

        return _keys.get(keyCode) == JUST_PRESSED;
    }

    public function justReleased(keyCode:Int):Bool {

        return _keysReleased.indexOf(keyCode) != -1;
    }

    public function getState(keyCode:Int):UInt {

        if (_keys.exists(keyCode))
            return _keys.get(keyCode);

        else if (_keysReleased.indexOf(keyCode) != -1)
            return JUST_RELEASED;

        else
            return UP;
    }
}
