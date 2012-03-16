package tr.com.yogurt3d.core.render.renderer
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import tr.com.yogurt3d.core.camera.Camera3D;
	import tr.com.yogurt3d.core.managers.VertexStreamManager;
	import tr.com.yogurt3d.core.scene.Scene3D;
	
	public class PostProcessRenderer implements IRenderer
	{
		private static var m_vertexBuffer:Dictionary;
		private static var m_indiceBuffer:Dictionary;
		
		public function PostProcessRenderer()
		{
			if( m_vertexBuffer == null )
			{
				m_vertexBuffer = new Dictionary(true);
				m_indiceBuffer = new Dictionary(true);
			}
		}
		
		public function render(device:Context3D, scene:Scene3D, camera:Camera3D, rect:Rectangle):void
		{
			// set pos
			VertexStreamManager.instance.setStream( device, 0, getVertexBuffer(device), 0, Context3DVertexBufferFormat.FLOAT_2 );
			// set uv
			VertexStreamManager.instance.setStream( device, 0, getVertexBuffer(device), 2, Context3DVertexBufferFormat.FLOAT_2 );
			
			device.drawTriangles(getIndiceBuffer(device), 0, 2 );

		}
		
		private static function getVertexBuffer(_context3D:Context3D):VertexBuffer3D{
			if( m_vertexBuffer[_context3D] == null )
			{
				m_vertexBuffer[_context3D] = _context3D.createVertexBuffer( 4, 4 ); // 4 vertices, 4 floats per vertex
				m_vertexBuffer[_context3D].uploadFromVector(
					Vector.<Number>(
						[
							// x,y,u,v
							1,1,   1,0,    
							1,-1,  1,1, 
							-1,-1, 0,1, 
							-1,1,  0,0, 
						]
					),0, 4
				);
			}return m_vertexBuffer[_context3D];
		}
		private static function getIndiceBuffer(_context3D:Context3D):IndexBuffer3D{
			if( m_indiceBuffer[_context3D] == null )
			{
				m_indiceBuffer[_context3D] = _context3D.createIndexBuffer( 6 );
				m_indiceBuffer[_context3D].uploadFromVector( Vector.<uint>( [ 0, 1, 2, 0, 2, 3 ] ), 0, 6 );   
			}return m_indiceBuffer[_context3D];
		}
	}
}