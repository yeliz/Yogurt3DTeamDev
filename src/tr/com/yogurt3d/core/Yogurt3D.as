package tr.com.yogurt3d.core
{
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import org.osflash.signals.PrioritySignal;
	
	import tr.com.yogurt3d.core.managers.SceneTreeManager;
	import tr.com.yogurt3d.core.plugin.Kernel;
	import tr.com.yogurt3d.core.plugin.Server;
	import tr.com.yogurt3d.core.scene.scenetree.SceneTreePlugins;
	import tr.com.yogurt3d.core.viewport.Viewport;

	public class Yogurt3D
	{
		public static var m_viewportList:Vector.<Viewport> = new Vector.<Viewport>();
		
		private static var m_isEnterFrameRegistered:Boolean = false;
		
		private static var m_lastEnterFrame:uint;
		
		public static var onFrameStart:PrioritySignal = new PrioritySignal();
		public static var onUpdate:PrioritySignal = new PrioritySignal();
		public static var onFrameEnd:PrioritySignal = new PrioritySignal();
		
		public static function registerViewport( viewport:Viewport ):void{
			m_viewportList.push( viewport );
			if( !m_isEnterFrameRegistered && viewport.stage )
			{
				viewport.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame );
				m_lastEnterFrame = getTimer();
				m_isEnterFrameRegistered = true;
			}
		}
		public static function deregisterViewport( viewport:Viewport ):void{
			// find index of viewport
			var index:int = m_viewportList.indexOf( viewport );
			if( index != -1 )
			{
				// if viewport is in the viewport list
				// remove from viewport list
				m_viewportList.splice( index, 1 );
			}
		}
		
		private static function onEnterFrame( event:Event ):void{
			Time.YOGURT3D_INTERNAL::m_frameCount+=1;
			var now:uint = getTimer();
			Time.YOGURT3D_INTERNAL::m_deltaTime = (now - m_lastEnterFrame) * Time.timeScale;
			Time.YOGURT3D_INTERNAL::m_deltaTimeSeconds = Time.YOGURT3D_INTERNAL::m_deltaTime / 1000;
			Time.YOGURT3D_INTERNAL::m_time += Time.YOGURT3D_INTERNAL::m_deltaTime;
			Time.YOGURT3D_INTERNAL::m_timeSeconds = Time.YOGURT3D_INTERNAL::m_time / 1000;
			m_lastEnterFrame = now;
			// diger timelar yazilacak
			
			onFrameStart.dispatch();
			onUpdate.dispatch();
			for( var i:int = 0; i < m_viewportList.length; i++ )
			{
				if( m_viewportList[i].autoUpdate )
					m_viewportList[i].update();
			}
			onFrameEnd.dispatch();
		}
		
		
	}
}