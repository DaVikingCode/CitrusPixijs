package citrus.core;

import js.Browser;
import js.html.Event;

import pixi.plugins.app.Application;

class CitrusJS extends Application {
	
	static var _instance:CitrusJS;

	public var playing = true;

	public var state(get, set):State;
	var _state:State;
	
	var _newState:State;
	var _supportBrowserFocusEvent = true;

	public function new() {
		super();
		
		_instance = this;

		onUpdate = _onUpdate;

		if (_supportBrowserFocusEvent) {
			Browser.window.onfocus = _windowGetFocus;
			Browser.window.onblur = _windowLostFocus;
		}
	}

	static public function getInstance():CitrusJS {

		return _instance;
	}

	function _windowGetFocus(evt:Event) {

		playing = true;
	}

	function _windowLostFocus(evt:Event) {

		playing = false;
	}
	
	function get_state():State {
		
		if (_newState != null)
			return _newState;
		else
			return _state;
	}
	
	function set_state(value:State):State {
		
		return _newState = value;
	}
	
	function _onUpdate(elapsedTime:Float) {
		
		if (_newState != null) {
			
			if (_state != null) {
				
				_state.destroy();
				_stage.removeChild(_state);
			}
			
			_state = _newState;
			_newState = null;
			
			_stage.addChild(_state);
			_state.initialize();
		}
		
		if (_state != null && playing) {
			
			_state.onUpdate(elapsedTime);
		}
	}
}
