package tr.com.yogurt3d.core.render.base
{
	import flash.display3D.Context3D;
	import flash.geom.Rectangle;
	
	import tr.com.yogurt3d.core.camera.Camera3D;
	import tr.com.yogurt3d.core.render.renderer.DefaultRenderer;
	import tr.com.yogurt3d.core.render.renderer.IRenderer;
	import tr.com.yogurt3d.core.scene.Scene3D;

	public class RenderTargetBase
	{
		protected var m_scene:Scene3D;
		protected var m_camera:Camera3D;
		protected var m_device:Context3D;
		protected var m_renderer:IRenderer;
		protected var m_currentBackBufferRect:Rectangle;
		protected var m_newBackBufferRect:Rectangle;
		
		public var autoUpdate:Boolean = false;
		
		public function RenderTargetBase()
		{
			m_renderer = new DefaultRenderer();
			m_newBackBufferRect = new Rectangle();
			m_currentBackBufferRect = new Rectangle();
		}
		
		public function get drawRect():Rectangle{
			return m_newBackBufferRect;
		}
		public function set drawRect( value:Rectangle ):void{
			m_newBackBufferRect = value;
		}
		
		public function get renderer():IRenderer
		{
			return m_renderer;
		}

		public function set renderer(value:IRenderer):void
		{
			m_renderer = value;
		}

		public function get device():Context3D
		{
			return m_device;
		}

		public function set device(value:Context3D):void
		{
			m_device = value;
		}

		public function get camera():Camera3D
		{
			return m_camera;
		}

		public function set camera(value:Camera3D):void
		{
			m_camera = value;
		}

		public function get scene():Scene3D
		{
			return m_scene;
		}

		public function set scene(value:Scene3D):void
		{
			m_scene = value;
		}

		public function render():void{
			trace("[RenderTargetBase][render] start");
			renderer.render( device, scene, camera, m_currentBackBufferRect );
			trace("[RenderTargetBase][render] end");
			
		}
	}
}