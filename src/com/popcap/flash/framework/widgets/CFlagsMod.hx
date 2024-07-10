package com.popcap.flash.framework.widgets
;
    class CFlagsMod
   {
       
      
      public var removeFlags:Float = 0;
      
      public var addFlags:Float = 0;
      
      public function new()
      {
         //super();
      }
      
      public static function getModFlags(param1:Float, param2:CFlagsMod) : Float
      {
         return (Std.int(param1 )| Std.int(param2.addFlags)) & ~param2.removeFlags;
      }
   }

