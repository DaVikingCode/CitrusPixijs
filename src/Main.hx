package;

import demo.asteroids.Asteroids;
import demo.topdown.TopDown;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;
import pixi.loaders.Loader;
import pixi.plugins.app.Application;

import citrus.core.CitrusJS;

class Main extends CitrusJS {

	public function new() {
		super();
		
		//_asteroidsDemo();
		_topdownDemo();
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
		width = 800;
		height = 600;
		super.start();

		var loader = new Loader();
		loader.baseUrl = "assets/spaceshooter/";
		loader.add("sprites", "Sprites.json");
		loader.load(function() {
			state = new TopDown();
		});
	}

	static public function main() {
		new Main();
	}
}
