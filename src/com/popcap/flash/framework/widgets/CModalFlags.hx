package com.popcap.flash.framework.widgets
;
    class CModalFlags
   {
       
      
      public var overFlags:Float = 0;
      
      public var isOver:Bool = false;
      
      public var underFlags:Float = 0;
      
      public function new()
      {
         //super();
      }
      
      public function getFlags() : Float
      {
         return this.isOver ? this.overFlags : this.underFlags;
      }
   }

