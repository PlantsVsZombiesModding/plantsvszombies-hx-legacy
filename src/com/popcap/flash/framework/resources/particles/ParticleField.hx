package com.popcap.flash.framework.resources.particles
;
    class ParticleField
   {
       
      
      public var mFieldType:ParticleFieldType;
      
      public var mX:FloatParameterTrack;
      
      public var mY:FloatParameterTrack;
      
      public function new()
      {
         //super();
         this.mX = new FloatParameterTrack();
         this.mY = new FloatParameterTrack();
      }
   }

