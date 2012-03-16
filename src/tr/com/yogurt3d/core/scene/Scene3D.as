package tr.com.yogurt3d.core.scene
{
	import tr.com.yogurt3d.core.YOGURT3D_INTERNAL;
	import tr.com.yogurt3d.core.camera.Camera3D;
	import tr.com.yogurt3d.core.lights.Light;
	import tr.com.yogurt3d.core.managers.IDManager;
	import tr.com.yogurt3d.core.managers.SceneTreeManager;
	import tr.com.yogurt3d.core.material.Color;
	import tr.com.yogurt3d.core.objects.EngineObject;
	import tr.com.yogurt3d.core.render.texture.base.RenderTextureTargetBase;
	import tr.com.yogurt3d.core.utils.PPPriorityList;
	import tr.com.yogurt3d.core.utils.RTTPriorityList;

	public class Scene3D extends EngineObject implements IScene
	{
		public var renderTargets:RTTPriorityList;
		public var postProcesses:PPPriorityList;
	
		
		public static const SIMPLE_SCENE:String = "SimpleSceneTreeManagerDriver";
		public static const QUAD_SCENE:String = "QuadSceneTreeManagerDriver";
		public static const OCTREE_SCENE:String = "OcTreeSceneTreeManagerDriver";
		
		YOGURT3D_INTERNAL var m_rootObject		:SceneObject;
		YOGURT3D_INTERNAL var m_args			:Object;
		
		YOGURT3D_INTERNAL var m_driver:String;
		
		
		private var m_sceneColor:Color;
		
/*		private var m_skyBox:SkyBox;*/
		
		use namespace YOGURT3D_INTERNAL;
		
		public function Scene3D(_sceneTreeManagerDriver:String = "SimpleSceneTreeManagerDriver", args:Object = null, _initInternals:Boolean = true)
		{
			renderTargets = new RTTPriorityList();
			postProcesses = new PPPriorityList();
			m_driver = _sceneTreeManagerDriver;
			m_args = args;
			super(_initInternals);
		}
		
		
		/**
		 * @inheritDoc
		 * */
		public function get objectSet():Vector.<SceneObject>
		{
			return SceneTreeManager.getSceneObjectSet(this);
		}
		
		/**
		 * @inheritDoc
		 * */
		public function getRenderableSet(_camera:Camera3D):Vector.<SceneObjectRenderable>
		{
			return SceneTreeManager.getSceneRenderableSet(this,_camera);
		}
		
		public function getIlluminatorLightIndexes(_scene:IScene, _objectRenderable:SceneObjectRenderable):Vector.<int>
		{
			return SceneTreeManager.getIlluminatorLightIndexes(this,_objectRenderable);
		}
		
		public function clearIlluminatorLightIndexes(_scene:IScene, _objectRenderable:SceneObjectRenderable):void
		{
			return SceneTreeManager.clearIlluminatorLightIndexes(this,_objectRenderable);
		}
		
		public function getRenderableSetLight(_light:Light, _lightIndex:int):Vector.<SceneObjectRenderable>
		{
			return SceneTreeManager.getSceneRenderableSetLight(this, _light, _lightIndex);
		}
		
		public function preRender(_activeCamera:Camera3D):void
		{
			SceneTreeManager.clearSceneFrameData( this, _activeCamera);
			getRenderableSet(_activeCamera);
			SceneTreeManager.initIntersectedLightByCamera(this, _activeCamera);
		}
		
		public function postRender():void
		{
			
		}
		
		/**
		 * @inheritDoc
		 * */
		public function get cameraSet():Vector.<Camera3D>
		{
			return SceneTreeManager.getSceneCameraSet(this);
		}
		
		public function get lightSet():Vector.<Light>
		{
			return SceneTreeManager.getSceneLightSet(this);
		}
		
		public function getIntersectedLightsByCamera(_camera:Camera3D):Vector.<Light>
		{
			return SceneTreeManager.s_intersectedLightsByCamera[_camera];
		}
		
		/**
		 * @inheritDoc
		 * */
		public function get children():Vector.<SceneObject>
		{
			return SceneTreeManager.getChildren(m_rootObject);
		}
		
		public function get triangleCount():int
		{
			var _renderableSet		:Vector.<SceneObjectRenderable>	= SceneTreeManager.getSceneRenderableSet(this, null);
			var _renderableCount	:int								= _renderableSet.length;
			var _triangleCount		:int								= 0;
			
			for( var i:int = 0; i < _renderableCount; i++ )
				_triangleCount		+= _renderableSet[i].geometry.triangleCount;
			
			return _triangleCount;
		}
		
		/**
		 * @inheritDoc
		 * */
		public function addChild(_value:SceneObject):void {
			if (_value == null) {
				throw new Error("Child can not be null");
				return;
			}
			SceneTreeManager.addChild(_value, m_rootObject);
		}
		
		/**
		 * @inheritDoc
		 * */
		public function removeChild(_value:SceneObject):void
		{
			SceneTreeManager.removeChild(_value, m_rootObject);
		}
		
		/**
		 * @inheritDoc
		 * */
		public function removeChildBySystemID(_value:String):void
		{
			SceneTreeManager.removeChildBySystemID(_value, m_rootObject);
		}
		
		/**
		 * @inheritDoc
		 * */
		public function removeChildByUserID(_value:String):void
		{
			SceneTreeManager.removeChildByUserID(_value, m_rootObject);
		}
		
		/**
		 * @inheritDoc
		 * */
		public function getChildBySystemID(_value:String):SceneObject
		{
			return SceneTreeManager.getChildBySystemID(_value, m_rootObject);
		}
		
		/**
		 * @inheritDoc
		 * */
		public function getChildByUserID(_value:String):SceneObject
		{
			return SceneTreeManager.getChildByUserID(_value, m_rootObject);
		}
		
		/**
		 * @inheritDoc
		 * */
		public function containsChild(_child:SceneObject, _recursive:Boolean = false):Boolean
		{
			return SceneTreeManager.contains(_child, m_rootObject, _recursive); 
		}
		
		override protected function trackObject():void
		{
			IDManager.trackObject(this, Scene3D);
		}
		
		override public function dispose():void{
			if( m_rootObject )
			{
				m_rootObject.dispose();
			}
			m_rootObject = null;
			
			m_sceneColor = null;
			/*
			m_postEffects = null;*/
			/*if( skyBox )
			{
				skyBox.dispose();
				skyBox = null;
			}*/
			
			super.dispose();
		}
		
		override public function disposeGPU():void{
			m_rootObject.disposeGPU();
			/*if( skyBox )
			{
				skyBox.disposeGPU();
			}*/
		}
		
		override public function disposeDeep():void{
			/*if( skyBox )
			{
				skyBox.dispose();
				skyBox = null;
			}*/
			
			m_rootObject.disposeDeep();
			
			m_rootObject = null;
			
			m_sceneColor = null;
			
			/*if( m_postEffects )
			{
				for( var i:int = 0; i < m_postEffects.length; i++ )
				{
					m_postEffects[i].dispose();
				}
			}
			m_postEffects = null;*/
			
			dispose();
		}
		
		override protected function initInternals():void
		{
			super.initInternals();
			
			m_rootObject 		= new SceneObject();
			
			m_sceneColor = new Color(1,1,1,1);
			
			SceneTreeManager.setSceneRootObject( m_rootObject, this);
		}
		
		public function get sceneColor():Color
		{
			return m_sceneColor;
		}
		
		public function set sceneColor(value:Color):void
		{
			m_sceneColor = value;
		}
		
		/*public function get skyBox():SkyBox
		{
			return m_skyBox;
		}
		public function set skyBox(_value:SkyBox):void
		{
			if( m_skyBox != null )
			{
				//remove from scene
				removeChild( m_skyBox );
			}
			m_skyBox = _value;
			if( m_skyBox )
				SceneTreeManager.addChild( m_skyBox, m_rootObject );
		}*/
		
		public function addRenderTarget( value:RenderTextureTargetBase ):void{
			renderTargets.add( value );
		}
		public function removeRenderTarget( value:RenderTextureTargetBase ):void{
			renderTargets.remove( value );
		}
	}
}