package com.popcap.flash.framework.resources.music
;
   import com.popcap.flash.framework.AppBase;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundLoaderContext;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   
    class MusicManager
   {
       
      
      var mFadeVolume:Float = 0;
      
      var mPlayingChannel:SoundChannel;
      
      var mPlayingPosition:Float = Math.NaN;
      
      var mQueuedLoop:Bool = false;
      
      var mSongs:ASDictionary<ASAny,ASAny>;
      
      var mFailed:Bool = false;
      
      var mFadeTimer:Float = 0;
      
      var mIdle:Bool = true;
      
      var mSoundTransform:SoundTransform;
      
      var mIDs:Array<ASAny>;
      
      var mLoop:Bool = false;
      
      var mApp:AppBase;
      
      var mFadeTime:Float = 0;
      
      var mQueuedId:MusicId = null;
      
      var mPlayingId:MusicId;
      
      var mMuted:Bool = false;
      
      public function new(param1:AppBase)
      {
         //super();
         this.mApp = param1;
         this.mIDs = new Array<ASAny>();
         this.mSongs = new ASDictionary<ASAny,ASAny>();
         this.mSoundTransform = new SoundTransform();
      }
      
      function handleError(param1:IOErrorEvent) 
      {
         throw new Error("Unable to load music.\n" + param1.toString());
      }
      
      function handleComplete(param1:Event) 
      {
         if(this.mPlayingId == null)
         {
            return;
         }
         this.mPlayingChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mPlayingChannel = null;
         this.mPlayingPosition = 0;
         this.resumeMusic();
      }
      
      public function resumeMusic() 
      {
         if(this.mPlayingId == null)
         {
            this.mFailed = false;
            return;
         }
         if(this.mPlayingChannel != null)
         {
            this.mFailed = false;
            return;
         }
         var _loc1_:Sound = this.mSongs[this.mPlayingId];
         var _loc2_= _loc1_.play(this.mPlayingPosition,0,this.mSoundTransform);
         if(_loc2_ == null)
         {
            this.mFailed = true;
            return;
         }
         this.mPlayingChannel = _loc2_;
         if(this.mLoop)
         {
            this.mPlayingChannel.addEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         }
         this.mPlayingPosition = 0;
         this.mFailed = false;
      }
      
      public function pauseMusic() 
      {
         if(this.mPlayingChannel == null)
         {
            return;
         }
         this.mPlayingPosition = this.mPlayingChannel.position;
         this.mPlayingChannel.stop();
         this.mPlayingChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mPlayingChannel = null;
      }
      
      public function update() 
      {
         var _loc1_:SoundTransform = null;
         if(this.mFadeTimer > 0)
         {
            --this.mFadeTimer;
            this.mFadeVolume = this.mFadeTimer / this.mFadeTime;
            if(this.mPlayingChannel != null && !this.mMuted)
            {
               _loc1_ = this.mPlayingChannel.soundTransform;
               _loc1_.volume = this.mFadeVolume;
               this.mPlayingChannel.soundTransform = _loc1_;
            }
            if(this.mFadeTimer == 0)
            {
               this.playMusic(this.mQueuedId,this.mQueuedLoop,0);
            }
         }
         if(!this.mFailed)
         {
            return;
         }
         this.resumeMusic();
      }
      
      public function stopMusic(param1:MusicId) 
      {
         if(this.mPlayingChannel == null)
         {
            return;
         }
         this.mPlayingPosition = 0;
         this.mPlayingChannel.stop();
         this.mPlayingChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mPlayingChannel = null;
         this.mPlayingId = null;
      }
      
      public function playMusic(param1:MusicId, param2:Bool = true, param3:Float = 0) 
      {
         var _loc4_:Sound;
         if((_loc4_ = this.mSongs[param1]) == null)
         {
            throw new Error("Cannot play unregistered music with id \'" + param1 + "\'");
         }
         if(this.mPlayingId != null && param3 > 0)
         {
            this.mFadeTime = param3;
            this.mFadeTimer = this.mFadeTime;
            this.mQueuedLoop = param2;
            this.mQueuedId = param1;
            return;
         }
         if(this.mPlayingId != null)
         {
            this.stopMusic(this.mPlayingId);
         }
         this.mPlayingId = param1;
         this.mPlayingPosition = 0;
         this.mLoop = param2;
         var _loc5_:SoundChannel;
         if((_loc5_ = _loc4_.play(0,0,this.mSoundTransform)) == null)
         {
            this.mFailed = true;
            return;
         }
         this.mPlayingChannel = _loc5_;
         if(this.mLoop)
         {
            this.mPlayingChannel.addEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         }
         this.mFailed = false;
      }
      
      public function registerMusic(param1:MusicId, param2:String) : Bool
      {
         if(this.mSongs[param1] != null)
         {
            throw new Error("Music is already registered to id \'" + param1 + "\'");
         }
         var _loc3_= new Sound();
         var _loc4_= new URLRequest(param2);
         var _loc5_= new SoundLoaderContext(1000,true);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         _loc3_.load(_loc4_,_loc5_);
         this.mSongs[param1] = _loc3_;
         this.mIDs.push(param1);
         return true;
      }
      
      public function mute() 
      {
         this.mSoundTransform.volume = 0;
         if(this.mPlayingChannel != null)
         {
            this.mPlayingChannel.soundTransform = this.mSoundTransform;
         }
         this.mMuted = true;
      }
      
      public function stopAllMusic() 
      {
         var _loc1_:MusicId = null;
         for (_tmp_ in this.mIDs)
         {
_loc1_  = _tmp_;
            this.stopMusic(_loc1_);
         }
      }
      
      public function isMuted() : Bool
      {
         return this.mMuted;
      }
      
      public function unmute() 
      {
         this.mSoundTransform.volume = 1;
         if(this.mPlayingChannel != null)
         {
            this.mPlayingChannel.soundTransform = this.mSoundTransform;
         }
         this.mMuted = false;
      }
      
      public function getPlayingId() : MusicId
      {
         return this.mPlayingId;
      }
   }

