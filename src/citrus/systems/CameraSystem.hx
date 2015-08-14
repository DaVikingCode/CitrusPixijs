package citrus.systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import citrus.nodes.CameraNode;

import pixi.core.display.Container;

class CameraSystem extends System {

    var _viewRoot:Container;
    var _cameraNodes:NodeList<CameraNode>;

    public function new(viewRoot:Container) {
        super();

        _viewRoot = viewRoot;
    }

    override public function addToEngine(engine:Engine) {

        _cameraNodes = engine.getNodeList(CameraNode);
    }

    override public function update(time:Float) {

        for (camera in _cameraNodes) {

            var diffX:Float = (-camera.camera.target.x + camera.camera.offset.x) - _viewRoot.x;
            var diffY:Float = (-camera.camera.target.y + camera.camera.offset.y) - _viewRoot.y;
            var velocityX = diffX * camera.camera.easing.x;
            var velocityY = diffY * camera.camera.easing.y;
            _viewRoot.x += velocityX;
            _viewRoot.y += velocityY;

            if (camera.camera.bounds != null) {

                if (-_viewRoot.x <= camera.camera.bounds.left || camera.camera.bounds.width < camera.camera.lensWidth)
                    _viewRoot.x = -camera.camera.bounds.left;
                else if (-_viewRoot.x + camera.camera.lensWidth >= camera.camera.bounds.right)
                    _viewRoot.x = -camera.camera.bounds.right + camera.camera.lensWidth;

                if (-_viewRoot.y <= camera.camera.bounds.top || camera.camera.bounds.height < camera.camera.lensHeight)
                    _viewRoot.y = -camera.camera.bounds.top;
                else if (-_viewRoot.y + camera.camera.lensHeight >= camera.camera.bounds.bottom)
                    _viewRoot.y = -camera.camera.bounds.bottom + camera.camera.lensHeight;
            }
        }

    }

    override public function removeFromEngine(engine:Engine) {

        _cameraNodes = null;
    }
}