package;

import citrus.core.CitrusJS;

import demo.asteroids.Asteroids;
import demo.physics.patch.Patch;
import demo.topdown.TopDown;

import pixi.loaders.Loader;

class Main extends CitrusJS {

	public function new() {
		super();
		
		//_asteroidsDemo();
		//_topdownDemo();
		_patchDemo();
	}
	
	function _asteroidsDemo() {
		
		backgroundColor = 0x000000;
		autoResize = false;
		width = 800;
		height = 600;
		super.start();
		
		state = new Asteroids();
	}

	function _topdownDemo() {

		backgroundColor = 0x000000;
		autoResize = false;
		height = 750;
		super.start();

		var loader = new Loader();
		loader.baseUrl = "assets/spaceshooter/";
		loader.add("sprites", "Sprites.json");
		loader.load(function() {
			state = new TopDown();
		});
	}

	function _patchDemo() {

		backgroundColor = 0x000000;
		autoResize = false;
		width = 800;
		height = 450;
		super.start();

		var loader = new Loader();
		loader.baseUrl = "assets/patch/";
		loader.add("sprites", "Sprites.json");
		loader.load(function() {
			state = new Patch();
		});
	}

	static public function main() {
		new Main();
	}
}
