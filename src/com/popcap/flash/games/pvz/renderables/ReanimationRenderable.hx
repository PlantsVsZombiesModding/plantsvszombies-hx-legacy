package com.popcap.flash.games.pvz.renderables
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import flash.geom.Matrix;
   
    class ReanimationRenderable implements Renderable
   {
      
      static final mScratchMatrix:Matrix = new Matrix();
       
      
      var mLerped:Bool = false;
      
      var mReanim:Reanimation;
      
      var mDepth:Float = Math.NaN;
      
      public function new(reanim:Reanimation, depth:Float, lerped:Bool = false)
      {
         //super();
         this.mReanim = reanim;
         this.mDepth = depth;
         this.mLerped = lerped;
      }
      
      public function getIsDisposable() : Bool
      {
         return this.mReanim.mIsDead;
      }
      
      public function draw(g:Graphics2D) 
      {
         if(this.mLerped)
         {
            this.mReanim.drawLerp(g,mScratchMatrix,1);
            return;
         }
         this.mReanim.draw(g);
      }
      
      public function getDepth() : Float
      {
         return this.mDepth;
      }
      
      public function update() 
      {
         this.mReanim.update();
      }
      
      public function getIsVisible() : Bool
      {
         return true;
      }
      
      public function toString() : String
      {
         return "Reanim@" + this.mDepth;
      }
   }

