package tr.com.yogurt3d.core.scene.scenetree.simple
{
	import tr.com.yogurt3d.core.scene.scenetree.IRenderableManager;
	import tr.com.yogurt3d.core.scene.scenetree.SceneTreeManagerDriver;
	
	
	public class SimpleSceneTreeManagerDriver extends SceneTreeManagerDriver
	{
		public function SimpleSceneTreeManagerDriver()
		{
			super();
		}
		public override function get name():String{
			return "SimpleSceneTreeManagerDriver";
		}
		public override function createTreeManager():IRenderableManager{
			return new SimpleSceneTreeManager();
		}
	}
}