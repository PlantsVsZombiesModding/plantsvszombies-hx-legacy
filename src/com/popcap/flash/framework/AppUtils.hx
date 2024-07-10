package com.popcap.flash.framework
;
    class AppUtils
   {
       
      
      public function new()
      {
         //super();
      }
      
      public static function asNumber(param1:String, param2:Float = 0) : Float
      {
         if(param1 == null)
         {
            return param2;
         }
         var _loc3_= Std.parseFloat(param1);
         if(Math.isNaN(_loc3_))
         {
            return param2;
         }
         return _loc3_;
      }
      
      public static function asBoolean(param1:String, param2:Bool = false) : Bool
      {
         if(param1 == null || param1.length == 0)
         {
            return param2;
         }
         if(param1.toLowerCase() == "true")
         {
            return true;
         }
         var _loc3_= Std.parseFloat(param1);
         if(Math.isNaN(_loc3_))
         {
            return false;
         }
         if(_loc3_ > 0)
         {
            return true;
         }
         return false;
      }
   }

