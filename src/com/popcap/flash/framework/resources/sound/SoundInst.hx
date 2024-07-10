package com.popcap.flash.framework.resources.sound
;
   import flash.events.Event;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
    class SoundInst
   {
       
      
      public var mNumPlays:Int = 0;
      
      public var mDead:Bool = false;
      
      var mChannel:SoundChannel;
      
      public var mData:SoundData;
      
      var mTrans:SoundTransform;
      
      var mPosition:Float = 0;
      
      public function new()
      {
         //super();
         this.mTrans = new SoundTransform();
      }
      
      function die() 
      {
         this.mDead = true;
         this.mChannel = null;
         --this.mData.mRefCount;
      }
      
      function handleComplete(param1:Event) 
      {
         this.mChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mChannel = null;
         this.play();
      }
      
      public function stop() 
      {
         if(this.mChannel == null)
         {
            return;
         }
         this.mChannel.stop();
         this.die();
      }
      
      public function resume() 
      {
         if(this.mDead)
         {
            return;
         }
         if(this.mChannel != null)
         {
            return;
         }
         this.mChannel = this.mData.mSource.play(this.mPosition,0,this.mTrans);
         if(this.mChannel == null)
         {
            this.die();
            return;
         }
         this.mChannel.addEventListener(Event.SOUND_COMPLETE,this.handleComplete);
      }
      
      public function play(param1:Float = 1, param2:Float = 0) 
      {
         if(this.mDead)
         {
            return;
         }
         if(this.mChannel != null)
         {
            return;
         }
         if(this.mNumPlays == 0)
         {
            this.die();
            return;
         }
         if(this.mNumPlays > 0)
         {
            --this.mNumPlays;
         }
         this.mTrans.volume = param1;
         this.mChannel = this.mData.mSource.play(param2,0,this.mTrans);
         if(this.mChannel == null)
         {
            this.die();
            return;
         }
         this.mChannel.addEventListener(Event.SOUND_COMPLETE,this.handleComplete);
      }
      
      public function isDead() : Bool
      {
         return this.mDead;
      }
      
      public function pause() 
      {
         if(this.mChannel == null)
         {
            return;
         }
         this.mPosition = this.mChannel.position;
         this.mChannel.stop();
         this.mChannel = null;
      }
      
      public function setVolume(param1:Float) 
      {
         this.mTrans.volume = param1;
         if(this.mChannel != null)
         {
            this.mChannel.soundTransform = this.mTrans;
         }
      }
   }

