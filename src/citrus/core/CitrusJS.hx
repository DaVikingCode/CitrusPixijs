package citrus.core;

import js.Browser;
import js.html.Event;

import pixi.plugins.app.Application;

class CitrusJS extends Application {
	
	public static var instance(default, null):CitrusJS;

	public var playing = true;

	public var scene(get, set):Scene;
	var _scene:Scene;
	
	var _newScene:Scene;
	var _supportBrowserFocusEvent = true;

	public function new() {
		super();
		
		instance = this;

		onUpdate = _onUpdate;

		if (_supportBrowserFocusEvent) {
			Browser.window.onfocus = _windowGetFocus;
			Browser.window.onblur = _windowLostFocus;
		}
	}

	function _windowGetFocus(evt:Event) {

		playing = true;
	}

	function _windowLostFocus(evt:Event) {

		playing = false;
	}
	
	function get_scene():Scene
	{	
		if (_newScene != null)
			return _newScene;
		
		return _scene;
	}
	
	function set_scene(value:Scene):Scene
	{	
		return _newScene = value;
	}
	
	function _onUpdate(elapsedTime:Float)
	{	
		if (_newScene != null) {
			
			if (_scene != null) {

				_scene.dispose();
				stage.removeChild(_scene);
			}

			_scene = _newScene;
			_newScene = null;
			
			stage.addChild(_scene);
			_scene.initialize();
		}
		
		if (_scene != null && playing) {

			_scene.onUpdate(elapsedTime / 60);
		}
	}
}
