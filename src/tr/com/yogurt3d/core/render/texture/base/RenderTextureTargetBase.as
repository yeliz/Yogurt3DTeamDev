package tr.com.yogurt3d.core.render.texture.base
{
	import flash.display3D.Context3D;
	import flash.display3D.textures.TextureBase;
	import flash.utils.Dictionary;
	
	import tr.com.yogurt3d.core.YOGURT3D_INTERNAL;
	import tr.com.yogurt3d.core.render.base.RenderTargetBase;
	import tr.com.yogurt3d.core.texture.ITexture;
	
	public class RenderTextureTargetBase extends RenderTargetBase implements ITexture
	{
		public var overrideToFront:Boolean = false;
		public var overrideToBack:Boolean = false;
		public var priority:uint = 0;
		
		private var m_context3DMap				:Dictionary;
		
		public function RenderTextureTargetBase()
		{
			super();
			m_newBackBufferRect.width = m_newBackBufferRect.height = 512;
			m_context3DMap = new Dictionary(true);
		}
		
		public override function render():void{
			throw new Error();
		}
		
		protected function mapTextureForContext( texture:TextureBase, device:Context3D ):void
		{
			if( m_context3DMap[ device ] && m_context3DMap[ device ] != texture)
			{
				m_context3DMap[ device ].dispose();
			}
			m_context3DMap[ device ] = texture;
		}
		protected function hasTextureForDevice( device:Context3D ):Boolean{
			return m_context3DMap[ device ]!=null;
		}
		public function getTextureForDevice( device:Context3D ):TextureBase
		{
			return m_context3DMap[ device ];
		}
	}
}