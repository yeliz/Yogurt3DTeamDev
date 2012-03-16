package tr.com.yogurt3d.core.scene.scenetree
{
	import tr.com.yogurt3d.core.plugin.Kernel;
	import tr.com.yogurt3d.core.plugin.Plugin;
	import tr.com.yogurt3d.core.plugin.Server;
	import tr.com.yogurt3d.core.scene.scenetree.octree.OcTreeSceneTreeManagerDriver;
	import tr.com.yogurt3d.core.scene.scenetree.quad.QuadSceneTreeManagerDriver;
	import tr.com.yogurt3d.core.scene.scenetree.simple.SimpleSceneTreeManagerDriver;
	
	

	[Plugin]
	public class SceneTreePlugins extends Plugin
	{
		public static const SERVERNAME:String = "sceneTreeManagerServer";
		public static const SERVERVERSION:uint = 1;
		
		public override function registerPlugin(_kernel:Kernel):Boolean{
			var server:Server = _kernel.getServer( SERVERNAME );
			if( server )
			{
				var drivers:Array = [SimpleSceneTreeManagerDriver, QuadSceneTreeManagerDriver, OcTreeSceneTreeManagerDriver];
				
				var success:uint = drivers.length;
				
				for( var i:int = 0; i < drivers.length; i++)
				{
					if( server.addDriver( new drivers[i](), SERVERVERSION ) )
					{
						success--;
					}
				}
				
				
				return (success == 0);
			}
			return false;
		}
	}
}