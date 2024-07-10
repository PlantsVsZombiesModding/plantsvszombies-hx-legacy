package com.popcap.flash.framework.resources.foley
;
   import com.popcap.flash.framework.utils.Flags;
   
    class FoleyFlags extends Flags
   {
      
      public static inline final LOOP:UInt = 1;
      
      public static inline final USES_MUSIC_VOLUME:UInt = 8;
      
      public static inline final DONT_REPEAT:UInt = 16;
      
      public static inline final MUTE_ON_PAUSE:UInt = 4;
      
      public static inline final ONE_AT_A_TIME:UInt = 2;
      
      public static final NONE:FoleyFlags = new FoleyFlags();
       
      
      public function new(flags:UInt = 0)
      {
         super();
         //super();
         setFlags(flags);
      }
   }

