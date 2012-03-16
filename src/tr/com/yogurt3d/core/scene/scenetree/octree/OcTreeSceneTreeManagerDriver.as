package tr.com.yogurt3d.core.scene.scenetree.octree
{
	import tr.com.yogurt3d.core.scene.scenetree.IRenderableManager;
	import tr.com.yogurt3d.core.scene.scenetree.SceneTreeManagerDriver;
	
	
	public class OcTreeSceneTreeManagerDriver extends SceneTreeManagerDriver
	{
		public function OcTreeSceneTreeManagerDriver()
		{
			super();
		}
		public override function get name():String{
			return "OcSceneTreeManagerDriver";
		}
		public override function createTreeManager():IRenderableManager{
			return new OcTreeSceneTreeManager();
		}
	}
}