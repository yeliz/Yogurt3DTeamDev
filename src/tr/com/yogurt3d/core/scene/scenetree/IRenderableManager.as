package tr.com.yogurt3d.core.scene.scenetree
{
	import flash.utils.Dictionary;
	
	import tr.com.yogurt3d.core.camera.Camera3D;
	import tr.com.yogurt3d.core.lights.Light;
	import tr.com.yogurt3d.core.scene.IScene;
	import tr.com.yogurt3d.core.scene.SceneObjectRenderable;
	
	public interface IRenderableManager
	{
		function addChild(_child:SceneObjectRenderable, _scene:IScene, index:int = -1):void;
		function removeChildFromTree(_child:SceneObjectRenderable, _scene:IScene):void;
		function getSceneRenderableSet(_scene:IScene, _camera:Camera3D):Vector.<SceneObjectRenderable>;
		function getSceneRenderableSetLight(_scene:IScene, _light:Light, lightIndex:int):Vector.<SceneObjectRenderable>;
		function getIlluminatorLightIndexes(_scene:IScene, _objectRenderable:SceneObjectRenderable):Vector.<int>;
		function clearIlluminatorLightIndexes(_scene:IScene, _objectRenderable:SceneObjectRenderable):void;
		function getListOfVisibilityTesterByScene():Dictionary;
	}
}