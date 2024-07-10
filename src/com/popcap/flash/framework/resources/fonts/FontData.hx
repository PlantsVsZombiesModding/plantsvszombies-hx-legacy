package com.popcap.flash.framework.resources.fonts
;
   
    class FontData
   {
       
      
      public var mPointSize:Float = Math.NaN;
      
      public var layerMap:ASDictionary<ASAny,ASAny>;
      
      public var layerList:Array<ASAny>;
      
      var mAscent:Float = 19;
      
      var mAscentPadding:Float = 0;
      
      var mHeight:Float = Math.NaN;
      
      var mLineSpacingOffset:Float = 0;
      
      public function new()
      {
         //super();
         this.layerList = new Array<ASAny>();
         this.layerMap = new ASDictionary<ASAny,ASAny>();
      }
      
      public function charWidthKern(param1:Float, param2:Float) : Float
      {
         var _loc6_:CharData = null;
         if(this.layerList.length == 0)
         {
            return 0;
         }
         var _loc3_:Float = 0;
         var _loc4_= this.layerList.length;
         var _loc5_= 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = this.layerList[_loc5_].getCharData(param1);
            _loc3_ = _loc3_ < _loc6_.mWidth ? _loc6_.mWidth : _loc3_;
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getAscent() : Float
      {
         var _loc2_:FontLayer = null;
         var _loc1_:Float = 0;
         for (_tmp_ in this.layerList)
         {
_loc2_  = _tmp_;
            _loc1_ = _loc2_.mAscent > _loc1_ ? _loc2_.mAscent : _loc1_;
         }
         return _loc1_;
      }
      
      public function getDescent() : Float
      {
         return 0;
      }
      
      public function charWidth(param1:Float) : Float
      {
         return this.charWidthKern(param1,0);
      }
      
      public function stringImageWidth(param1:String) : Float
      {
         var _loc7_= Math.NaN;
         var _loc8_= Math.NaN;
         var _loc9_= 0;
         var _loc10_= 0;
         var _loc11_:FontLayer = null;
         var _loc12_:CharData = null;
         var _loc13_= Math.NaN;
         var _loc14_= Math.NaN;
         var _loc15_= Math.NaN;
         var _loc16_= Math.NaN;
         var _loc17_= Math.NaN;
         var _loc2_:FontLayer = this.layerList[0];
         var _loc3_:Float = 0;
         var _loc4_:Float = 0;
         var _loc5_= param1.length;
         var _loc6_= 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1.charCodeAt(_loc6_);
            _loc8_ = _loc4_;
            _loc9_ = this.layerList.length;
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc12_ = (_loc11_ = this.layerList[_loc10_]).getCharData(Std.int(_loc7_));
               _loc13_ = _loc4_;
               _loc14_ = 0;
               _loc15_ = _loc12_.mWidth;
               _loc16_ = _loc13_ + _loc2_.mOffset.x + _loc12_.mOffset.x;
               _loc17_ = -(_loc11_.mAscent - _loc11_.mOffset.y - _loc12_.mOffset.y);
               if(_loc12_.mImage != null)
               {
                  _loc3_ = _loc16_ + _loc12_.mImage.width;
               }
               if((_loc13_ += _loc15_ + _loc14_) > _loc8_)
               {
                  _loc8_ = _loc13_;
               }
               _loc10_++;
            }
            _loc4_ = _loc8_;
            _loc6_++;
         }
         return _loc3_;
      }
      
      public function getHeight() : Float
      {
         var _loc2_:FontLayer = null;
         var _loc1_:Float = 0;
         for (_tmp_ in this.layerList)
         {
_loc2_  = _tmp_;
            _loc1_ = _loc2_.height > _loc1_ ? _loc2_.height : _loc1_;
         }
         return _loc1_;
      }
      
      function getMappedChar(param1:Float) : Float
      {
         return 0;
      }
      
      public function getAscentPadding() : Float
      {
         return this.mAscentPadding;
      }
      
      public function getLineSpacingOffset() : Float
      {
         return 0;
      }
      
      public function stringWidth(param1:String) : Float
      {
         var _loc6_= Math.NaN;
         var _loc2_:Float = 0;
         var _loc3_:Float = 0;
         var _loc4_= param1.length;
         var _loc5_= 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.charCodeAt(_loc5_);
            _loc2_ += this.charWidthKern(_loc6_,_loc3_);
            _loc3_ = _loc6_;
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function getLineSpacing() : Float
      {
         var _loc2_:FontLayer = null;
         var _loc1_:Float = 0;
         for (_tmp_ in this.layerList)
         {
_loc2_  = _tmp_;
            _loc1_ = _loc2_.mSpacing > _loc1_ ? _loc2_.mSpacing : _loc1_;
         }
         return _loc1_;
      }
   }

