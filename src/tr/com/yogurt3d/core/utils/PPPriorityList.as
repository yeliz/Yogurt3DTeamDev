package tr.com.yogurt3d.core.utils
{
	import flash.display3D.Context3D;
	import flash.display3D.textures.TextureBase;
	import flash.geom.Rectangle;
	
	import tr.com.yogurt3d.core.camera.Camera3D;
	import tr.com.yogurt3d.core.render.post.PostProcessingEffectBase;
	import tr.com.yogurt3d.core.render.texture.RenderTexture;
	import tr.com.yogurt3d.core.scene.Scene3D;

	public class PPPriorityList
	{
		private var m_list:Vector.<PostProcessingEffectBase>;
		
		public function PPPriorityList()
		{
			m_list = new Vector.<PostProcessingEffectBase>();
		}
		public function get length():uint{
			return m_list.length;
		}
		public function add( value:PostProcessingEffectBase ):void{
			if( value.overrideToFront )
			{
				$addToFront( value );
			}
			else if( value.overrideToBack ){
				$addToBack( value );
			}else{
				$add( value );
			}
		}
		public function remove( value:PostProcessingEffectBase ):void{
			
		}
		public function removeByIndex( value:uint ):void{
			m_list.splice( value, 1 );
		}
		public function updateAll( device:Context3D, scene:Scene3D, camera:Camera3D, drawRect:Rectangle, rtt:RenderTexture ):void{
			var lastTexture:TextureBase;
			var target:TextureBase; // create a texture here as target
			
			for( var i:int = 0; i < m_list.length; i++ )
			{
				var post:PostProcessingEffectBase = m_list[i];
				post.device = device;
				post.scene = scene;
				post.camera = camera;
				post.drawRect = drawRect;
				if( i == 0 )
				{
					post.sampler = rtt.getTextureForDevice( device );
				}else{
					post.sampler = lastTexture;
				}
				if( i != m_list.length -1 )
				{
					device.setRenderToBackBuffer();
				}else{
					device.setRenderToTexture( target );
				}
					
				post.render();
				
				if( i != m_list.length -1 )
				{
					lastTexture = target;
					target = post.sampler;
				}
			}
		}
		private function $add( value:PostProcessingEffectBase ):void{
			for( var i:int = 0; i < m_list.length; i++ )
			{
				var rtt:PostProcessingEffectBase = m_list[i];
				if( rtt.overrideToFront ) continue;
				if( rtt.priority > value.priority ){
					m_list.splice( i, 0, value );
					return;
				}
				if( rtt.overrideToBack ){
					m_list.splice( i, 0, value );
				}
			}
			m_list.splice( i, 0, value );
		}
		private function $addToFront( value:PostProcessingEffectBase ):void{
			for( var i:int = 0; i < m_list.length; i++ )
			{
				var rtt:PostProcessingEffectBase = m_list[i];
				if( !rtt.overrideToFront || (rtt.overrideToFront && rtt.priority > value.priority) ){
					m_list.splice( i, 0, value );
					return;
				}
			}
		}
		private function $addToBack( value:PostProcessingEffectBase ):void{
			for( var i:int = m_list.length - 1; i >= 0 ; i-- )
			{
				var rtt:PostProcessingEffectBase = m_list[i];
				if( !rtt.overrideToBack || (rtt.overrideToBack && rtt.priority < value.priority) ){
					m_list.splice( i, 0, value );
					return;
				}
			}
		}
		
	}
}