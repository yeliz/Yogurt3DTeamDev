package tr.com.yogurt3d.core.render.texture
{
	import tr.com.yogurt3d.core.render.base.RenderTargetBase;
	import tr.com.yogurt3d.core.render.texture.base.RenderTextureTargetBase;

	public class RenderCubeTexture extends RenderTextureTargetBase
	{
		public function RenderCubeTexture()
		{
			super();
			priority = 150;
		}
		public override function render():void{
			trace("[RenderCubeTexture][render] start");
			// create cube texture if needed
			// set render target to  cube texture
			
			// render scene for each face
			renderer.render(m_device, m_scene, m_camera, m_currentBackBufferRect);
			renderer.render(m_device, m_scene, m_camera, m_currentBackBufferRect);
			renderer.render(m_device, m_scene, m_camera, m_currentBackBufferRect);
			renderer.render(m_device, m_scene, m_camera, m_currentBackBufferRect);
			renderer.render(m_device, m_scene, m_camera, m_currentBackBufferRect);
			renderer.render(m_device, m_scene, m_camera, m_currentBackBufferRect);
			
			trace("[RenderCubeTexture][render] end");
		}
	}
}