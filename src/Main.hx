package;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;
import pixi.loaders.Loader;
import pixi.plugins.app.Application;
import haxe.Timer;

import citrus.core.CitrusJS;

class Main extends CitrusJS {

	public function new() {
		super();
		_init();
	}

	function _init() {
		backgroundColor = 0x6699FF;
		autoResize = false;
		width = 800;
		height = 600;
		super.start();

		var loader = new Loader();
		loader.baseUrl = "assets/spaceshooter/";
		loader.add("sprites", "Sprites.json");
		loader.load(function() {
			state = new TestState();
		});
		
	}
	
	public static function main() {
		new Main();
	}
}
