package com.popcap.flash.framework.resources.particles
;
    class FloatParameterTrackNode
   {
       
      
      public var mDistribution:CurveType;
      
      public var mTime:Float = Math.NaN;
      
      public var mHighValue:Float = Math.NaN;
      
      public var mLowValue:Float = Math.NaN;
      
      public var mCurveType:CurveType;
      
      public function new()
      {
         //super();
         this.mDistribution = CurveType.CONSTANT;
      }
      
      public function toString() : String
      {
         return "range=[" + this.mLowValue + " " + this.mHighValue + "] time=" + this.mTime + " curve=" + this.mCurveType + " dist=" + this.mDistribution;
      }
   }

