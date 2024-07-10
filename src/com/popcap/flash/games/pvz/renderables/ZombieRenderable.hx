package com.popcap.flash.games.pvz.renderables
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.games.pvz.logic.zombies.Zombie;
   
    class ZombieRenderable implements Renderable
   {
       
      
      var mDepth:Float = Math.NaN;
      
      var mZombie:Zombie;
      
      public function new(zombie:Zombie, depth:Float = 0)
      {
         //super();
         this.mZombie = zombie;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Bool
      {
         return this.mZombie.mDead;
      }
      
      public function draw(g:Graphics2D) 
      {
         this.mZombie.Draw(g);
      }
      
      public function getDepth() : Float
      {
         return this.mDepth;
      }
      
      public function update() 
      {
         this.mZombie.Update();
      }
      
      public function getIsVisible() : Bool
      {
         return true;
      }
      
      public function toString() : String
      {
         return "Zombie@" + this.mDepth;
      }
   }

