package;

import ash.core.Engine;

import citrus.core.State;

import net.richardlord.asteroids.EntityCreator;
import net.richardlord.input.KeyPoll;
import net.richardlord.asteroids.GameConfig;
import net.richardlord.asteroids.systems.BulletAgeSystem;
import net.richardlord.asteroids.systems.CollisionSystem;
import net.richardlord.asteroids.systems.GameManager;
import net.richardlord.asteroids.systems.GunControlSystem;
import net.richardlord.asteroids.systems.MotionControlSystem;
import net.richardlord.asteroids.systems.MovementSystem;
import net.richardlord.asteroids.systems.RenderSystem;
import net.richardlord.asteroids.systems.SystemPriorities;
import net.richardlord.asteroids.systems.AnimationSystem;
import net.richardlord.asteroids.systems.DeathThroesSystem;
import net.richardlord.input.KeyPoll;

import howler.Howl;

import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;

class TestState extends State {
	
    private var engine:Engine;
    private var creator:EntityCreator;
    private var keyPoll:KeyPoll;
    private var config:GameConfig;
	
	public function new() {
		super();
	}
	
	override public function initialize() {
		super.initialize();
		
		engine = new Engine();
        creator = new EntityCreator( engine );
        keyPoll = new KeyPoll();
        config = new GameConfig();
        config.width = _citrusJS.width;
        config.height = _citrusJS.height;

        engine.addSystem(new GameManager( creator, config ), SystemPriorities.preUpdate);
        engine.addSystem(new MotionControlSystem( keyPoll ), SystemPriorities.update);
        engine.addSystem(new GunControlSystem( keyPoll, creator ), SystemPriorities.update);
        engine.addSystem(new BulletAgeSystem( creator ), SystemPriorities.update);
        engine.addSystem(new DeathThroesSystem( creator ), SystemPriorities.update);
        engine.addSystem(new MovementSystem( config ), SystemPriorities.move);
        engine.addSystem(new CollisionSystem( creator ), SystemPriorities.resolveCollisions);
        engine.addSystem(new AnimationSystem(), SystemPriorities.animate);
        engine.addSystem(new RenderSystem( this ), SystemPriorities.render);

        creator.createGame();
	}
	
	override public function onUpdate(elapsedTime:Float) {
		super.onUpdate(elapsedTime);

		engine.update(elapsedTime * 0.001);
	}
}
