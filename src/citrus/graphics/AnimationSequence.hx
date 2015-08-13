package citrus.graphics;

import pixi.core.display.Container;
import pixi.core.textures.Texture;
import pixi.extras.MovieClip;

class AnimationSequence extends Container {

    var _mcSequences:Map<String, MovieClip>;
    var _previousAnimation:String;

    var _animations:Array<String>;
    var _firstAnimation:String;
    var _defaultAnimationSpeed:Float;

    public function new(animations:Array<String>, firstAnimation:String, ?defaultAnimationSpeed:Float = 1) {
        super();
        _mcSequences = new Map<String, MovieClip>();

        _animations = animations;
        _previousAnimation = _firstAnimation = firstAnimation;
        _defaultAnimationSpeed = defaultAnimationSpeed;

        var textureCache = new Array<String>();

        untyped __js__('for (var index in PIXI.utils.TextureCache)
            textureCache.push(index);');

        var mc:MovieClip;
        var textures:Array<Texture>;
        for (animation in animations) {

            textures = _getTexturesForName(textureCache, animation);

            mc = new MovieClip(textures);
            mc.animationSpeed = defaultAnimationSpeed;

            _mcSequences.set(animation, mc);
        }

        var firstMc = _mcSequences.get(firstAnimation);
        firstMc.play();
        addChild(firstMc);

        addListener("removed", _removedFromStage);
    }

    function _removedFromStage() {

        _mcSequences = null;
    }

    public function changeAnimation(animation:String) {

        var oldMc = _mcSequences.get(_previousAnimation);
        oldMc.stop();

        removeChild(oldMc);

        var mc = _mcSequences.get(animation);
        mc.play();

        addChild(mc);
    }

    function _getTexturesForName(textureCache:Array<String>, name:String):Array<Texture> {

        var textures = new Array<Texture>();

        for (textureName in textureCache)
            if (textureName.indexOf(name) != -1)
                textures.push(Texture.fromFrame(textureName));

        return textures;
    }
}
