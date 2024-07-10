package com.popcap.flash.framework.resources.foley
;
    class FoleyTypeData
   {
       
      
      public var mLastVariationPlayed:Float = -1;
      
      public var mLastPlayed:Int = 0;
      
      public var mType:FoleyType;
      
      public function new(type:FoleyType)
      {
         //super();
         this.mType = type;
      }
   }

