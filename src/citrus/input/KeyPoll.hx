package citrus.input;

import js.Browser;
import js.html.KeyboardEvent;

class KeyPoll {

    var _states:Map<Int, Bool>;

    public function new() {

        _states = new Map<Int, Bool>();
		
        Browser.document.onkeydown = keyDownListener;
        Browser.document.onkeyup = keyUpListener;
    }

    private function keyDownListener(ev:KeyboardEvent):Void
    {
        _states.set(ev.keyCode, true);
    }

    private function keyUpListener(ev:KeyboardEvent):Void
    {
        _states.set(ev.keyCode, false);
    }

    public function isDown(keyCode:Int):Bool {

        var result = _states.get(keyCode);

        return result == true;
    }

    public function isUp(keyCode:Int):Bool {

        var result = _states.get(keyCode);

        return result == false;
    }

    public function getKeysDown():Array<Int> {

        var keyCodes:Array<Int> = new Array<Int>();

        return keyCodes;
    }
}
