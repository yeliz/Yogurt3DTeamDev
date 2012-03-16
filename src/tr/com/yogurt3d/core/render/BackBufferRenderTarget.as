package tr.com.yogurt3d.core.render
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.geom.Rectangle;
	
	import mx.messaging.AbstractConsumer;
	
	import tr.com.yogurt3d.core.render.base.RenderTargetBase;
	import tr.com.yogurt3d.core.render.renderer.DefaultRenderer;
	import tr.com.yogurt3d.core.render.renderer.IRenderer;
	import tr.com.yogurt3d.core.render.texture.RenderTexture;
	import tr.com.yogurt3d.core.scene.Scene3D;

	public class BackBufferRenderTarget extends RenderTargetBase
	{	
		private var m_renderTexture:RenderTexture;
		public function BackBufferRenderTarget()
		{
			m_renderTexture  new RenderTexture();
		}
		
		public override function render():void{
			trace("[BackBufferRenderTarget][render] start");
			if(!m_newBackBufferRect.equals( m_currentBackBufferRect ) )
			{
				device.configureBackBuffer( m_newBackBufferRect.width, m_newBackBufferRect.height, 16, true );
				m_currentBackBufferRect.copyFrom( m_newBackBufferRect );
			}
			if( scene.renderTargets.length != 0 )
			{// if scene contains render targets
				// render RTT's
				scene.renderTargets.updateAll(device);
				// set render to backbuffer
				device.setRenderToBackBuffer();
			}
			if( scene.postProcesses.length > 0 )
			{// if scene contains post processing effects
				// render to texture
				m_renderTexture.scene = scene;
				m_renderTexture.camera = camera;
				m_renderTexture.device = device;
				m_renderTexture.drawRect = drawRect;
				m_renderTexture.render();
				
				// send rtt to postprocessing effects
				scene.postProcesses.updateAll( device,scene,camera,drawRect,m_renderTexture);
			}else{ // if the scene does not contain and post processing effects
				// clear backbuffer
				device.clear(Math.random(),Math.random(), Math.random());
				// draw
				m_renderer.render( device, scene, camera, m_currentBackBufferRect );
			}
			// flip backbuffer to front buffer
			device.present();
			trace("[BackBufferRenderTarget][render] end");
		}
		public function getBitmapData():BitmapData{
			var bmp:BitmapData = new BitmapData(m_currentBackBufferRect.width, m_currentBackBufferRect.height);
			device.drawToBitmapData(bmp);
			return bmp;
		}
	}
}