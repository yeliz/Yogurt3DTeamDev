package tr.com.yogurt3d.core.render.renderer
{
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	import flash.geom.Rectangle;
	
	import tr.com.yogurt3d.core.YOGURT3D_INTERNAL;
	import tr.com.yogurt3d.core.camera.Camera3D;
	import tr.com.yogurt3d.core.geometry.interfaces.IMesh;
	import tr.com.yogurt3d.core.lights.Light;
	import tr.com.yogurt3d.core.managers.VertexStreamManager;
	import tr.com.yogurt3d.core.material.Material;
	import tr.com.yogurt3d.core.material.shaders.Shader;
	import tr.com.yogurt3d.core.material.shaders.ShaderParameters;
	import tr.com.yogurt3d.core.scene.IScene;
	import tr.com.yogurt3d.core.scene.Scene3D;
	import tr.com.yogurt3d.core.scene.SceneObjectRenderable;
	
	public class DefaultRenderer implements IRenderer
	{
		use namespace YOGURT3D_INTERNAL;
		
		YOGURT3D_INTERNAL var rendererHelper			:Yogurt3DRendererHelper		= new Yogurt3DRendererHelper();
		private var m_lastProgram						:Program3D;
		
		private var vsManager							:VertexStreamManager 	= VertexStreamManager.instance;
		
		private var setStreamsFromShader				:Function 				= vsManager.setStreamsFromShader;
		
		private var setProgramConstants					:Function				= rendererHelper.setProgramConstants;

		
		public function DefaultRenderer()
		{
		}
		public function render( device:Context3D, scene:Scene3D, camera:Camera3D, rect:Rectangle ):void{
			trace("[DefaultRenderer][render] start");
			var _renderableSet:Vector.<SceneObjectRenderable> = scene.getRenderableSet( camera );
			rendererHelper.beginScene(camera);
			renderSceneObjects( device,_renderableSet,scene.getIntersectedLightsByCamera(camera), camera, scene);
			rendererHelper.endScene();
			trace("[DefaultRenderer][render] end");
		}
		
		private final function renderSceneObjects( device:Context3D,  _renderableSet :Vector.<SceneObjectRenderable>,  _lights :Vector.<Light>, _camera:Camera3D, _scene:IScene ):void{
			var _renderableObject:SceneObjectRenderable;
			var _mesh:IMesh;
			var _light:Light;
			var i:int,j:int,k:int,l:int;
			var len:uint; var subMeshIndex:int;
			var program:Program3D;
			
			var streamTotal:uint = 0;
			
			var _numberOfRenderableObjects:uint = _renderableSet.length;
			
			rendererHelper.beginScene(_camera);
			
			for (i = 0; i < _numberOfRenderableObjects; i++ ) {
				// get renderable object and properties
				_renderableObject = _renderableSet[i];				
				trace("\t Render " + _renderableObject.systemID);
				if( !_renderableObject.visible ) continue;
				
				// Self Renderable Scene Object Handling
				/*if (_renderableObject is ISelfRenderable) {				
					vsManager.cleanVertexBuffers( _context3d );
					
					(_renderableObject as ISelfRenderable).render( _context3d, _camera );
					
					vsManager.cleanVertexBuffers( _context3d );
					
					m_lastProgram = null;
					continue;
				}*/
				_mesh = _renderableObject.geometry;
				if (!_mesh) { trace("Renderable object with no geometry.."); 	continue;	}
				
				var _material:Material = _renderableObject.material;
				if (!_material) { trace("Renderable object with no material");	continue;	}
				
				
				var _shaders:Vector.<Shader> = _material.shaders;
				if (!_shaders || _shaders.length < 1) {	trace("Material with no shader");	continue;	}
				
				// for each shader in material
				for (j=0; j < _shaders.length; j++) {
					
					var _shader:Shader = _shaders[j];
					// get shader parameters
					var _params:ShaderParameters = _shader.params;
					
					// Set Blending
					device.setBlendFactors( _params.blendSource, _params.blendDestination);
					
					device.setColorMask( _params.colorMaskR, _params.colorMaskG, _params.colorMaskB, _params.colorMaskA);
					
					// set depth
					device.setDepthTest( _params.writeDepth, _params.depthFunction );
					
					// set culling
					device.setCulling( _params.culling );
					
					if ( _params.requiresLight && _lights != null)
					{
						var lightIndexes:Vector.<int> = _scene.getIlluminatorLightIndexes(_scene, _renderableObject);
						var lenIndexes:int = lightIndexes.length;
						
						
						for ( k = 0; k < lenIndexes; k++) {
							_light = _lights[lightIndexes[k]];	
							if( _scene.getRenderableSetLight(_light,lightIndexes[k]).indexOf( _renderableObject ) == -1 ) continue;					
							// draw triangles
							len = _mesh.subMeshList.length;
							for( subMeshIndex = 0; subMeshIndex < len; subMeshIndex++)
							{
								// set shader program
								program = _shader.getProgram(device, _light.type, _mesh.subMeshList[subMeshIndex].type);
								if( program != m_lastProgram )
								{
									device.setProgram( program );
									m_lastProgram = program;
								}	
								
								setStreamsFromShader( device, _mesh.subMeshList[subMeshIndex], _shader );
								
								// set program constants
								if( !setProgramConstants(device, _params, _light, _camera, _renderableObject, _mesh.subMeshList[subMeshIndex] ) )
								{
									continue;
								}
								device.drawTriangles(_mesh.subMeshList[subMeshIndex].getIndexBufferByContext3D(device), 0, _mesh.subMeshList[subMeshIndex].triangleCount);
							}
						}
						
					}
					else if( !_params.requiresLight )
					{			
						// draw triangles
						len = _mesh.subMeshList.length;
						for( subMeshIndex = 0; subMeshIndex < len; subMeshIndex++)
						{
							// set shader program
							program = _shader.getProgram(device, null, _mesh.subMeshList[subMeshIndex].type);
							if( program != m_lastProgram )
							{
								device.setProgram( program );
								m_lastProgram = program;
							}
							
							setStreamsFromShader( device, _mesh.subMeshList[subMeshIndex], _shader );
							
							// set program constants
							if( !setProgramConstants(device, _params, null, _camera, _renderableObject, _mesh.subMeshList[subMeshIndex]) )
							{
								continue;
							}
							device.drawTriangles(_mesh.subMeshList[subMeshIndex].getIndexBufferByContext3D(device), 0, _mesh.subMeshList[subMeshIndex].triangleCount);
						}
					}
					
				}// end for shader loop			
			}
		}
	}
}