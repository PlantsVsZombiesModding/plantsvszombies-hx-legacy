package com.popcap.flash.framework.resources.reanimator.looptypes
;
   import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   
    class ReanimLoopOnceAndHold extends ReanimLoopType
   {
       
      
      var mCallback:ASFunction;
      
      public function new(callback:ASFunction = null)
      {
         super();
         //super();
         this.mCallback = callback;
      }
      
      override public function updatePositive(reanim:Reanimation) 
      {
         if(reanim.animTime > 1)
         {
            reanim.animTime = 1;
         }
         if(reanim.animTime == 1 && this.mCallback != null)
         {
            this.mCallback();
            this.mCallback = null;
         }
      }
      
      override public function updateNegative(reanim:Reanimation) 
      {
         if(reanim.animTime < 0)
         {
            reanim.animTime = 0;
         }
         if(reanim.animTime == 0 && this.mCallback != null)
         {
            this.mCallback();
            this.mCallback = null;
         }
      }
      
      override public function doHold() : Bool
      {
         return true;
      }
   }

