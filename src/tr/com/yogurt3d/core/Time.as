package tr.com.yogurt3d.core
{
	public class Time
	{
		YOGURT3D_INTERNAL static var m_time				:uint = 0;
		YOGURT3D_INTERNAL static var m_timeSeconds		:Number = 0;
		
		YOGURT3D_INTERNAL static var m_deltaTime		:uint = 0;
		YOGURT3D_INTERNAL static var m_deltaTimeSeconds	:Number = 0;
		
		public static var timeScale						:Number = 1;
		
		YOGURT3D_INTERNAL static var m_frameCount		:uint = 0;



		public static function get time():uint
		{
			return YOGURT3D_INTERNAL::m_time;
		}
		
		public static function get timeSeconds():Number
		{
			return YOGURT3D_INTERNAL::m_timeSeconds;
		}

		public static function set timeSeconds(value:Number):void
		{
			YOGURT3D_INTERNAL::m_timeSeconds = value;
		}
		
		public static function get deltaTime():uint
		{
			return YOGURT3D_INTERNAL::m_deltaTime;
		}

		public static function get deltaTimeSeconds():Number
		{
			return YOGURT3D_INTERNAL::m_deltaTimeSeconds;
		}

		public static function get frameCount():uint
		{
			return YOGURT3D_INTERNAL::m_frameCount;
		}
		

	}
}