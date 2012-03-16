package tr.com.yogurt3d.core.render.texture
{
	import tr.com.yogurt3d.core.render.renderer.DepthRenderer;
	import tr.com.yogurt3d.core.render.texture.base.RenderTextureTargetBase;
	
	public class RenderDepthTexture extends RenderTextureTargetBase
	{
		public function RenderDepthTexture()
		{
			super();
			overrideToFront = true;
			renderer = new DepthRenderer();
		}
		public override function render():void{
			trace("[RenderDepthTexture][render] start");
			// create texture if needed
			
			// set render target to texture
			
			// render depth of scene
			renderer.render(m_device, m_scene, m_camera, m_currentBackBufferRect);
			trace("[RenderDepthTexture][render] end");
		}
	}
}