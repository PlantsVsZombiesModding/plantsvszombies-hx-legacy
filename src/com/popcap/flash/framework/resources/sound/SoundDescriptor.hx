package com.popcap.flash.framework.resources.sound
;
   import flash.media.Sound;
   
    class SoundDescriptor
   {
       
      
      var mSoundClass:Class<Dynamic>;
      
      public function new(param1:Class<Dynamic>)
      {
         //super();
         this.mSoundClass = param1;
      }
      
      public function createData() : SoundData
      {
         return new SoundData(ASCompat.dynamicAs(Type.createInstance(this.mSoundClass, []) , Sound));
      }
   }

