package tr.com.yogurt3d.core.camera
{
	import flash.geom.Vector3D;
	
	import tr.com.yogurt3d.core.YOGURT3D_INTERNAL;
	import tr.com.yogurt3d.core.camera.frustum.Frustum;
	import tr.com.yogurt3d.core.scene.SceneObject;

	public class Camera3D extends SceneObject
	{
		private var m_frustum :Frustum;
		
		use namespace YOGURT3D_INTERNAL;
		
		public function Camera3D(_initInternals:Boolean = true)
		{
			super(_initInternals);
		}
		
		public function get frustum():Frustum
		{
			return m_frustum;
		}
		
		public function getRayFromMousePosition(_canvasHeight:Number ,_canvasWidth:Number , _mouseX:Number, _mouseY:Number ):Ray {
			var _ray:Ray = new Ray() ;
			
			var _endPoint:Vector3D = new Vector3D() ;
			_endPoint.x = this.frustum.m_vCornerPoints[0].x - (this.frustum.m_vCornerPoints[0].x - this.frustum.m_vCornerPoints[1].x) * (_canvasWidth-_mouseX) / _canvasWidth ;
			_endPoint.y = this.frustum.m_vCornerPoints[0].y - (this.frustum.m_vCornerPoints[0].y - this.frustum.m_vCornerPoints[3].y) * _mouseY / _canvasHeight ;
			_endPoint.z = this.frustum.m_vCornerPoints[0].z ;
			
			_endPoint = this.transformation.matrixGlobal.transformVector(_endPoint) ;
			
			_ray.startPoint = transformation.globalPosition.clone() ;
			_ray.endPoint = _endPoint ;
			
			return _ray ;
		}
		
		/**
		 * @inheritDoc
		 * 
		 */		
		override protected function initInternals():void
		{
			super.initInternals();
			
			m_frustum = new Frustum();
			
			m_frustum.setProjectionPerspective( 45.0, 4.0/3.0, 1.0, 500.0 );
		}
		
	}
}