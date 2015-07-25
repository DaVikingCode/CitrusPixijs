package;

import citrus.core.State;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class TestState extends State {
	
	var _bunny:Sprite;
	
	public function new() {
		super();
	}
	
	override public function initialize() {
		super.initialize();
		
		_bunny = new Sprite(Texture.fromImage("assets/bunny.png"));
		addChild(_bunny);
	}
	
	override public function onUpdate(elapsedTime:Float) {
		super.onUpdate(elapsedTime);
		
		_bunny.x += elapsedTime;
		_bunny.y += elapsedTime;
	}
}
