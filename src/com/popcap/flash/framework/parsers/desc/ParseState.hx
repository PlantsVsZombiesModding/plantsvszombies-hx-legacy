package com.popcap.flash.framework.parsers.desc
;
    class ParseState
   {
       
      
      public var line:String = "";
      
      public var linePosition:Float = 0;
      
      public function new()
      {
         //super();
      }
      
      public function isEOF() : Bool
      {
         return this.linePosition >= this.line.length;
      }
      
      public function readChar() : String
      {
         return this.line.charAt(Std.int(this.linePosition++));
      }
   }

