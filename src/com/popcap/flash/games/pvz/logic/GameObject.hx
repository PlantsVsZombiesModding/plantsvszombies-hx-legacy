package com.popcap.flash.games.pvz.logic
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.games.pvz.PVZApp;
   
    class GameObject
   {
      
      public static inline final RENDER_LAYER_GROUND= 200000;
      
      public static inline final RENDER_LAYER_UI_TOP= 700000;
      
      public static inline final RENDER_LAYER_LAWN= 300000;
      
      public static final RENDER_LAYER_PARTICLE:Int = RENDER_LAYER_LAWN + 7000;
      
      public static final RENDER_LAYER_PLANT:Int = RENDER_LAYER_LAWN + 2000;
      
      public static final RENDER_LAYER_LAWN_MOWER:Int = RENDER_LAYER_LAWN + 6000;
      
      public static final RENDER_LAYER_PROJECTILE:Int = RENDER_LAYER_LAWN + 5000;
      
      public static inline final RENDER_LAYER_FOG= 500000;
      
      public static inline final RENDER_LAYER_ABOVE_UI= 800000;
      
      public static inline final RENDER_LAYER_COIN_BANK= 600000;
      
      public static final RENDER_LAYER_GRAVE_STONE:Int = RENDER_LAYER_LAWN + 1000;
      
      public static inline final RENDER_LAYER_SCREEN_FADE= 900000;
      
      public static final RENDER_LAYER_ZOMBIE:Int = RENDER_LAYER_LAWN + 3000;
      
      public static inline final RENDER_LAYER_TOP= 400000;
      
      public static inline final RENDER_LAYER_UI_BOTTOM= 100000;
       
      
      public var mBoard:Board;
      
      public var app:PVZApp;
      
      public var mRenderOrder:Int = 0;
      
      public var mVisible:Bool = false;
      
      public var mX:Int = 0;
      
      public var mY:Int = 0;
      
      public var mRow:Int = 0;
      
      public var mHeight:Int = 0;
      
      public var mWidth:Int = 0;
      
      public function new()
      {
         //super();
      }
      
      public function MakeParentGraphicsFrame(g:Graphics2D) 
      {
      }
      
      public function BeginDraw(g:Graphics2D) : Bool
      {
         if(!this.mVisible)
         {
            return false;
         }
         g.translate(this.mX,this.mY);
         return true;
      }
      
      public function EndDraw(g:Graphics2D) 
      {
         g.translate(-this.mX,-this.mY);
      }
   }

