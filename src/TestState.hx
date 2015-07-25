package;

import ash.core.Engine;

import citrus.core.State;
import citrus.systems.GameManager;
import citrus.systems.RenderSystem;
import citrus.systems.SystemPriorities;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class TestState extends State {
	
	var _engine:Engine;
	var _config:GameConfig;
	var _creator:EntityCreator;
	
	public function new() {
		super();
	}
	
	override public function initialize() {
		super.initialize();
		
		_engine = new Engine();
		_config = new GameConfig();
		_config.width = width;//_citrusJS.width;
		_config.height = height;//_citrusJS.height;
		_creator = new EntityCreator(_engine, _config);

		_engine.addSystem(new GameManager(_creator, _config), SystemPriorities.preUpdate);
		_engine.addSystem(new RenderSystem(this), SystemPriorities.render);

		_creator.createGame();
	}
	
	override public function onUpdate(elapsedTime:Float) {
		super.onUpdate(elapsedTime);

		_engine.update(elapsedTime);
	}
}
