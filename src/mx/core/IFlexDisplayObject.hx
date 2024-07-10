package mx.core
;
   import flash.accessibility.AccessibilityProperties;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.IBitmapDrawable;
   import flash.display.LoaderInfo;
   import flash.display.Stage;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Transform;
   
    interface IFlexDisplayObject extends IBitmapDrawable extends  IEventDispatcher
   {
       
      
            
      @:flash.property @:isVar var visible(get,set):Bool;
      
            
      @:flash.property @:isVar var rotation(get,set):Float;
      
      function localToGlobal(param1:Point) : Point;
      
            
      @:flash.property @:isVar var name(get,set):String;
      
            
      @:flash.property @:isVar var width(get,set):Float;
      
      @:flash.property @:isVar var measuredHeight(get,never):Float;
      
            
      @:flash.property @:isVar var blendMode(get,set):String;
      
            
      @:flash.property @:isVar var scale9Grid(get,set):Rectangle;
      
            
      @:flash.property @:isVar var scaleX(get,set):Float;
      
            
      @:flash.property @:isVar var scaleY(get,set):Float;
      
      @:flash.property @:isVar var measuredWidth(get,never):Float;
      
            
      @:flash.property @:isVar var accessibilityProperties(get,set):AccessibilityProperties;
      
            
      @:flash.property @:isVar var scrollRect(get,set):Rectangle;
      
            
      @:flash.property @:isVar var cacheAsBitmap(get,set):Bool;
      
      function globalToLocal(param1:Point) : Point;
      
            
      @:flash.property @:isVar var height(get,set):Float;
      
      @:flash.property @:isVar var parent(get,never):DisplayObjectContainer;
      
      function getBounds(param1:DisplayObject) : Rectangle;
      
            
      @:flash.property @:isVar var opaqueBackground(get,set):ASObject;
      
      function setActualSize(param1:Float, param2:Float) : Void;
      
            
      @:flash.property @:isVar var alpha(get,set):Float;
      
      function hitTestPoint(param1:Float, param2:Float, param3:Bool = false) : Bool;
      
      @:flash.property @:isVar var mouseX(get,never):Float;
      
      @:flash.property @:isVar var mouseY(get,never):Float;
      
            
      @:flash.property @:isVar var mask(get,set):DisplayObject;
      
      function getRect(param1:DisplayObject) : Rectangle;
      
            
      @:flash.property @:isVar var transform(get,set):Transform;
      
      function move(param1:Float, param2:Float) : Void;
      
      @:flash.property @:isVar var loaderInfo(get,never):LoaderInfo;
      
      @:flash.property @:isVar var root(get,never):DisplayObject;
      
      function hitTestObject(param1:DisplayObject) : Bool;
      
            
      @:flash.property @:isVar var x(get,set):Float;
      
            
      @:flash.property @:isVar var y(get,set):Float;
      
            
      @:flash.property @:isVar var filters(get,set):Array<ASAny>;
      
      @:flash.property @:isVar var stage(get,never):Stage;
   }

