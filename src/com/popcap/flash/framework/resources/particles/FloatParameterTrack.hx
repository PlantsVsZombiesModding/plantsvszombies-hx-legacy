package com.popcap.flash.framework.resources.particles
;
    class FloatParameterTrack
   {
       
      
      public var mNodes:Array<ASAny>;
      
      public function new()
      {
         //super();
         this.mNodes = new Array<ASAny>();
      }
      
      public function curveEvaluate(param1:Float, param2:Float, param3:Float, param4:CurveType) : Float
      {
         var _loc5_= Math.NaN;
         switch(param4)
         {
            case CurveType.CONSTANT:
               _loc5_ = 0;
               
            case CurveType.LINEAR:
               _loc5_ = param1;
               
            case CurveType.EASE_IN:
               _loc5_ = this.curveQuad(param1);
               
            case CurveType.EASE_OUT:
               _loc5_ = this.curveInvQuad(param1);
               
            case CurveType.EASE_IN_OUT:
               _loc5_ = this.curveS(this.curveS(param1));
               
            case CurveType.EASE_IN_OUT_WEAK:
               _loc5_ = this.curveS(param1);
               
            case CurveType.FAST_IN_OUT:
               _loc5_ = this.curveInvQuadS(this.curveInvQuadS(param1));
               
            case CurveType.FAST_IN_OUT_WEAK:
               _loc5_ = this.curveInvQuadS(param1);
               
            case CurveType.BOUNCE:
               _loc5_ = this.curveBounce(param1);
               
            case CurveType.BOUNCE_FAST_MIDDLE:
               _loc5_ = this.curveQuad(this.curveBounce(param1));
               
            case CurveType.BOUNCE_SLOW_MIDDLE:
               _loc5_ = this.curveInvQuad(this.curveBounce(param1));
               
            case CurveType.SIN_WAVE:
               _loc5_ = Math.sin(param1 * Math.PI * 2);
               
            case CurveType.EASE_SIN_WAVE:
               _loc5_ = Math.sin(this.curveS(param1) * Math.PI * 2);
               
            default:
               throw new Error("Unknown curve type \'" + param4 + "\'");
         }
         return param2 + (param3 - param2) * _loc5_;
      }
      
      function curveInvQuad(param1:Float) : Float
      {
         return 2 * param1 - param1 * param1;
      }
      
      public function scale(param1:Float) 
      {
         var _loc4_:FloatParameterTrackNode = null;
         var _loc2_= this.mNodes.length;
         var _loc3_= 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.mNodes[_loc3_];
            _loc4_.mHighValue *= param1;
            _loc4_.mLowValue *= param1;
            _loc3_++;
         }
      }
      
      function curveS(param1:Float) : Float
      {
         return 3 * param1 * param1 - 2 * param1 * param1 * param1;
      }
      
      function curveQuadS(param1:Float) : Float
      {
         if(param1 <= 0.5)
         {
            return this.curveQuad(param1 * 2) * 0.5;
         }
         return this.curveInvQuad((param1 - 0.5) * 2) * 0.5 + 0.5;
      }
      
      public function evaluateLast(param1:Float, param2:Float) : Float
      {
         if(param1 < 0)
         {
            return 0;
         }
         return this.evaluate(param1,param2);
      }
      
      function curveInvQuadS(param1:Float) : Float
      {
         if(param1 <= 0.5)
         {
            return this.curveInvQuad(param1 * 2) * 0.5;
         }
         return this.curveQuad((param1 - 0.5) * 2) * 0.5 + 0.5;
      }
      
      public function isConstantZero() : Bool
      {
         if(this.mNodes.length == 0)
         {
            return true;
         }
         if(this.mNodes.length != 1)
         {
            return false;
         }
         var _loc1_:FloatParameterTrackNode = this.mNodes[0];
         if(_loc1_.mLowValue == 0 && _loc1_.mHighValue == 0)
         {
            return true;
         }
         return false;
      }
      
      public function isSet() : Bool
      {
         if(this.mNodes.length == 0)
         {
            return false;
         }
         if(this.mNodes[0].mCurveType == CurveType.CONSTANT)
         {
            return false;
         }
         return true;
      }
      
      public function evaluate(param1:Float, param2:Float) : Float
      {
         var _loc7_:FloatParameterTrackNode = null;
         var _loc8_:FloatParameterTrackNode = null;
         var _loc9_= Math.NaN;
         var _loc10_= Math.NaN;
         var _loc11_= Math.NaN;
         if(this.mNodes.length == 0)
         {
            return 0;
         }
         var _loc3_:FloatParameterTrackNode = this.mNodes[0];
         if(param1 < _loc3_.mTime)
         {
            return this.curveEvaluate(param2,_loc3_.mLowValue,_loc3_.mHighValue,_loc3_.mDistribution);
         }
         var _loc4_= this.mNodes.length;
         var _loc5_= 1;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = this.mNodes[_loc5_];
            if(param1 <= _loc7_.mTime)
            {
               _loc8_ = this.mNodes[_loc5_ - 1];
               _loc9_ = (param1 - _loc8_.mTime) / (_loc7_.mTime - _loc8_.mTime);
               _loc10_ = this.curveEvaluate(param2,_loc8_.mLowValue,_loc8_.mHighValue,_loc8_.mDistribution);
               _loc11_ = this.curveEvaluate(param2,_loc7_.mLowValue,_loc7_.mHighValue,_loc7_.mDistribution);
               return this.curveEvaluate(_loc9_,_loc10_,_loc11_,_loc8_.mCurveType);
            }
            _loc5_++;
         }
         var _loc6_:FloatParameterTrackNode = this.mNodes[_loc4_ - 1];
         return this.curveEvaluate(param2,_loc6_.mLowValue,_loc6_.mHighValue,_loc6_.mDistribution);
      }
      
      public function toString() : String
      {
         return "[FloatParameterTrack -- " + this.mNodes + "]";
      }
      
      function curveQuad(param1:Float) : Float
      {
         return param1 * param1;
      }
      
      function curveBounce(param1:Float) : Float
      {
         return 1 - Math.abs(1 - param1 * 2);
      }
      
      public function setDefault(param1:Float) 
      {
         if(this.mNodes.length != 0 || param1 == 0)
         {
            return;
         }
         var _loc2_= new FloatParameterTrackNode();
         _loc2_.mTime = 0;
         _loc2_.mLowValue = param1;
         _loc2_.mHighValue = param1;
         _loc2_.mCurveType = CurveType.CONSTANT;
         _loc2_.mDistribution = CurveType.LINEAR;
         this.mNodes.push(_loc2_);
      }
   }

