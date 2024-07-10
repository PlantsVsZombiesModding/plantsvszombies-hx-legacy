package com.popcap.flash.framework.widgets
;
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   
    class CWidget extends CWidgetContainer
   {
      
      public static inline final LAY_Right:Float = 1024;
      
      public static inline final LAY_Above:Float = 256;
      
      public static inline final LAY_GrowToBottom:Float = 524288;
      
      public static inline final LAY_SameLeft:Float = 4096;
      
      public static inline final LAY_SetHeight:Float = 128;
      
      public static inline final LAY_Left:Float = 2048;
      
      public static inline final LAY_SetTop:Float = 32;
      
      public static inline final LAY_Below:Float = 512;
      
      public static inline final LAY_GrowToTop:Float = 262144;
      
      public static inline final LAY_HCenter:Float = 1048576;
      
      public static inline final LAY_GrowToLeft:Float = 131072;
      
      public static inline final LAY_Max:Float = 4194304;
      
      public static inline final LAY_SameWidth:Float = 1;
      
      public static inline final LAY_SameHeight:Float = 2;
      
      public static final LAY_SameSize:Float = Std.int(LAY_SameWidth )| Std.int(LAY_SameHeight);
      
      public static inline final LAY_SetLeft:Float = 16;
      
      public static final LAY_SetPos:Float = Std.int(LAY_SetLeft )| Std.int(LAY_SetTop);
      
      public static inline final LAY_VCenter:Float = 2097152;
      
      public static inline final LAY_SameBottom:Float = 32768;
      
      public static inline final LAY_SameTop:Float = 16384;
      
      public static final LAY_SameCorner:Float = Std.int(LAY_SameLeft )| Std.int(LAY_SameTop);
      
      public static inline final LAY_GrowToRight:Float = 65536;
      
      public static inline final LAY_SameRight:Float = 8192;
      
      public static inline final LAY_SetWidth:Float = 64;
      
      public static final LAY_SetSize:Float = Std.int(LAY_SetWidth )| Std.int(LAY_SetHeight);
       
      
      var mBounds:Rectangle;
      
      public var isOver:Bool = false;
      
      public var tabNext:CWidget = null;
      
      public var wantsFocus:Bool = false;
      
      public var hasTransparencies:Bool = false;
      
      var mPolyShape:Vector<Point>;
      
      public var doFinger:Bool = false;
      
      public var hasFocus:Bool = false;
      
      public var tabPrev:CWidget = null;
      
      public var colors:Array<ASAny>;
      
      public var isDown:Bool = false;
      
      public var visible:Bool = true;
      
      public var mUsePolyShape:Bool = false;
      
      public var disabled:Bool = false;
      
      public function new()
      {
         super();
         this.colors = new Array<ASAny>();
         this.mPolyShape = new Vector<Point>();
         this.mBounds = new Rectangle();
         //super();
      }
      
      public function setColors(param1:Array<ASAny>) 
      {
         this.colors = new Array<ASAny>();
         var _loc2_= param1.length;
         var _loc3_= 0;
         while(_loc3_ < _loc2_)
         {
            this.setColor(_loc3_,this.colors[_loc3_]);
            _loc3_++;
         }
         markDirty();
      }
      
      public function deferOverlay(param1:Float) 
      {
         widgetManager.deferOverlay(this,param1);
      }
      
      public function isPointVisible(param1:Float, param2:Float) : Bool
      {
         return true;
      }
      
      public function lostFocus() 
      {
         this.hasFocus = false;
      }
      
      public function contains(param1:Float, param2:Float) : Bool
      {
         var _loc7_:Point = null;
         var _loc8_:Point = null;
         if(this.width == 0 || this.height == 0)
         {
            return false;
         }
         if(param1 < this.x)
         {
            return false;
         }
         if(param2 < this.y)
         {
            return false;
         }
         if(param1 >= this.x + this.width)
         {
            return false;
         }
         if(param2 >= this.y + this.height)
         {
            return false;
         }
         if(!this.mUsePolyShape)
         {
            return true;
         }
         if(this.mPolyShape.length < 3)
         {
            return false;
         }
         var _loc3_:ASAny = false;
         var _loc4_= 0;
         var _loc5_= 0;
         var _loc6_= this.mPolyShape.length;
         _loc4_ = 0;
         _loc5_ = _loc6_ - 1;
         while(_loc4_ < _loc6_)
         {
            _loc7_ = this.mPolyShape[_loc4_];
            _loc8_ = this.mPolyShape[_loc5_];
            if(_loc7_.y > param2 != _loc8_.y > param2 && param1 < (_loc8_.x - _loc7_.x) * (param2 - _loc7_.y) / (_loc8_.y - _loc7_.y) + _loc7_.x)
            {
               _loc3_ = !_loc3_;
            }
            _loc5_ = _loc4_++;
         }
         return _loc3_;
      }
      
      public function setColor(param1:Int, param2:Color) 
      {
         this.colors[param1] = param2;
         markDirty();
      }
      
      public function layout(param1:Float, param2:CWidget, param3:Float, param4:Float, param5:Float, param6:Float) 
      {
         var _loc7_= param2.x;
         var _loc8_= param2.y;
         if(param2 == parent)
         {
            _loc7_ = 0;
            _loc8_ = 0;
         }
         var _loc9_= param2.width;
         var _loc10_= param2.height;
         var _loc11_= _loc7_ + _loc9_;
         var _loc12_= _loc8_ + _loc10_;
         var _loc13_= x;
         var _loc14_= y;
         var _loc15_= width;
         var _loc16_= height;
         var _loc17_:Float = 1;
         while(_loc17_ < LAY_Max)
         {
            if(!((Std.int(param1 )& Std.int(_loc17_)) != 0))
            {
               _loc17_ <<= 1;continue;
            }
            switch(_loc17_)
            {
               case LAY_SameWidth:
                  _loc15_ = _loc9_ + param5;
                  
               case LAY_SameHeight:
                  _loc16_ = _loc10_ + param6;
                  
               case LAY_Above:
                  _loc14_ = _loc8_ - _loc16_ + param4;
                  
               case LAY_Below:
                  _loc14_ = _loc12_ + param4;
                  
               case LAY_Right:
                  _loc13_ = _loc11_ + param3;
                  
               case LAY_Left:
                  _loc13_ = _loc7_ - _loc15_ + param3;
                  
               case LAY_SameLeft:
                  _loc13_ = _loc7_ + param3;
                  
               case LAY_SameRight:
                  _loc13_ = _loc11_ - _loc15_ + param3;
                  
               case LAY_SameTop:
                  _loc14_ = _loc8_ + param4;
                  
               case LAY_SameBottom:
                  _loc14_ = _loc12_ - _loc16_ + param4;
                  
               case LAY_GrowToRight:
                  _loc15_ = _loc11_ - _loc13_ + param5;
                  
               case LAY_GrowToLeft:
                  _loc15_ = _loc7_ - _loc13_ + param5;
                  
               case LAY_GrowToTop:
                  _loc16_ = _loc8_ - _loc14_ + param6;
                  
               case LAY_GrowToBottom:
                  _loc16_ = _loc12_ - _loc14_ + param6;
                  
               case LAY_SetLeft:
                  _loc13_ = param3;
                  
               case LAY_SetTop:
                  _loc14_ = param4;
                  
               case LAY_SetWidth:
                  _loc15_ = param5;
                  
               case LAY_SetHeight:
                  _loc16_ = param6;
                  
               case LAY_HCenter:
                  _loc13_ = _loc7_ + (_loc9_ - _loc15_) / 2 + param3;
                  
               case LAY_VCenter:
                  _loc14_ = _loc8_ + (_loc10_ - _loc16_) / 2 + param4;
                  
            }
_loc17_ <<= 1;
         }
         this.resize(_loc13_,_loc14_,_loc15_,_loc16_);
      }
      
      public function gotFocus() 
      {
         this.hasFocus = true;
      }
      
      public function getColor(param1:Float) : Color
      {
         if(param1 < 0 || param1 >= this.colors.length)
         {
            return null;
         }
         return this.colors[Std.int(param1)];
      }
      
      public function setVisible(param1:Bool) 
      {
         if(this.visible == param1)
         {
            return;
         }
         this.visible = param1;
         if(this.visible == true)
         {
            markDirty();
         }
         else
         {
            markDirtyFull();
         }
         if(widgetManager != null)
         {
            widgetManager.rehupMouse();
         }
      }
      
      public function resize(param1:Float, param2:Float, param3:Float, param4:Float) 
      {
         if(this.x == param1 && this.y == param2 && this.width == param3 && this.height == param4)
         {
            return;
         }
         markDirtyFull();
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
         this.mBounds.x = param1;
         this.mBounds.y = param2;
         this.mBounds.width = param3;
         this.mBounds.height = param4;
         markDirty();
         if(widgetManager != null)
         {
            widgetManager.rehupMouse();
         }
      }
      
      public function orderInManagerChanged() 
      {
      }
      
      override public function onKeyUp(param1:UInt) 
      {
      }
      
      override public function onMouseUp(param1:Float, param2:Float) 
      {
      }
      
      override public function onKeyDown(param1:UInt) 
      {
         if(param1 == Keyboard.TAB)
         {
            if(widgetManager.keyDown[Keyboard.SHIFT])
            {
               if(this.tabPrev != null)
               {
                  widgetManager.setFocus(this.tabPrev);
               }
            }
            else if(this.tabNext != null)
            {
               widgetManager.setFocus(this.tabNext);
            }
         }
      }
      
      override public function draw(param1:Graphics2D) 
      {
      }
      
      public function showFinger(param1:Bool) 
      {
         if(widgetManager == null)
         {
            return;
         }
         widgetManager.showFinger(param1,this);
      }
      
      override public function update() 
      {
         super.update();
      }
      
      public function widgetRemovedHelper() 
      {
         var _loc5_:CWidget = null;
         var _loc6_:CPreModalInfo = null;
         if(widgetManager == null)
         {
            return;
         }
         var _loc1_= widgets.length;
         var _loc2_= 0;
         while(_loc2_ < _loc1_)
         {
            (_loc5_ = widgets[_loc2_]).widgetRemovedHelper();
            _loc2_++;
         }
         widgetManager.disableWidget(this);
         var _loc3_= widgetManager.preModalInfoList;
         var _loc4_= _loc3_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            if((_loc6_ = _loc3_[_loc2_]).prevBaseModalWidget == this)
            {
               _loc6_.prevBaseModalWidget = null;
            }
            if(_loc6_.prevFocusWidget == this)
            {
               _loc6_.prevFocusWidget = null;
            }
            _loc2_++;
         }
         removedFromManager(widgetManager);
         markDirtyFull(this);
         widgetManager = null;
      }
      
      override public function onMouseDown(param1:Float, param2:Float) 
      {
      }
      
      public function move(param1:Float, param2:Float) 
      {
         this.resize(param1,param2,width,height);
      }
      
      override public function onMouseDrag(param1:Float, param2:Float) 
      {
      }
      
      override public function onMouseLeave() 
      {
      }
      
      public function drawOverlay(param1:Graphics2D, param2:Float = 0) 
      {
      }
      
      override public function onMouseEnter() 
      {
      }
      
      override public function onMouseWheel(param1:Float) 
      {
      }
      
      override public function onMouseMove(param1:Float, param2:Float) 
      {
      }
      
      public function setPolyShape(param1:Vector<Point>) 
      {
         var _loc8_:Point = null;
         this.mPolyShape = param1;
         var _loc2_:Float = ASCompat.MAX_FLOAT;
         var _loc3_:Float = ASCompat.MIN_FLOAT;
         var _loc4_:Float = ASCompat.MAX_FLOAT;
         var _loc5_:Float = ASCompat.MIN_FLOAT;
         var _loc6_= param1.length;
         var _loc7_= 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = param1[_loc7_];
            _loc2_ = Math.min(_loc8_.x,_loc2_);
            _loc3_ = Math.max(_loc8_.x,_loc3_);
            _loc4_ = Math.min(_loc8_.y,_loc4_);
            _loc5_ = Math.max(_loc8_.y,_loc5_);
            _loc7_++;
         }
         this.mBounds.left = _loc2_;
         this.mBounds.right = _loc3_;
         this.mBounds.top = _loc4_;
         this.mBounds.bottom = _loc5_;
         this.x = this.mBounds.x;
         this.y = this.mBounds.y;
         this.width = this.mBounds.width;
         this.height = this.mBounds.height;
         this.mUsePolyShape = true;
      }
      
      override public function onKeyChar(param1:UInt) 
      {
      }
      
      public function setDisabled(param1:Bool) 
      {
         if(this.disabled == param1)
         {
            return;
         }
         this.disabled = param1;
         if(param1 && widgetManager != null)
         {
            widgetManager.disableWidget(this);
         }
         markDirty();
         if(!param1 && widgetManager != null && this.contains(widgetManager.lastMouseX,widgetManager.lastMouseY))
         {
            widgetManager.setMousePosition(widgetManager.lastMouseX,widgetManager.lastMouseY);
         }
      }
   }

