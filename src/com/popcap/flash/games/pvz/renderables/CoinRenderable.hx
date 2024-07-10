package com.popcap.flash.games.pvz.renderables
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.games.pvz.logic.Coin;
   
    class CoinRenderable implements Renderable
   {
       
      
      var mDepth:Float = Math.NaN;
      
      var mCoin:Coin;
      
      public function new(coin:Coin, depth:Float = 0)
      {
         //super();
         this.mCoin = coin;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Bool
      {
         return this.mCoin.mDead;
      }
      
      public function draw(g:Graphics2D) 
      {
         this.mCoin.Draw(g);
      }
      
      public function update() 
      {
         this.mCoin.Update();
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
         return "Coin@" + this.mDepth;
      }
   }

