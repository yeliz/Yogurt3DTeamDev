/*
 * IScene.as
 * This file is part of Yogurt3D Flash Rendering Engine 
 *
 * Copyright (C) 2011 - Yogurt3D Corp.
 *
 * Yogurt3D Flash Rendering Engine is free software; you can redistribute it and/or
 * modify it under the terms of the YOGURT3D CLICK-THROUGH AGREEMENT
 * License.
 * 
 * Yogurt3D Flash Rendering Engine is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
 * 
 * You should have received a copy of the YOGURT3D CLICK-THROUGH AGREEMENT
 * License along with this library. If not, see <http://www.yogurt3d.com/yogurt3d/downloads/yogurt3d-click-through-agreement.html>. 
 */
 
 
package tr.com.yogurt3d.core.scene
{
	import tr.com.yogurt3d.core.camera.Camera3D;
	import tr.com.yogurt3d.core.lights.Light;
	import tr.com.yogurt3d.core.material.Color;
	import tr.com.yogurt3d.core.objects.interfaces.IEngineObject;
	import tr.com.yogurt3d.core.render.texture.base.RenderTextureTargetBase;
	
	/**
	 * IScene interface defines methods and properties of scene objects.
  	 * @author Yogurt3D Engine Core Team
  	 * @company Yogurt3D Corp.
  	 **/
	public interface IScene extends IEngineObject
	{
		/**
		 * All objects added to this
		 * <strong>IScene</strong> instance 
		 * (including hierarchical ones, children, grand children)
		 * in a one dimensional (flattened) vector.
		 * */
		function get objectSet():Vector.<SceneObject>;
		
		/**
		 * <strong>SceneObjectRenderable</strong>
		 * objects added to this <strong>IScene</strong> instance 
		 * (including hierarchical ones, children, grand children)
		 * in a one dimensional (flattened) vector.
		 * */
		function getRenderableSet(_camera:Camera3D):Vector.<SceneObjectRenderable>;
		
		function getIlluminatorLightIndexes(_scene:IScene, _objectRenderable:SceneObjectRenderable):Vector.<int>;
		
		function clearIlluminatorLightIndexes(_scene:IScene, _objectRenderable:SceneObjectRenderable):void;
		
		function getRenderableSetLight(_light:Light, _lightIndex:int):Vector.<SceneObjectRenderable>;
		
		function getIntersectedLightsByCamera(_camera:Camera3D):Vector.<Light>;

		
		//function prepareSceneForNewFrame():void;
		
		function preRender(_activeCamera:Camera3D):void;
		
		function postRender():void;
		
		/**
		 * <strong>Camera</strong>
		 * objects added to this <strong>IScene</strong> instance 
		 * (including hierarchical ones, children, grand children)
		 * in a one dimensional (flattened) vector.
		 * */
		function get cameraSet():Vector.<Camera3D>;
		
		function get lightSet():Vector.<Light>;
		
		// Container Related Methods
		
		/**
		 * Top level children objects contained in this
		 * <strong>IScene</strong> instance 
		 * */
		function get children():Vector.<SceneObject>;
		
		function get triangleCount():int;
		
		/**
		 * Adds given child object into this
		 * <strong>IScene</strong> instance 
		 * */
		function addChild(_value:SceneObject):void;
		
		/**
		 * Removes given child object from this
		 * <strong>IScene</strong> instance 
		 * */
		function removeChild(_value:SceneObject):void;
		
		/**
		 * Removes child object that has given
		 * systemID from this <strong>IScene</strong> instance.
		 * */
		function removeChildBySystemID(_value:String):void;
		
		/**
		 * Removes child object that has given
		 * userID from this <strong>IScene</strong> instance.
		 * */
		function removeChildByUserID(_value:String):void;
		
		/**
		 * Returns child object that has
		 * given systemID.
		 * */
		function getChildBySystemID(_value:String):SceneObject;
		
		/**
		 * Returns child object that has
		 * given userID.
		 * */
		function getChildByUserID(_value:String):SceneObject;
		
		
		/**
		 * Determines whether the specified <strong>SceneObject</strong>
		 * instance is a child of the <strong>IScene</strong> instance.
		 * 
		 * @param _child Child to check.
		 * 
		 * @param _recursive If this argument is <strong>false</strong>
		 * the check only works for the highest hierarchy. If argument is set
		 * <strong>true</strong> the check will work for all children containers.
		 * */
		function containsChild(_child:SceneObject, _recursive:Boolean = false):Boolean;
		
		function get sceneColor():Color;
		
		function set sceneColor(value:Color):void;
		
		/*function get skyBox():SkyBox;

		function set skyBox(_value:SkyBox):void;
		
		function get postEffects():Vector.<Effect>;*/
		
		function addRenderTarget( value:RenderTextureTargetBase ):void;
		function removeRenderTarget( value:RenderTextureTargetBase ):void;
	}
}
