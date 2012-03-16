package tr.com.yogurt3d.core.scene.scenetree.quad
{
	import tr.com.yogurt3d.core.scene.scenetree.IRenderableManager;
	import tr.com.yogurt3d.core.scene.scenetree.SceneTreeManagerDriver;
	
	
	public class QuadSceneTreeManagerDriver extends SceneTreeManagerDriver
	{
		public function QuadSceneTreeManagerDriver()
		{
			super();
		}
		public override function get name():String{
			return "QuadSceneTreeManagerDriver";
		}
		public override function createTreeManager():IRenderableManager{
			return new QuadSceneTreeManager();
		}
	}
}