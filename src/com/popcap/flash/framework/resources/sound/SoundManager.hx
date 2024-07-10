package com.popcap.flash.framework.resources.sound
;
   import com.popcap.flash.framework.AppBase;
   
    class SoundManager
   {
       
      
      var mGlobalVolume:Float = 1;
      
      var mInstPool:Array<ASAny>;
      
      var mApp:AppBase;
      
      var mMuted:Bool = false;
      
      public function new(param1:AppBase)
      {
         this.mInstPool = new Array<ASAny>();
         //super();
         this.mApp = param1;
      }
      
      function getData(param1:String) : SoundData
      {
         var _loc2_:ASObject = this.mApp.resourceManager.getResource(param1);
         var _loc3_= ASCompat.dynamicAs(_loc2_ , SoundDescriptor);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.createData();
            this.mApp.resourceManager.setResource(param1,_loc2_);
         }
         var _loc4_:SoundData;
         if((_loc4_ = ASCompat.dynamicAs(_loc2_ , SoundData)) == null)
         {
            throw new Error("Sound \'" + param1 + "\' is not loaded.");
         }
         return _loc4_;
      }
      
      public function isMuted() : Bool
      {
         return this.mMuted;
      }
      
      public function playSound(param1:String, param2:Float = 1) : SoundInst
      {
         var _loc3_= this.getData(param1);
         var _loc4_:SoundInst;
         (_loc4_ = this.getSoundInst(_loc3_,Std.int(param2))).play(this.mGlobalVolume);
         return _loc4_;
      }
      
      public function resumeAll() 
      {
         var _loc3_:SoundInst = null;
         var _loc1_= this.mInstPool.length;
         var _loc2_= 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mInstPool[_loc2_];
            _loc3_.resume();
            _loc2_++;
         }
      }
      
      function getSoundInst(param1:SoundData, param2:Int) : SoundInst
      {
         var _loc3_:SoundInst = null;
         var _loc6_:SoundInst = null;
         var _loc4_= this.mInstPool.length;
         var _loc5_= 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = this.mInstPool[_loc5_]).isDead())
            {
               _loc3_ = _loc6_;
               break;
            }
            _loc5_++;
         }
         if(_loc3_ == null)
         {
            _loc3_ = new SoundInst();
            this.mInstPool.push(_loc3_);
         }
         _loc3_.mDead = false;
         _loc3_.mData = param1;
         _loc3_.mNumPlays = param2;
         param1.mRefCount += 1;
         return _loc3_;
      }
      
      public function setVolume(param1:Float) 
      {
         var _loc4_:SoundInst = null;
         this.mGlobalVolume = param1;
         var _loc2_= this.mInstPool.length;
         var _loc3_= 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.mInstPool[_loc3_]).setVolume(this.mGlobalVolume);
            _loc3_++;
         }
      }
      
      public function pauseAll() 
      {
         var _loc3_:SoundInst = null;
         var _loc1_= this.mInstPool.length;
         var _loc2_= 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mInstPool[_loc2_];
            _loc3_.pause();
            _loc2_++;
         }
      }
      
      public function toggleMute() 
      {
         if(this.mMuted)
         {
            this.unmute();
         }
         else
         {
            this.mute();
         }
      }
      
      public function addDescriptor(param1:String, param2:SoundDescriptor) 
      {
         this.mApp.resourceManager.setResource(param1,param2);
      }
      
      public function unmute() 
      {
         this.mMuted = false;
         this.setVolume(1);
      }
      
      public function getNumPlaying(param1:String) : Float
      {
         var _loc2_= this.getData(param1);
         return _loc2_.mRefCount;
      }
      
      public function mute() 
      {
         this.mMuted = true;
         this.setVolume(0);
      }
      
      public function stopAll() 
      {
         var _loc3_:SoundInst = null;
         var _loc1_= this.mInstPool.length;
         var _loc2_= 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mInstPool[_loc2_];
            _loc3_.stop();
            _loc2_++;
         }
      }
   }

