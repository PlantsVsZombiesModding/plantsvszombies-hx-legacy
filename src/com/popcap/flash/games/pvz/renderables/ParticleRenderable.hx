package com.popcap.flash.games.pvz.renderables
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   
    class ParticleRenderable implements Renderable
   {
       
      
      var mDepth:Float = Math.NaN;
      
      var mEffect:ParticleSystem;
      
      public function new(effect:ParticleSystem, depth:Float = 0)
      {
         //super();
         this.mEffect = effect;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Bool
      {
         return this.mEffect.mDead;
      }
      
      public function draw(g:Graphics2D) 
      {
         this.mEffect.draw(g);
      }
      
      public function update() 
      {
         this.mEffect.update();
      }
      
      public function getIsVisible() : Bool
      {
         return true;
      }
      
      public function getDepth() : Float
      {
         return this.mDepth;
      }
      
      public function toString() : String
      {
         return "Particle@" + this.mDepth;
      }
   }

