package tr.com.yogurt3d.core.viewport
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.text.TextField;
	
	import tr.com.yogurt3d.core.Time;
	import tr.com.yogurt3d.core.Yogurt3D;
	import tr.com.yogurt3d.core.camera.Camera3D;
	import tr.com.yogurt3d.core.render.BackBufferRenderTarget;
	import tr.com.yogurt3d.core.render.base.RenderTargetBase;
	import tr.com.yogurt3d.core.render.texture.RenderTexture;
	import tr.com.yogurt3d.core.scene.Scene3D;
	
	public class Viewport extends Sprite
	{
		private static var viewports			:Vector.<uint> = Vector.<uint>([0,1,2]);
		
		private var m_device:Context3D;
		
		public  var autoUpdate:Boolean = true;
		
		private var m_currentRenderTarget:RenderTargetBase;

		private var m_viewportID				:uint;
		
		
		public function Viewport( width:Number = 800, height:Number = 600)
		{
			super();
			
			m_currentRenderTarget = new BackBufferRenderTarget();
			
			if( viewports.length > 0 )
			{
				// get an empty stage3d index
				m_viewportID = viewports.shift();
			}else{
				throw new Error("Maximum 3 viewports are supported. You must dispose before creating a new one.");
			}
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			this.height = height;
			this.width = width;
		}
		public function get scene():Scene3D{
			return m_currentRenderTarget.scene;
		}
		public function set scene(value:Scene3D):void{
			m_currentRenderTarget.scene = value;
		}
		public function get camera():Camera3D{
			return m_currentRenderTarget.camera;
		}
		public function set camera(value:Camera3D):void{
			m_currentRenderTarget.camera = value;
		}
		public override function set x( value:Number ):void{
			stage.stage3Ds[ m_viewportID ].x = value;
		}
		public override function set y( value:Number ):void{
			stage.stage3Ds[ m_viewportID ].y = value;
		}
		public override function set width( value:Number ):void{
			if( m_currentRenderTarget is BackBufferRenderTarget ){
				BackBufferRenderTarget(m_currentRenderTarget).drawRect.width = value;
			}
		}
		public override function set height( value:Number ):void{
			if( m_currentRenderTarget is BackBufferRenderTarget ){
				BackBufferRenderTarget(m_currentRenderTarget).drawRect.height = value;
			}
		}
		protected function onAddedToStage( _event:Event ):void{
			// create context
			stage.stage3Ds[m_viewportID].addEventListener(Event.CONTEXT3D_CREATE, onContextCreated );
			stage.stage3Ds[m_viewportID].addEventListener(ErrorEvent.ERROR, onError );
			stage.stage3Ds[m_viewportID].requestContext3D();
			Yogurt3D.registerViewport( this );
		}
		protected function onRemovedFromStage( _event:Event ):void{
			Yogurt3D.deregisterViewport( this );
		}
		private function onError( _event:Event ):void{
			stage.stage3Ds[m_viewportID].removeEventListener(ErrorEvent.ERROR, arguments.callee );
			var text:TextField = new TextField();
			text.text = "Add wmode=\"direct\" to params.";
			text.width = 600;
			addChild( text );
		}
		private function onContextCreated( _event:Event ):void{
			m_device = stage.stage3Ds[0].context3D;
			m_currentRenderTarget.device = m_device;
		}
		private function get isDeviceCreated():Boolean
		{
			return m_device != null;
		}
		public function update():void{
			if( !isDeviceCreated ) return;
			trace("[Viewport][update] frame: " + Time.frameCount, " time:" + Time.timeSeconds);
			m_currentRenderTarget.render();
		}
	}
}