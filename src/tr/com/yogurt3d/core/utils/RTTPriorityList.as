package tr.com.yogurt3d.core.utils
{
	import flash.display3D.Context3D;
	
	import tr.com.yogurt3d.core.render.texture.RenderCubeTexture;
	import tr.com.yogurt3d.core.render.texture.base.RenderTextureTargetBase;

	public class RTTPriorityList
	{
		private var m_list:Vector.<RenderTextureTargetBase>;
		
		public function RTTPriorityList()
		{
			m_list = new Vector.<RenderTextureTargetBase>();
		}
		public function add( value:RenderTextureTargetBase ):void{
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
		public function get length():uint{
			return m_list.length;
		}
		public function remove( value:RenderTextureTargetBase ):void{
			
		}
		public function removeByIndex( value:uint ):void{
			m_list.splice( value, 1 );
		}
		public function updateAll( device:Context3D ):void{
			for( var i:int = 0; i < m_list.length; i++ )
			{
				var rtt:RenderTextureTargetBase = m_list[i];
				if( rtt.autoUpdate )
				{
					rtt.device = device;
					rtt.render();
				}
			}
		}
		private function $add( value:RenderTextureTargetBase ):void{
			for( var i:int = 0; i < m_list.length; i++ )
			{
				var rtt:RenderTextureTargetBase = m_list[i];
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
		private function $addToFront( value:RenderTextureTargetBase ):void{
			for( var i:int = 0; i < m_list.length; i++ )
			{
				var rtt:RenderTextureTargetBase = m_list[i];
				if( !rtt.overrideToFront || (rtt.overrideToFront && rtt.priority > value.priority) ){
					m_list.splice( i, 0, value );
					return;
				}
			}
		}
		private function $addToBack( value:RenderTextureTargetBase ):void{
			for( var i:int = m_list.length - 1; i >= 0 ; i-- )
			{
				var rtt:RenderTextureTargetBase = m_list[i];
				if( !rtt.overrideToBack || (rtt.overrideToBack && rtt.priority < value.priority) ){
					m_list.splice( i, 0, value );
					return;
				}
			}
		}
		
	}
}