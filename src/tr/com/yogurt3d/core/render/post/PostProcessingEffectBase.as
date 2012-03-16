package tr.com.yogurt3d.core.render.post
{
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.textures.Texture;
	import flash.display3D.textures.TextureBase;
	import flash.utils.Dictionary;
	
	import tr.com.yogurt3d.core.render.base.RenderTargetBase;
	import tr.com.yogurt3d.core.render.renderer.PostProcessRenderer;
	import tr.com.yogurt3d.core.render.texture.RenderTexture;
	import tr.com.yogurt3d.core.render.texture.base.RenderTextureTargetBase;

	public class PostProcessingEffectBase extends RenderTargetBase
	{
		public var overrideToFront:Boolean = false;
		public var overrideToBack:Boolean = false;
		public var priority:uint = 0;
		
		/**
		 * This is the previos screen to be used as a sampler\n
		 * This will be set before render is called
		 */		
		public var sampler:TextureBase;
		
		public function PostProcessingEffectBase()
		{
			renderer = new PostProcessRenderer();
		}
		
		public override function render():void{
			device.clear();
			// set program
			
			// set context3d properties and constants
			// eg: device.setTextureAt(0, sampler.getTextureForDevice( device );
			
			// render
			renderer.render(device,scene,camera,drawRect);
			
		}
	}
}