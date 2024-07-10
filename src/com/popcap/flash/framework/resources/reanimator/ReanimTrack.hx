package com.popcap.flash.framework.resources.reanimator
;
    class ReanimTrack
   {
       
      
      public var transforms:Array<ASAny>;
      
      public var name:String;
      
      public var numTransforms:Float = Math.NaN;
      
      public function new()
      {
         //super();
         this.name = "";
         this.transforms = new Array<ASAny>();
         this.numTransforms = 0;
      }
   }

