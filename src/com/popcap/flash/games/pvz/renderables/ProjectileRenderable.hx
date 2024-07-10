package com.popcap.flash.games.pvz.renderables
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.games.pvz.logic.Projectile;
   
    class ProjectileRenderable implements Renderable
   {
       
      
      var mDepth:Float = Math.NaN;
      
      var mProjectile:Projectile;
      
      public function new(projectile:Projectile, depth:Float = 0)
      {
         //super();
         this.mProjectile = projectile;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Bool
      {
         return this.mProjectile.mDead;
      }
      
      public function draw(g:Graphics2D) 
      {
         this.mProjectile.Draw(g);
      }
      
      public function getDepth() : Float
      {
         return this.mDepth;
      }
      
      public function toString() : String
      {
         return "Projectile@" + this.mDepth;
      }
      
      public function update() 
      {
         this.mProjectile.Update();
      }
      
      public function getIsVisible() : Bool
      {
         return true;
      }
   }

