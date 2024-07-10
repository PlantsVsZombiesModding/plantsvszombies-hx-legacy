package com
{

   import com.XMLC_Version;
   import com.XMLC_Cheats;

   /*
      this class exists for one reason,
      cant export if xml is referenced,
      if the class has XML in it, it just wont convert the file. 
      so it'll say it doesnt exist.
      kind of bullshitty but whatever.
   */   

   public class XMLC
   {
      public var version:XMLC_Version;
      public var cheats:XMLC_Cheats;

      public var MSN:XMLC_Cheats;

      public var x:Number = 0;
      public var y:Number = 0;

      public var kx:Number = 0;
      public var ky:Number = 0;

      public var sx:Number = 0;
      public var sy:Number = 0;

      public var f:Number = 0;

      public var a:Number = 0;

      public var i:Number = 0;

      public var fps:Number = 0;

      public var track:Array;
      public var t:Array;
      public var name:String = "";

      public var upsell:Boolean = false;

      public function XMLC(p1:Number)
      {
         cheats = new XMLC_Cheats();
         version = new XMLC_Version();
         MSN = new XMLC_Cheats();
      }

      public function copy()
      {
         return this;
      }
   }
}