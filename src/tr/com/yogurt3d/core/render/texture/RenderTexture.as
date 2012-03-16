package tr.com.yogurt3d.core.render.texture
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	import flash.display3D.textures.TextureBase;
	import flash.utils.Dictionary;
	
	import tr.com.yogurt3d.core.render.base.RenderTargetBase;
	import tr.com.yogurt3d.core.render.texture.base.RenderTextureTargetBase;

	public class RenderTexture extends RenderTextureTargetBase
	{
		private var m_textureDict:Dictionary;
		
		public function RenderTexture()
		{
			super();
			priority = 100;
		}
		public override function render():void{
			trace("[RenderTexture][render] start");
			// create texture if needed
			var texture:TextureBase = getTexture(m_device);
			// set render target to texture
			device.setRenderToTexture(texture, true);
			// render scene
			renderer.render(m_device, m_scene, m_camera, m_currentBackBufferRect);
			trace("[RenderTexture][render] end");
		}
		
		private function getTexture(device:Context3D):TextureBase{
			if( hasTextureForDevice(device) == false )
			{
				
				m_currentBackBufferRect.copyFrom( m_newBackBufferRect );
				var texture:TextureBase = device.createTexture( m_currentBackBufferRect.width, m_currentBackBufferRect.height, Context3DTextureFormat.BGRA, true );
				mapTextureForContext( texture, device );
				
			}else if(!m_newBackBufferRect.equals( m_currentBackBufferRect ) )
			{
				texture = getTextureForDevice(device);
				texture.dispose();
				
				texture = device.createTexture( m_newBackBufferRect.width, m_newBackBufferRect.height, Context3DTextureFormat.BGRA, true );
				mapTextureForContext(texture, device );
				m_currentBackBufferRect.copyFrom( m_newBackBufferRect );
			}
			return getTextureForDevice(device);
		}
	}
}