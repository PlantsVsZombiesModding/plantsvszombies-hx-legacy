package com.popcap.flash.games.pvz.logic.Zombies
;
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopQueue;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.GameObject;
   import com.popcap.flash.games.pvz.logic.MessageWidget;
   import com.popcap.flash.games.pvz.logic.plants.CPlant;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.renderables.ReanimationRenderable;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
    class Zombie extends GameObject
   {
      
      static inline final GRIDSIZEX= 9;
      
      public static inline final SEED_PUFFSHROOM= 8;
      
      static inline final COIN_MOTION_COIN= "coin";
      
      static inline final HEIGHT_ZOMBIE_NORMAL= 0;
      
      static inline final PHASE_ZOMBIE_BURNED= 2;
      
      public static inline final SEED_PEASHOOTER= 0;
      
      static inline final DAMAGE_HITS_SHIELD_AND_BODY= 1;
      
      static inline final CLIP_HEIGHT_LIMIT:Float = -67.5;
      
      static inline final ATTACKTYPE_VAULT= 1;
      
      public static var mScratchPosition:ZombieDrawPosition = new ZombieDrawPosition();
      
      static inline final PHASE_ZOMBIE_DYING= 1;
      
      static inline final DAMAGE_SPIKE= 5;
      
      public static inline final ZOMBIE_NORMAL= 0;
      
      public static inline final ZOMBIE_WAVE_DEBUG= -1;
      
      public static inline final ZOMBIE_DOOR= 6;
      
      static inline final LAWN_XMIN= 40;
      
      static inline final SCENE_CHALLENGE= 7;
      
      public static inline final SEED_EXPLODE_O_NUT= 50;
      
      static inline final COIN_NONE= "none";
      
      public static inline final SEED_SUNFLOWER= 1;
      
      static inline final SCENE_PLAYING= 3;
      
      static inline final PHASE_ZOMBIE_NORMAL= 0;
      
      static inline final LAWN_XMAX= 760;
      
      static inline final SCENE_CREDIT= 6;
      
      public static inline final SEED_NONE= -1;
      
      static inline final SCENE_LOADING= 0;
      
      public static inline final SEED_CHOMPER= 6;
      
      public static inline final ZOMBIE_PAIL= 4;
      
      static inline final HEIGHT_FALLING= 1;
      
      public static inline final SEED_CHERRYBOMB= 2;
      
      static inline final SHIELDTYPE_DOOR= 1;
      
      static inline final SCENE_MENU= 1;
      
      static inline final COIN_SHOVEL= "shovel";
      
      static inline final TICKS_BETWEEN_EATS= 4;
      
      static inline final HELMTYPE_PAIL= 2;
      
      static inline final SCENE_LEVEL_INTRO= 2;
      
      static inline final HELMTYPE_FOOTBALL= 3;
      
      static inline final SHIELDTYPE_NEWSPAPER= 2;
      
      public static inline final ZOMBIE_FOOTBALL= 7;
      
      static final gChilledColor:Color = Color.ARGB(1,0.29,0.29,1);
      
      static inline final DAMAGE_BYPASSES_SHIELD= 0;
      
      static inline final DAMAGE_FREEZE= 2;
      
      static inline final COIN_MOTION_FROM_PLANT= "from plant";
      
      static inline final ATTACKTYPE_CHEW= 0;
      
      static inline final COIN_FINAL_SEED_PACKET= "finalseedpacket";
      
      public static inline final ZOMBIE_WAVE_UI= -3;
      
      static inline final CHILLED_SPEED_FACTOR:Float = 0.4;
      
      static inline final CLIP_HEIGHT_OFF:Float = -135;
      
      static inline final COIN_PRESENT_PLANT= "presentplant";
      
      static inline final PHASE_NEWSPAPER_MAD= 9;
      
      public static inline final SEED_SUNSHROOM= 9;
      
      static inline final LAWN_YMIN= 80;
      
      static inline final PHASE_POLEVAULTER_IN_VAULT= 5;
      
      public static inline final SEED_WALLNUT= 3;
      
      public static inline final SEED_REPEATER= 7;
      
      public static inline final ZOMBIE_NEWSPAPER= 5;
      
      public static inline final SEED_FUMESHROOM= 10;
      
      static inline final HELMTYPE_NONE= 0;
      
      static inline final COIN_MOTION_FROM_SKY= "from sky";
      
      static inline final SCENE_AWARD= 5;
      
      static inline final COIN_SUN= "sun";
      
      public static inline final ZOMBIE_WAVE_WINNER= -4;
      
      static inline final COIN_MOTION_FROM_SKY_SLOW= "from sky slow";
      
      static inline final HELMTYPE_TRAFFIC_CONE= 1;
      
      public static inline final ZOMBIE_WAVE_CUTSCENE= -2;
      
      static inline final DAMAGE_DOESNT_LEAVE_BODY= 4;
      
      public static inline final SEED_SNOWPEA= 5;
      
      static inline final COIN_USABLE_SEED_PACKET= "usableseedpacket";
      
      public static inline final ZOMBIE_INVALID= -1;
      
      static inline final PHASE_POLEVAULTER_PRE_VAULT= 4;
      
      static inline final PHASE_NEWSPAPER_READING= 7;
      
      public static inline final ZOMBIE_TRAFFIC_CONE= 2;
      
      static inline final BOARD_HEIGHT= 405;
      
      static inline final LAWN_YMAX= 620;
      
      public static inline final SEED_SQUASH= 4;
      
      static inline final PHASE_POLEVAULTER_POST_VAULT= 6;
      
      static inline final SCENE_ZOMBIES_WON= 4;
      
      static inline final PHASE_ZOMBIE_MOWERED= 3;
      
      static inline final PHASE_NEWSPAPER_MADDENING= 8;
      
      static inline final COIN_NOTE= "note";
      
      static inline final SHIELDTYPE_NONE= 0;
      
      public static inline final ZOMBIE_FLAG= 1;
      
      static inline final PHASE_RISING_FROM_GRAVE= 10;
      
      public static inline final SEED_LEFTPEATER= 49;
      
      static inline final BOARD_WIDTH= 540;
      
      public static inline final ZOMBIE_POLEVAULTER= 3;
      
      static inline final DAMAGE_DOESNT_CAUSE_FLASH= 3;
      
      static inline final GRIDSIZEY= 5;
      
      public static inline final SEED_GRAVEBUSTER= 11;
       
      
      public var mZombieHeight:Int = 0;
      
      public var mAnimCounter:Int = 0;
      
      public var mZombieFade:Int = 0;
      
      public var mOnHighGround:Bool = false;
      
      var scratchDrawPos:ZombieDrawPosition;
      
      public var mFlatTires:Bool = false;
      
      public var mAltitude:Float = Math.NaN;
      
      public var mButteredCounter:Int = 0;
      
      public var mShieldHealth:Int = 0;
      
      public var mHasArm:Bool = false;
      
      public var mTargetCol:Int = 0;
      
      public var mZombiePhase:Int = 0;
      
      var mArmParticle:ParticleSystem;
      
      public var mShieldJustGotShotCounter:Int = 0;
      
      public var mVelX:Float = Math.NaN;
      
      public var mIceTrapCounter:Int = 0;
      
      public var mVelZ:Float = Math.NaN;
      
      public var mAnimFrames:Int = 0;
      
      public var mHasHead:Bool = false;
      
      public var mSummonCounter:Int = 0;
      
      public var mDead:Bool = false;
      
      var mHitRectUpdated:Bool = false;
      
      public var mYuckyFace:Bool = false;
      
      public var mHasObject:Bool = false;
      
      public var mPosX:Float = Math.NaN;
      
      public var mPosY:Float = Math.NaN;
      
      public var mParticleOffsetY:Int = 0;
      
      public var mShieldType:Int = 0;
      
      public var mParticleOffsetX:Int = 0;
      
      public var mZombieType:Int = 0;
      
      public var mJustGotShotCounter:Int = 0;
      
      public var mFlyingHealth:Int = 0;
      
      public var mIsEating:Bool = false;
      
      public var mFlyingMaxHealth:Int = 0;
      
      public var mBodyHealth:Int = 0;
      
      var mHelmParticle:ParticleSystem;
      
      public var mFrame:Int = 0;
      
      public var mZombieAge:Int = 0;
      
      public var mPrevFrame:Int = 0;
      
      public var mPhaseCounter:Int = 0;
      
      public var mHelmType:Int = 0;
      
      var mFlagParticle:ParticleSystem;
      
      public var mUseLadderCol:Int = 0;
      
      public var mHitUmbrella:Bool = false;
      
      public var mMindControlled:Bool = false;
      
      public var mFromWave:Int = 0;
      
      public var mShieldMaxHealth:Int = 0;
      
      public var mBodyReanim:Reanimation;
      
      public var mVariant:Bool = false;
      
      public var mBlowingAway:Bool = false;
      
      public var mScaleZombie:Float = Math.NaN;
      
      public var mAnimTicksPerFrame:Int = 0;
      
      public var mZombieRect:Rectangle;
      
      public var mOrginalAnimRate:Float = Math.NaN;
      
      public var mAttachment:Reanimation;
      
      public var mChilledCounter:Int = 0;
      
      public var mHelmHealth:Int = 0;
      
      var mOverrideColor:Color;
      
      var mAdditiveColor:Color;
      
      var mHeadParticle:ParticleSystem;
      
      public var mZombieAttackRect:Rectangle;
      
      var mZombieHitRect:Rectangle;
      
      public var mInPool:Bool = false;
      
      public var mPlayingSong:Bool = false;
      
      public var mGroanCounter:Int = 0;
      
      public var mShieldRecoilCounter:Int = 0;
      
      public var mHelmMaxHealth:Int = 0;
      
      public var mDroppedLoot:Bool = false;
      
      var mScratchMatrix:Matrix;
      
      public var mBodyMaxHealth:Int = 0;
      
      public function new()
      {
         super();
         this.mOverrideColor = Color.ARGB(1,1,1,1);
         this.mAdditiveColor = Color.ARGB(1,0,0,0);
         this.scratchDrawPos = new ZombieDrawPosition();
         this.mScratchMatrix = new Matrix();
         this.mZombieHitRect = new Rectangle();
         //super();
      }
      
      public function CheckForBoardEdge() 
      {
         var velocity= Math.NaN;
         var aWinPos= -50;
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            aWinPos = -75;
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            aWinPos = -100;
         }
         if(mX <= aWinPos && this.mHasHead)
         {
            velocity = this.mBodyReanim.getTrackVelocity("_ground",true);
            this.mPosX = -95;
            mBoard.ZombiesWon(this);
         }
         if(mX <= aWinPos + 35 && !this.mHasHead)
         {
            this.TakeDamage(1800,DAMAGE_DOESNT_CAUSE_FLASH);
         }
      }
      
      public function UpdateZombieWalking() 
      {
         var aSpeed= Math.NaN;
         var anEffect:ParticleSystem = null;
         if(this.ZombieNotWalking())
         {
            return;
         }
         if(this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT)
         {
            aSpeed = this.mVelX;
         }
         else if(this.mBodyReanim != null)
         {
            aSpeed = this.mBodyReanim.getTrackVelocity("_ground");
         }
         this.mPosX -= aSpeed;
         if(this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT)
         {
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.16))
            {
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.67))
            {
            }
         }
         if(this.mZombieType == ZOMBIE_FOOTBALL && this.mFromWave != ZOMBIE_WAVE_WINNER)
         {
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.03))
            {
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.61))
            {
            }
         }
      }
      
      public function ZombieNotWalking() : Bool
      {
         if(this.mIsEating)
         {
            return true;
         }
         if(this.mZombiePhase == PHASE_NEWSPAPER_MADDENING)
         {
            return true;
         }
         return false;
      }
      
      public function EatPlant(thePlant:CPlant) 
      {
         if(thePlant.mSeedType == CPlant.SEED_CHERRYBOMB || thePlant.mSeedType == CPlant.SEED_SQUASH)
         {
            return;
         }
         this.StartEating();
         var aTriggerSpecial= false;
         if(aTriggerSpecial)
         {
            thePlant.DoSpecial();
            return;
         }
         if(this.mChilledCounter > 0 && this.mZombieAge % 2 == 1)
         {
            this.mBodyReanim.animRate *= 0.5;
            return;
         }
         thePlant.mPlantHealth -= TICKS_BETWEEN_EATS;
         thePlant.mRecentlyEatenCountdown = 50;
         if(thePlant.mPlantHealth <= 0)
         {
            app.foleyManager.playFoley(PVZFoleyType.GULP);
            thePlant.Die();
            if(mBoard.mLevel >= 2 && mBoard.mLevel <= 4 && thePlant.mPlantCol > 4 && mBoard.mPlants.length < 15 && thePlant.mSeedType == SEED_PEASHOOTER)
            {
               mBoard.DisplayAdvice("[ADVICE_PEASHOOTER_DIED]",MessageWidget.MESSAGE_STYLE_HINT_TALL_FAST,Board.ADVICE_PEASHOOTER_DIED);
            }
         }
      }
      
      public function AttachShield() 
      {
         var aAttachTrack:String = null;
         if(this.mShieldType == SHIELDTYPE_DOOR)
         {
            this.ShowDoorArms(true);
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_screendoor",true);
            aAttachTrack = "anim_screendoor1";
         }
         else if(this.mShieldType == SHIELDTYPE_NEWSPAPER)
         {
            this.mBodyReanim.setTrackVisible("Zombie_paper_hands",true);
            this.mBodyReanim.setTrackVisible("Zombie_paper_paper2",false);
            this.mBodyReanim.setTrackVisible("Zombie_paper_paper3",false);
            aAttachTrack = "Zombie_paper_paper1";
         }
         this.mBodyReanim.setTrackVisible(aAttachTrack,true);
      }
      
      public function ApplyBurn() 
      {
         var aCharredPosX= Math.NaN;
         var aCharredPosY= Math.NaN;
         var aCharredReanim:Reanimation = null;
         if(this.mDead || this.mZombiePhase == PHASE_ZOMBIE_BURNED)
         {
            return;
         }
         if(this.mZombieType == ZOMBIE_FOOTBALL && this.mHelmHealth >= 1800)
         {
            this.TakeDamage(1800,DAMAGE_HITS_SHIELD_AND_BODY);
            return;
         }
         if(this.mZombiePhase == PHASE_ZOMBIE_DYING || this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT)
         {
            this.DieWithLoot();
         }
         else
         {
            aCharredPosX = this.mPosX;
            aCharredPosY = this.mPosY - 8;
            aCharredReanim = app.reanimator.createReanimation("REANIM_ZOMBIE_CHARRED");
            aCharredReanim.currentTrack = "anim_crumble";
            aCharredReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
            aCharredReanim.x = aCharredPosX;
            aCharredReanim.y = aCharredPosY;
            aCharredReanim.animRate = 15;
            mBoard.mRenderManager.add(new ReanimationRenderable(aCharredReanim,GameObject.RENDER_LAYER_ZOMBIE + mRow));
            this.DieWithLoot();
         }
      }
      
      public function FindPlantTarget(theAttackType:Int) : CPlant
      {
         var aPlant:CPlant = null;
         var aPlantRect:Rectangle = null;
         var aOverlap= 0;
         var aAttackRect= this.GetZombieAttackRect();
         for (_tmp_ in mBoard.mPlants)
         {
aPlant  = _tmp_;
            if(mRow == aPlant.mRow)
            {
               aPlantRect = aPlant.GetPlantRect();
               aOverlap = mBoard.GetRectOverlap(aAttackRect,aPlantRect);
               if(aOverlap >= 20)
               {
                  if(this.CanTargetPlant(aPlant,theAttackType))
                  {
                     return aPlant;
                  }
               }
            }
         }
         return null;
      }
      
      public function IsImmobilizied() : Bool
      {
         return false;
      }
      
      public function StopEating() 
      {
         if(!this.mIsEating)
         {
            return;
         }
         this.mIsEating = false;
         this.StartWalkAnim(20);
         this.UpdateAnimSpeed();
      }
      
      public function SetupDrawZombieWon(g:Graphics2D) : Bool
      {
         if(this.mFromWave != ZOMBIE_WAVE_WINNER)
         {
            return true;
         }
         if(!mBoard.mShowZombieWalking)
         {
            return false;
         }
         g.setClipRect(-85 - mX,0 - mY,540,405);
         return true;
      }
      
      public function PickRandomSpeed() 
      {
         this.mVelX = TodCommon.RandRangeFloat(0.23,0.37);
         if(this.mZombiePhase == PHASE_NEWSPAPER_MAD)
         {
            this.mVelX = TodCommon.RandRangeFloat(0.89,0.91);
         }
         else if(this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT)
         {
            this.mVelX = TodCommon.RandRangeFloat(0.66,0.68);
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            this.mVelX = TodCommon.RandRangeFloat(0.66,0.68);
         }
         else if(this.mZombieType == ZOMBIE_FLAG)
         {
            this.mVelX = 0.45;
         }
         else if(this.mVelX < 0.3)
         {
            this.mAnimTicksPerFrame = 12;
         }
         else
         {
            this.mAnimTicksPerFrame = 15;
         }
         this.UpdateAnimSpeed();
      }
      
      public function TakeHelmDamage(theDamage:Int, theDamageFlags:Int) : Int
      {
         if(theDamageFlags != DAMAGE_DOESNT_CAUSE_FLASH)
         {
            this.mJustGotShotCounter = 25;
         }
         var aOldIndex= this.GetHelmDamageIndex();
         var aDamageApplied= Std.int(Math.min(this.mHelmHealth,theDamage));
         var aDamageRemaining= theDamage - aDamageApplied;
         this.mHelmHealth -= aDamageApplied;
         if(theDamageFlags == DAMAGE_FREEZE)
         {
            this.ApplyChill(false);
         }
         if(this.mHelmHealth == 0)
         {
            this.DropHelm(theDamageFlags);
            return aDamageRemaining;
         }
         var aNewIndex= this.GetHelmDamageIndex();
         if(aOldIndex != aNewIndex)
         {
            if(this.mHelmType == HELMTYPE_TRAFFIC_CONE && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("anim_cone1",false);
               this.mBodyReanim.setTrackVisible("anim_cone2",true);
            }
            else if(this.mHelmType == HELMTYPE_TRAFFIC_CONE && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("anim_cone2",false);
               this.mBodyReanim.setTrackVisible("anim_cone3",true);
            }
            else if(this.mHelmType == HELMTYPE_PAIL && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("anim_bucket1",false);
               this.mBodyReanim.setTrackVisible("anim_bucket2",true);
            }
            else if(this.mHelmType == HELMTYPE_PAIL && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("anim_bucket2",false);
               this.mBodyReanim.setTrackVisible("anim_bucket3",true);
            }
            else if(this.mHelmType == HELMTYPE_FOOTBALL && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("zombie_football_helmet1",false);
               this.mBodyReanim.setTrackVisible("zombie_football_helmet2",true);
            }
            else if(this.mHelmType == HELMTYPE_FOOTBALL && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("zombie_football_helmet2",false);
               this.mBodyReanim.setTrackVisible("zombie_football_helmet3",true);
            }
         }
         return aDamageRemaining;
      }
      
      public function CheckIfPreyCaught() 
      {
         var aPlant:CPlant = null;
         if(this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT || this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT || this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            return;
         }
         if(!this.mHasHead)
         {
            return;
         }
         var aTicksPerBite= TICKS_BETWEEN_EATS;
         if(this.mChilledCounter > 0)
         {
            aTicksPerBite *= 2;
         }
         if(this.mZombieAge % aTicksPerBite != 0)
         {
            return;
         }
         if(!this.mMindControlled)
         {
            aPlant = this.FindPlantTarget(ATTACKTYPE_CHEW);
            if(aPlant != null)
            {
               this.EatPlant(aPlant);
               return;
            }
         }
         if(this.mIsEating)
         {
            this.StopEating();
         }
      }
      
      public function GetDrawPos(theDrawPos:ZombieDrawPosition) 
      {
         var aHeightLimit= Math.NaN;
         theDrawPos.mImageOffsetX = this.mPosX - mX;
         theDrawPos.mImageOffsetY = this.mPosY - mY;
         if(this.mIsEating)
         {
            theDrawPos.mHeadX = 31;
            theDrawPos.mHeadY = 3;
         }
         else if(this.mFrame == 0)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 2;
         }
         else if(this.mFrame == 1)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 1;
         }
         else if(this.mFrame == 2)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 2;
         }
         else if(this.mFrame == 3)
         {
            theDrawPos.mHeadX = 32;
            theDrawPos.mHeadY = 3;
         }
         else if(this.mFrame == 4)
         {
            theDrawPos.mHeadX = 32;
            theDrawPos.mHeadY = 4;
         }
         else if(this.mFrame == 5)
         {
            theDrawPos.mHeadX = 32;
            theDrawPos.mHeadY = 3;
         }
         else if(this.mFrame == 6)
         {
            theDrawPos.mHeadX = 32;
            theDrawPos.mHeadY = 2;
         }
         else if(this.mFrame == 7)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 1;
         }
         else if(this.mFrame == 8)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 2;
         }
         else if(this.mFrame == 9)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 3;
         }
         else if(this.mFrame == 10)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 4;
         }
         else
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 3;
         }
         theDrawPos.mArmY = Std.int(theDrawPos.mHeadY / 2);
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            theDrawPos.mImageOffsetX += -6;
            theDrawPos.mImageOffsetY += -11;
         }
         if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            theDrawPos.mImageOffsetY += -16;
         }
         if(this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            theDrawPos.mBodyY = -this.mAltitude;
            aHeightLimit = Math.min(this.mPhaseCounter,40);
            theDrawPos.mClipHeight = theDrawPos.mBodyY + aHeightLimit;
         }
         theDrawPos.mBodyY = -this.mAltitude;
         theDrawPos.mClipHeight = CLIP_HEIGHT_OFF;
      }
      
      public function IsDeadOrDying() : Bool
      {
         if(this.mDead || this.mZombiePhase == PHASE_ZOMBIE_DYING || this.mZombiePhase == PHASE_ZOMBIE_BURNED || this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            return true;
         }
         return false;
      }
      
      public function UpdateBurn() 
      {
         --this.mPhaseCounter;
         if(this.mPhaseCounter == 0)
         {
            this.DieWithLoot();
         }
      }
      
      public function DropLoot() 
      {
         if(!this.IsOnBoard())
         {
            return;
         }
         this.TrySpawnLevelAward();
         if(this.mDroppedLoot)
         {
            return;
         }
         if(mBoard.HasLevelAwardDropped())
         {
            return;
         }
         if(!mBoard.CanDropLoot())
         {
            return;
         }
         this.mDroppedLoot = true;
      }
      
      public function StartEating() 
      {
         if(this.mIsEating)
         {
            return;
         }
         this.mIsEating = true;
         if(this.mZombiePhase == PHASE_NEWSPAPER_MAD)
         {
            this.mBodyReanim.currentTrack = "anim_eat_nopaper";
         }
         else
         {
            this.mBodyReanim.currentTrack = "anim_eat";
         }
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            this.mBodyReanim.animRate = 20;
         }
         else
         {
            this.mBodyReanim.animRate = 36;
         }
      }
      
      public function GetHelmDamageIndex() : Int
      {
         if(this.mHelmHealth < this.mHelmMaxHealth / 3)
         {
            return 2;
         }
         if(this.mHelmHealth < this.mHelmMaxHealth * 2 / 3)
         {
            return 1;
         }
         return 0;
      }
      
      public function ZombieInitialize(theRow:Int, theType:Int, theVariant:Bool, theParentZombie:Zombie, theFromWave:Int, app:PVZApp, theBoard:Board) 
      {
         var aIdlePermuation= Math.NaN;
         this.app = app;
         mBoard = theBoard;
         mRow = theRow;
         this.mFromWave = theFromWave;
         this.mPosX = BOARD_WIDTH - 13 + Math.random() * 27;
         this.mPosY = this.GetPosYBasedOnRow(theRow);
         mWidth = 81;
         mHeight = 81;
         this.mVelX = 0;
         this.mVelZ = 0;
         this.mFrame = 0;
         this.mPrevFrame = 0;
         this.mZombieType = theType;
         this.mVariant = theVariant;
         this.mIsEating = false;
         this.mJustGotShotCounter = 0;
         this.mShieldJustGotShotCounter = 0;
         this.mShieldRecoilCounter = 0;
         this.mChilledCounter = 0;
         this.mIceTrapCounter = 0;
         this.mButteredCounter = 0;
         this.mMindControlled = false;
         this.mBlowingAway = false;
         this.mHasHead = true;
         this.mHasArm = true;
         this.mHasObject = false;
         this.mInPool = false;
         this.mOnHighGround = false;
         this.mHelmType = HELMTYPE_NONE;
         this.mShieldType = SHIELDTYPE_NONE;
         this.mYuckyFace = false;
         this.mAnimCounter = 0;
         this.mGroanCounter = TodCommon.RandRangeInt(400,500);
         this.mAnimTicksPerFrame = 12;
         this.mAnimFrames = 12;
         this.mZombieAge = 0;
         this.mTargetCol = -1;
         this.mZombiePhase = PHASE_ZOMBIE_NORMAL;
         this.mZombieHeight = HEIGHT_ZOMBIE_NORMAL;
         this.mPhaseCounter = 0;
         this.mHitUmbrella = false;
         this.mDroppedLoot = false;
         this.mZombieRect = new Rectangle(25,0,28,77);
         this.mZombieAttackRect = new Rectangle(40,0,14,77);
         this.mPlayingSong = false;
         this.mZombieFade = -1;
         this.mFlatTires = false;
         this.mUseLadderCol = -1;
         this.mShieldHealth = 0;
         this.mHelmHealth = 0;
         this.mFlyingHealth = 0;
         this.mSummonCounter = 0;
         this.mScaleZombie = 1;
         this.mAltitude = 0;
         this.mOrginalAnimRate = 0;
         this.mBodyHealth = 270;
         switch(theType)
         {
            case ZOMBIE_NORMAL:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               
            case ZOMBIE_TRAFFIC_CONE:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mHelmType = HELMTYPE_TRAFFIC_CONE;
               this.mHelmHealth = 370;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               
            case ZOMBIE_PAIL:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mHelmType = HELMTYPE_PAIL;
               this.mHelmHealth = 1100;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               
            case ZOMBIE_FLAG:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mHasObject = true;
               this.mPosX = BOARD_WIDTH;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               
            case ZOMBIE_DOOR:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mHasObject = true;
               this.mShieldType = SHIELDTYPE_DOOR;
               this.mShieldHealth = 1100;
               this.mPosX = BOARD_WIDTH;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               
            case ZOMBIE_NEWSPAPER:
               this.mBodyReanim = app.reanimator.createReanimation(PVZReanims.REANIM_ZOMBIE_PAPER);
               this.mHasObject = true;
               this.mShieldType = SHIELDTYPE_NEWSPAPER;
               this.mZombiePhase = PHASE_NEWSPAPER_READING;
               this.mShieldHealth = 150;
               this.mPosX = BOARD_WIDTH;
               this.mVariant = false;
               this.AttachShield();
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               if(this.IsOnBoard())
               {
                  this.mBodyReanim.currentTrack = "anim_walk";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.PickRandomSpeed();
               }
               else
               {
                  this.mBodyReanim.currentTrack = "anim_idle";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.mBodyReanim.animTime = Math.random() * 0.99;
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,24);
               }
               
            case ZOMBIE_POLEVAULTER:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE_POLEVAULTER");
               this.mHasObject = true;
               this.mZombiePhase = PHASE_POLEVAULTER_PRE_VAULT;
               this.mBodyHealth = 500;
               this.mVariant = false;
               this.mPosX = BOARD_WIDTH + 50 + Math.random() * 7;
               if(this.IsOnBoard())
               {
                  this.mBodyReanim.currentTrack = "anim_run";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.PickRandomSpeed();
               }
               else
               {
                  this.mBodyReanim.currentTrack = "anim_idle";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.mBodyReanim.animTime = Math.random() * 0.99;
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,24);
               }
               if(mBoard.IsWallnutBowlingLevel())
               {
                  this.mZombieAttackRect = new Rectangle(-154,0,182,77);
               }
               else
               {
                  this.mZombieAttackRect = new Rectangle(-20,0,47,77);
               }
               
            case ZOMBIE_FOOTBALL:
               this.mBodyReanim = app.reanimator.createReanimation(PVZReanims.REANIM_ZOMBIE_FOOTBALL);
               this.mZombieRect = new Rectangle(34,0,38,77);
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               this.mHelmType = HELMTYPE_FOOTBALL;
               this.mHelmHealth = 2800;
               this.mAnimTicksPerFrame = 6;
               this.mVariant = false;
               if(this.IsOnBoard())
               {
                  this.mBodyReanim.setTrackVisible("anim_hair",false);
                  this.mBodyReanim.setTrackVisible("zombie_football_helmet2",false);
                  this.mBodyReanim.setTrackVisible("zombie_football_helmet3",false);
                  this.mBodyReanim.currentTrack = "anim_walk";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.PickRandomSpeed();
               }
               else
               {
                  this.mBodyReanim.setTrackVisible("anim_hair",false);
                  this.mBodyReanim.currentTrack = "anim_idle";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.mBodyReanim.animTime = Math.random() * 0.99;
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,24);
               }
               
            default:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
         }
         if(ASCompat.toBool(mBoard) && mBoard.IsFlagWave(this.mFromWave))
         {
            this.mPosX += 27;
         }
         if(theType == ZOMBIE_NORMAL || theType == ZOMBIE_TRAFFIC_CONE || theType == ZOMBIE_FLAG || theType == ZOMBIE_PAIL || theType == ZOMBIE_DOOR)
         {
            this.mBodyReanim.setTrackVisible("anim_hair",false);
            this.mBodyReanim.setTrackVisible("anim_cone1",false);
            this.mBodyReanim.setTrackVisible("anim_cone2",false);
            this.mBodyReanim.setTrackVisible("anim_cone3",false);
            this.mBodyReanim.setTrackVisible("anim_bucket1",false);
            this.mBodyReanim.setTrackVisible("anim_bucket2",false);
            this.mBodyReanim.setTrackVisible("anim_bucket3",false);
            this.mBodyReanim.setTrackVisible("anim_screendoor1",false);
            this.mBodyReanim.setTrackVisible("anim_screendoor2",false);
            this.mBodyReanim.setTrackVisible("anim_screendoor3",false);
            this.mBodyReanim.setTrackVisible("Zombie_flaghand",false);
            this.mBodyReanim.setTrackVisible("Zombie_duckytube",false);
            this.mBodyReanim.setTrackVisible("anim_tongue",false);
            this.mBodyReanim.setTrackVisible("Zombie_mustache",false);
            this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor",false);
            this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor_hand",false);
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_screendoor",false);
            switch(theType)
            {
               case ZOMBIE_NORMAL:
                  this.mBodyReanim.setTrackVisible("anim_hair",true);
                  
               case ZOMBIE_TRAFFIC_CONE:
                  this.mBodyReanim.setTrackVisible("anim_cone1",true);
                  
               case ZOMBIE_PAIL:
                  this.mBodyReanim.setTrackVisible("anim_bucket1",true);
                  
               case ZOMBIE_FLAG:
                  this.mBodyReanim.setTrackVisible("Zombie_flaghand",true);
                  this.mBodyReanim.setTrackVisible("anim_hair",true);
                  this.mBodyReanim.setTrackVisible("anim_innerarm1",false);
                  this.mBodyReanim.setTrackVisible("anim_innerarm2",false);
                  this.mBodyReanim.setTrackVisible("anim_innerarm3",false);
                  this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor",true);
                  
               case ZOMBIE_DOOR:
                  this.mBodyReanim.setTrackVisible("anim_hair",true);
                  this.mBodyReanim.setTrackVisible("anim_innerarm1",false);
                  this.mBodyReanim.setTrackVisible("anim_innerarm2",false);
                  this.mBodyReanim.setTrackVisible("anim_innerarm3",false);
                  this.AttachShield();
                  this.SetupDoorArms(true);
            }
            if(!this.IsOnBoard())
            {
               aIdlePermuation = Math.random() * 3;
               if(aIdlePermuation > 1 && theType != ZOMBIE_POLEVAULTER)
               {
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,24);
                  this.mBodyReanim.currentTrack = "anim_idle2";
               }
               else
               {
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,18);
                  this.mBodyReanim.currentTrack = "anim_idle";
               }
               this.mBodyReanim.animTime = Math.random() * 0.99;
            }
            else
            {
               this.StartWalkAnim(0);
            }
            this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
            this.PickRandomSpeed();
         }
         this.UpdateAnimSpeed();
         if(this.mVariant)
         {
            this.mBodyReanim.setTrackVisible("anim_tongue",false);
         }
         this.mBodyMaxHealth = this.mBodyHealth;
         this.mHelmMaxHealth = this.mHelmHealth;
         this.mShieldMaxHealth = this.mShieldHealth;
         this.mDead = false;
         mX = Std.int(this.mPosX);
         mY = Std.int(this.mPosY);
         if(this.IsOnBoard())
         {
         }
         this.UpdateReanim();
      }
      
      public function GetZombieAttackRect() : Rectangle
      {
         var aRect= this.mZombieAttackRect.clone();
         var aDrawPos= this.scratchDrawPos;
         this.GetDrawPos(aDrawPos);
         aRect.offset(mX,mY + aDrawPos.mBodyY);
         if(aDrawPos.mClipHeight > CLIP_HEIGHT_LIMIT)
         {
            aRect.height -= aDrawPos.mClipHeight;
         }
         return aRect;
      }
      
      public function ApplyChill(theIsIceTrap:Bool) 
      {
         if(!this.CanBeChilled())
         {
            return;
         }
         if(this.mChilledCounter == 0)
         {
            app.foleyManager.playFoley(PVZFoleyType.FROZEN);
         }
         var aTime= 1000;
         if(theIsIceTrap)
         {
            aTime = 2000;
         }
         this.mChilledCounter = Std.int(Math.max(aTime,this.mChilledCounter));
         this.UpdateAnimSpeed();
      }
      
      public function TakeShieldDamage(theDamage:Int, theDamageFlags:Int) : Int
      {
         if(theDamageFlags != DAMAGE_DOESNT_CAUSE_FLASH || this.mZombieType == ZOMBIE_DOOR || this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            this.mShieldJustGotShotCounter = 25;
            if(this.mJustGotShotCounter < 0)
            {
               this.mJustGotShotCounter = 0;
            }
         }
         if(theDamageFlags != DAMAGE_DOESNT_CAUSE_FLASH && theDamageFlags != DAMAGE_HITS_SHIELD_AND_BODY)
         {
            this.mShieldRecoilCounter = 12;
            if(this.mShieldType == SHIELDTYPE_DOOR)
            {
               app.foleyManager.playFoley(PVZFoleyType.SHIELD_HIT);
            }
         }
         var aOldIndex= this.GetShieldDamageIndex();
         var aDamageApplied= Std.int(Math.min(this.mShieldHealth,theDamage));
         var aDamageRemaining= theDamage - aDamageApplied;
         this.mShieldHealth -= aDamageApplied;
         if(this.mShieldHealth == 0)
         {
            this.DropShield(theDamageFlags);
            return aDamageRemaining;
         }
         var aNewIndex= this.GetShieldDamageIndex();
         if(aOldIndex != aNewIndex)
         {
            if(this.mShieldType == SHIELDTYPE_DOOR && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("anim_screendoor1",false);
               this.mBodyReanim.setTrackVisible("anim_screendoor2",true);
            }
            else if(this.mShieldType == SHIELDTYPE_DOOR && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("anim_screendoor2",false);
               this.mBodyReanim.setTrackVisible("anim_screendoor3",true);
            }
            else if(this.mShieldType == SHIELDTYPE_NEWSPAPER && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("Zombie_paper_paper1",false);
               this.mBodyReanim.setTrackVisible("Zombie_paper_paper2",true);
            }
            else if(this.mShieldType == SHIELDTYPE_NEWSPAPER && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("Zombie_paper_paper2",false);
               this.mBodyReanim.setTrackVisible("Zombie_paper_paper3",true);
            }
         }
         return aDamageRemaining;
      }
      
      public function DieNoLoot() 
      {
         if(this.IsOnBoard() && !this.mDead)
         {
            ++app.mTotalZombiesKilled;
            app.adAPI.setScore(app.mTotalZombiesKilled);
            trace(app.mTotalZombiesKilled);
         }
         this.TrySpawnLevelAward();
         this.mDead = true;
      }
      
      public function ShowDoorArms(theShow:Bool) 
      {
         if(this.mBodyReanim != null)
         {
            this.SetupDoorArms(theShow);
            if(!this.mHasArm)
            {
               this.mBodyReanim.setTrackVisible("Zombie_outerarm_lower",false);
               this.mBodyReanim.setTrackVisible("Zombie_outerarm_hand",false);
            }
         }
      }
      
      public function UpdateZombiePosition() 
      {
         var aDesiredY= Math.NaN;
         if(this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            return;
         }
         this.UpdateZombieWalking();
         if(this.mBlowingAway)
         {
            this.mPosX += 10;
            if(mX > 850)
            {
               this.DieWithLoot();
               return;
            }
         }
         if(this.mZombieHeight == HEIGHT_ZOMBIE_NORMAL)
         {
            aDesiredY = this.GetPosYBasedOnRow(mRow);
            if(this.mPosY < aDesiredY)
            {
               this.mPosY += Math.min(1,aDesiredY - this.mPosY);
            }
            else if(this.mPosY > aDesiredY)
            {
               this.mPosY -= Math.min(1,this.mPosY - aDesiredY);
            }
         }
      }
      
      public function WalkIntoHouse() 
      {
         this.mFromWave = ZOMBIE_WAVE_WINNER;
         if(this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT)
         {
            this.mZombiePhase = PHASE_POLEVAULTER_POST_VAULT;
            this.StartWalkAnim(0);
         }
         this.mPosY = 196;
      }
      
      public function Animate() 
      {
         var aEatingTicksPerFrame= 0;
         var aLeftHandTime= Math.NaN;
         var aRightHandTime= Math.NaN;
         this.mPrevFrame = this.mFrame;
         if(this.IsImmobilizied())
         {
            return;
         }
         ++this.mAnimCounter;
         if(this.mIsEating && this.mHasHead)
         {
            aEatingTicksPerFrame = 6;
            if(this.mChilledCounter > 0)
            {
               aEatingTicksPerFrame = 12;
            }
            if(this.mAnimCounter >= this.mAnimFrames * aEatingTicksPerFrame)
            {
               this.mAnimCounter = aEatingTicksPerFrame;
            }
            this.mFrame = Std.int(this.mAnimCounter / aEatingTicksPerFrame);
            aLeftHandTime = 0.14;
            aRightHandTime = 0.68;
            if(this.mZombieType == ZOMBIE_POLEVAULTER)
            {
               aLeftHandTime = 0.38;
               aRightHandTime = 0.8;
            }
            else if(this.mZombieType == ZOMBIE_NEWSPAPER)
            {
               aLeftHandTime = 0.42;
               aRightHandTime = 0.42;
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(aLeftHandTime) || this.mBodyReanim.shouldTriggerTimedEvent(aRightHandTime))
            {
               this.AnimateChewSound();
               this.AnimateChewEffect();
            }
            return;
         }
         if(this.mAnimCounter >= this.mAnimFrames * this.mAnimTicksPerFrame)
         {
            this.mAnimCounter = 0;
         }
         this.mFrame = Std.int(this.mAnimCounter / this.mAnimTicksPerFrame);
      }
      
      public function GetPosYBasedOnRow(theRow:Int) : Float
      {
         if(!this.IsOnBoard())
         {
            return 0;
         }
         return mBoard.GetPosYBasedOnRow(this.mPosX + 40,theRow) - 30;
      }
      
      public function EffectedByDamage() : Bool
      {
         if(this.IsDeadOrDying())
         {
            return false;
         }
         if(this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT || this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            return false;
         }
         return true;
      }
      
      public function DropArm(theDamageFlags:Int) 
      {
         var anImage:ImageInst = null;
         if(!this.CanLoseBodyParts())
         {
            return;
         }
         if(!this.mHasArm)
         {
            return;
         }
         if(this.mShieldType == SHIELDTYPE_DOOR || this.mShieldType == SHIELDTYPE_NEWSPAPER)
         {
            return;
         }
         if(this.mZombiePhase == PHASE_NEWSPAPER_READING)
         {
            return;
         }
         this.mHasArm = false;
         if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            this.mBodyReanim.setTrackVisible("Zombie_paper_hands",false);
            this.mBodyReanim.setTrackVisible("Zombie_paper_leftarm_lower",false);
         }
         else if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            this.mBodyReanim.setTrackVisible("Zombie_polevaulter_outerarm_lower",false);
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_hand",false);
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            this.mBodyReanim.setTrackVisible("Zombie_football_rightarm_lower",false);
            this.mBodyReanim.setTrackVisible("Zombie_football_rightarm_hand",false);
         }
         else
         {
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_lower",false);
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_hand",false);
         }
         if(this.mZombieType != ZOMBIE_NORMAL)
         {
            return;
         }
         var anEffect= PVZParticles.PARTICLE_ZOMBIEARM;
         var aDrawPos= this.scratchDrawPos;
         this.GetDrawPos(aDrawPos);
         var aPosX= this.mPosX + aDrawPos.mImageOffsetX + 20;
         var aPosY= this.mPosY + aDrawPos.mImageOffsetY + aDrawPos.mBodyY + 78 * 0.675;
         var aPoint= new Point(0,0);
         if(this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            anEffect = PVZParticles.PARTICLE_MOWEREDZOMBIEARM;
         }
         aPosX += aPoint.x;
         aPosY += aPoint.y;
         this.mArmParticle = app.particleManager.spawnParticleSystem(anEffect);
         this.mArmParticle.setPosition(aPosX,aPosY);
         if(this.mChilledCounter > 0)
         {
            this.mArmParticle.mEmitterList[0].mColorOverride = gChilledColor;
         }
         app.foleyManager.playFoley(PVZFoleyType.LIMBS_POP);
      }
      
      public function Update() 
      {
         this.mHitRectUpdated = false;
         ++this.mZombieAge;
         if(mBoard.mGameScene != SCENE_PLAYING && this.IsOnBoard() && this.mFromWave != ZOMBIE_WAVE_WINNER)
         {
            return;
         }
         if(this.mZombiePhase == PHASE_ZOMBIE_BURNED)
         {
            this.UpdateBurn();
         }
         else if(this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            this.UpdateMowered();
         }
         else if(this.mZombiePhase == PHASE_ZOMBIE_DYING)
         {
            this.UpdateDeath();
            this.UpdateZombieWalking();
         }
         else
         {
            if(this.mPhaseCounter > 0 && !this.IsImmobilizied())
            {
               --this.mPhaseCounter;
            }
            if(mBoard.mGameScene == SCENE_ZOMBIES_WON)
            {
               if(mBoard.mShowZombieWalking)
               {
                  this.UpdateZombieWalking();
               }
            }
            else if(this.IsOnBoard())
            {
               this.UpdatePlaying();
            }
            this.Animate();
         }
         --this.mJustGotShotCounter;
         if(this.mShieldJustGotShotCounter > 0)
         {
            --this.mShieldJustGotShotCounter;
         }
         if(this.mZombieFade > 0)
         {
            --this.mZombieFade;
            if(this.mZombieFade == 0)
            {
               this.DieNoLoot();
            }
         }
         mX = Std.int(this.mPosX);
         mY = Std.int(this.mPosY);
         this.UpdateReanim();
         if(this.mHeadParticle != null)
         {
            if(this.mHeadParticle.mDead)
            {
            }
         }
         if(this.mArmParticle != null)
         {
            this.mArmParticle.update();
            if(this.mArmParticle.mDead)
            {
               this.mArmParticle = null;
            }
         }
         if(this.mHelmParticle != null)
         {
            this.mHelmParticle.update();
            if(this.mHelmParticle.mDead)
            {
               this.mHelmParticle = null;
            }
         }
         if(this.mFlagParticle != null)
         {
            this.mFlagParticle.update();
            if(this.mFlagParticle.mDead)
            {
               this.mFlagParticle = null;
            }
         }
      }
      
      public function UpdateZombieNewspaper() 
      {
         var anImage:ImageInst = null;
         if(this.mZombiePhase == PHASE_NEWSPAPER_MADDENING)
         {
            if(this.mBodyReanim.currentTrack == "anim_walk_nopaper")
            {
               this.mZombiePhase = PHASE_NEWSPAPER_MAD;
               app.foleyManager.playFoley(PVZFoleyType.NEWSPAPER_RARRGH);
               this.StartWalkAnim(20);
               anImage = app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_ZOMBIE_PAPER_MADHEAD);
               this.mBodyReanim.overrideImage("anim_head1",anImage);
            }
         }
      }
      
      public function DropHelm(theDamageFlags:Int) 
      {
         var aPoint:Point = null;
         var anEffect:String = null;
         if(this.mHelmType == HELMTYPE_NONE)
         {
            return;
         }
         var aDrawPos= this.scratchDrawPos;
         this.GetDrawPos(aDrawPos);
         var aPosX= this.mPosX + aDrawPos.mImageOffsetX + aDrawPos.mHeadX + 10;
         var aPosY= this.mPosY + aDrawPos.mImageOffsetY + aDrawPos.mHeadY + aDrawPos.mBodyY + 13;
         if(this.mHelmType == HELMTYPE_TRAFFIC_CONE)
         {
            aPoint = this.mBodyReanim.getTrackPosition("anim_cone3");
            this.mBodyReanim.setTrackVisible("anim_cone1",false);
            this.mBodyReanim.setTrackVisible("anim_cone2",false);
            this.mBodyReanim.setTrackVisible("anim_cone3",false);
            this.mBodyReanim.setTrackVisible("anim_hair",true);
            anEffect = PVZParticles.PARTICLE_ZOMBIETRAFFICCONE;
         }
         else if(this.mHelmType == HELMTYPE_PAIL)
         {
            aPoint = this.mBodyReanim.getTrackPosition("anim_bucket3");
            this.mBodyReanim.setTrackVisible("anim_bucket1",false);
            this.mBodyReanim.setTrackVisible("anim_bucket2",false);
            this.mBodyReanim.setTrackVisible("anim_bucket3",false);
            this.mBodyReanim.setTrackVisible("anim_hair",true);
            anEffect = PVZParticles.PARTICLE_ZOMBIEPAIL;
         }
         else if(this.mHelmType == HELMTYPE_FOOTBALL)
         {
            aPoint = this.mBodyReanim.getTrackPosition("zombie_football_helmet3");
            this.mBodyReanim.setTrackVisible("zombie_football_helmet1",false);
            this.mBodyReanim.setTrackVisible("zombie_football_helmet2",false);
            this.mBodyReanim.setTrackVisible("zombie_football_helmet3",false);
            this.mBodyReanim.setTrackVisible("anim_hair",true);
            anEffect = PVZParticles.PARTICLE_ZOMBIEHELMET;
         }
         this.mHelmParticle = app.particleManager.spawnParticleSystem(anEffect);
         this.mHelmParticle.setPosition(aPosX + aPoint.x,aPosY + aPoint.y);
         this.mHelmType = HELMTYPE_NONE;
      }
      
      public function GetShieldDamageIndex() : Int
      {
         if(this.mShieldHealth < this.mShieldMaxHealth / 3)
         {
            return 2;
         }
         if(this.mShieldHealth < this.mShieldMaxHealth * 2 / 3)
         {
            return 1;
         }
         return 0;
      }
      
      public function TakeDamage(theDamage:Int, theDamageFlags:Int) 
      {
         if(this.IsDeadOrDying())
         {
            return;
         }
         var aDamageRemaining= theDamage;
         if(aDamageRemaining > 0 && this.mShieldType != SHIELDTYPE_NONE)
         {
            aDamageRemaining = this.TakeShieldDamage(theDamage,theDamageFlags);
            if(theDamageFlags == DAMAGE_HITS_SHIELD_AND_BODY)
            {
               aDamageRemaining = theDamage;
            }
         }
         if(aDamageRemaining > 0 && this.mHelmType != HELMTYPE_NONE)
         {
            aDamageRemaining = this.TakeHelmDamage(theDamage,theDamageFlags);
         }
         if(aDamageRemaining > 0)
         {
            this.TakeBodyDamage(aDamageRemaining,theDamageFlags);
         }
      }
      
      public function CanLoseBodyParts() : Bool
      {
         return true;
      }
      
      public function DetachShield() 
      {
         if(this.mBodyReanim == null)
         {
            this.mShieldType = SHIELDTYPE_NONE;
            this.mShieldHealth = 0;
            return;
         }
         if(this.mShieldType == SHIELDTYPE_DOOR)
         {
            this.mBodyReanim.setTrackVisible("anim_screendoor3",false);
            this.ShowDoorArms(false);
         }
         else if(this.mShieldType == SHIELDTYPE_NEWSPAPER)
         {
            this.mBodyReanim.setTrackVisible("Zombie_paper_hands",true);
         }
         this.mShieldType = SHIELDTYPE_NONE;
         this.mShieldHealth = 0;
      }
      
      public function UpdatePlaying() 
      {
         var aBleeding:ASAny = false;
         var aBleedRate= 0;
         --this.mGroanCounter;
         var aZombiesOnScreen= mBoard.mZombies.length;
         if(this.mGroanCounter == 0 && Math.random() * aZombiesOnScreen == 0 && this.mHasHead && !mBoard.HasLevelAwardDropped())
         {
            if(this.mVariant)
            {
               app.foleyManager.playFoley(PVZFoleyType.BRAINS);
            }
            else
            {
               app.foleyManager.playFoley(PVZFoleyType.GROAN);
            }
            this.mGroanCounter = Std.int(Math.random() * 1000 + 500);
         }
         if(this.mChilledCounter > 0)
         {
            --this.mChilledCounter;
            if(this.mChilledCounter == 0)
            {
               this.UpdateAnimSpeed();
            }
         }
         if(this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            this.UpdateZombieRiseFromGrave();
            return;
         }
         if(!this.IsImmobilizied())
         {
            this.UpdateActions();
            this.UpdateZombiePosition();
            this.CheckIfPreyCaught();
            this.CheckForBoardEdge();
         }
         if(!this.IsDeadOrDying() && this.mFromWave != ZOMBIE_WAVE_WINNER)
         {
            aBleeding = !this.mHasHead;
            if(aBleeding)
            {
               aBleedRate = 1;
               if(this.mBodyMaxHealth >= 500)
               {
                  aBleedRate = 3;
               }
               if(Std.int(Math.random() * 4) == 0)
               {
                  this.TakeDamage(aBleedRate,DAMAGE_DOESNT_CAUSE_FLASH);
               }
            }
         }
      }
      
      public function StopZombieSound() 
      {
      }
      
      public function UpdateDeath() 
      {
         if(this.mBodyReanim.mIsDead)
         {
            this.DieNoLoot();
            return;
         }
         if(this.mZombieHeight == HEIGHT_FALLING)
         {
            this.UpdateZombieFalling();
         }
         var aFallTime:Float = -1;
         if(this.mZombieType == ZOMBIE_NORMAL || this.mZombieType == ZOMBIE_FLAG || this.mZombieType == ZOMBIE_TRAFFIC_CONE || this.mZombieType == ZOMBIE_PAIL)
         {
            if(this.mBodyReanim.currentTrack == "anim_superlongdeath")
            {
               aFallTime = 0.78;
            }
            else if(this.mBodyReanim.currentTrack == "anim_death2")
            {
               aFallTime = 0.71;
            }
            else
            {
               aFallTime = 0.77;
            }
         }
         else if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            aFallTime = 0.68;
         }
         else if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            aFallTime = 0.63;
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            aFallTime = 0.52;
         }
         if(aFallTime > 0 && this.mBodyReanim.shouldTriggerTimedEvent(aFallTime))
         {
            app.foleyManager.playFoley(PVZFoleyType.ZOMBIE_FALLING);
         }
         if(this.mZombieFade == -1 && this.mBodyReanim.animTime == 1)
         {
            this.mZombieFade = 100;
         }
      }
      
      public function GetZombieRect() : Rectangle
      {
         var aDrawPos:ZombieDrawPosition = null;
         if(this.mHitRectUpdated == false)
         {
            this.mZombieHitRect.x = this.mZombieRect.x;
            this.mZombieHitRect.y = this.mZombieRect.y;
            this.mZombieHitRect.width = this.mZombieRect.width;
            this.mZombieHitRect.height = this.mZombieRect.height;
            aDrawPos = mScratchPosition;
            this.GetDrawPos(aDrawPos);
            this.mZombieHitRect.offset(mX,mY + aDrawPos.mBodyY);
            if(aDrawPos.mClipHeight > CLIP_HEIGHT_LIMIT)
            {
               this.mZombieHitRect.height -= aDrawPos.mClipHeight;
            }
            this.mHitRectUpdated = true;
         }
         return this.mZombieHitRect;
      }
      
      public function UpdateReanim() 
      {
         this.mBodyReanim.update();
      }
      
      public function DieWithLoot() 
      {
         this.DieNoLoot();
         this.DropLoot();
      }
      
      public function UpdateZombieFalling() 
      {
         --this.mAltitude;
      }
      
      public function DropFlag() 
      {
         if(this.mZombieType != ZOMBIE_FLAG || !this.mHasObject)
         {
            return;
         }
         this.mHasObject = false;
         var aPoint= this.mBodyReanim.getTrackPosition("Zombie_flaghand");
         var aFlagPosX:Float = mX - 10;
         var aFlagPosY:Float = mY - 10;
         this.mFlagParticle = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_ZOMBIEFLAG);
         this.mFlagParticle.setPosition(aFlagPosX,aFlagPosY);
      }
      
      public function CanBeChilled() : Bool
      {
         if(this.IsDeadOrDying() || this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            return false;
         }
         return true;
      }
      
      public function MowDown() 
      {
         if(this.mDead || this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            return;
         }
         var anEffect= app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_MOWERCLOUD);
         anEffect.setPosition(this.mPosX + 20,this.mPosY + 20);
         mBoard.mRenderManager.add(new ParticleRenderable(anEffect,GameObject.RENDER_LAYER_PARTICLE));
         this.DropHead(0);
         this.DropArm(0);
         this.DropHelm(0);
         this.DropShield(0);
         this.DieWithLoot();
      }
      
      public function ZombieTargetLeadX(theTime:Float) : Float
      {
         var aSpeed= this.mVelX;
         if(this.mChilledCounter > 0)
         {
            aSpeed *= CHILLED_SPEED_FACTOR;
         }
         if(this.ZombieNotWalking())
         {
            aSpeed = 0;
         }
         var aLeadAmount= aSpeed * theTime;
         var aZombieRect= this.GetZombieRect();
         var aCenter= Std.int(aZombieRect.x + aZombieRect.width / 2);
         return aCenter - aLeadAmount;
      }
      
      public function DrawReanim(g:Graphics2D, theDrawPos:ZombieDrawPosition) 
      {
         var aDrawHeight= Math.NaN;
         var aFade= Math.NaN;
         var anOffsetX= theDrawPos.mImageOffsetX;
         var anOffsetY= theDrawPos.mImageOffsetY + theDrawPos.mBodyY - 52;
         if(theDrawPos.mClipHeight > CLIP_HEIGHT_LIMIT)
         {
            aDrawHeight = 120 - theDrawPos.mClipHeight + 71;
            g.setClipRect(anOffsetX - 200,anOffsetY,120 + 400,aDrawHeight);
         }
         var aAlpha:Float = 1;
         if(this.mZombieFade >= 0)
         {
            aAlpha = TodCommon.ClampInt(Std.int(this.mZombieFade / 10),0,1);
         }
         var aColorOverride= this.mOverrideColor;
         aColorOverride.alpha = aAlpha;
         aColorOverride.red = 1;
         aColorOverride.green = 1;
         aColorOverride.blue = 1;
         var aExtraAdditiveColor= this.mAdditiveColor;
         aExtraAdditiveColor.alpha = 0;
         aExtraAdditiveColor.red = 0;
         aExtraAdditiveColor.green = 0;
         aExtraAdditiveColor.blue = 0;
         var aEnableExtraAdditiveDraw= false;
         if(this.mZombiePhase == PHASE_ZOMBIE_BURNED)
         {
            aColorOverride.red = 0;
            aColorOverride.green = 0;
            aColorOverride.blue = 0;
            aEnableExtraAdditiveDraw = false;
         }
         else if(this.mChilledCounter > 0 || this.mIceTrapCounter > 0)
         {
            aColorOverride.red = gChilledColor.red;
            aColorOverride.green = gChilledColor.green;
            aColorOverride.blue = gChilledColor.blue;
            aExtraAdditiveColor.red = aColorOverride.red;
            aExtraAdditiveColor.green = aColorOverride.green;
            aExtraAdditiveColor.blue = aColorOverride.blue;
            aEnableExtraAdditiveDraw = true;
         }
         if(this.mJustGotShotCounter > 0)
         {
            aFade = this.mJustGotShotCounter * 10 / 255;
            aExtraAdditiveColor.red += aFade;
            aExtraAdditiveColor.red = aExtraAdditiveColor.red > 1 ? 1 : aExtraAdditiveColor.red;
            aExtraAdditiveColor.green += aFade;
            aExtraAdditiveColor.green = aExtraAdditiveColor.green > 1 ? 1 : aExtraAdditiveColor.green;
            aExtraAdditiveColor.blue += aFade;
            aExtraAdditiveColor.blue = aExtraAdditiveColor.blue > 1 ? 1 : aExtraAdditiveColor.blue;
            aEnableExtraAdditiveDraw = true;
         }
         this.mBodyReanim.useColor = aEnableExtraAdditiveDraw;
         this.mBodyReanim.overrideColor = aColorOverride;
         this.mBodyReanim.additiveColor = aExtraAdditiveColor;
         if(!this.IsOnBoard())
         {
            this.mBodyReanim.x = mX;
            this.mBodyReanim.y = mY;
            this.mBodyReanim.draw(g);
         }
         else if(this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            this.mBodyReanim.x = mX;
            this.mBodyReanim.y = mY - this.mAltitude;
            g.setClipRect(mX,mY,mHeight,mWidth);
            this.mBodyReanim.drawLerp(g,this.mScratchMatrix);
         }
         else
         {
            this.mBodyReanim.x = mX;
            this.mBodyReanim.y = mY;
            this.mBodyReanim.draw(g);
         }
         g.clearClipRect();
      }
      
      public function DropShield(theDamageFlags:Int) 
      {
         var aPoint:Point = null;
         var anEffect:ParticleSystem = null;
         var anArray:Array<ASAny> = null;
         if(this.mShieldType == SHIELDTYPE_NONE)
         {
            return;
         }
         var aDrawPos= mScratchPosition;
         this.GetDrawPos(aDrawPos);
         if(this.mShieldType == SHIELDTYPE_DOOR)
         {
            aPoint = this.mBodyReanim.getTrackPosition("anim_screendoor1");
            this.DetachShield();
            if(theDamageFlags != DAMAGE_DOESNT_LEAVE_BODY)
            {
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_ZOMBIEDOOR);
               anEffect.setPosition(aPoint.x + mX,aPoint.y + mY);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,GameObject.RENDER_LAYER_PARTICLE));
            }
         }
         else if(this.mShieldType == SHIELDTYPE_NEWSPAPER)
         {
            aPoint = this.mBodyReanim.getTrackPosition("Zombie_paper_paper3");
            this.StopEating();
            this.mZombiePhase = PHASE_NEWSPAPER_MADDENING;
            anArray = ["anim_walk_nopaper"];
            this.PlayZombieReanim("anim_gasp",new ReanimLoopQueue(anArray),8);
            this.DetachShield();
            if(theDamageFlags != DAMAGE_DOESNT_LEAVE_BODY)
            {
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_ZOMBIENEWSPAPER);
               anEffect.setPosition(aPoint.x + mX,aPoint.y + mY);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,GameObject.RENDER_LAYER_PARTICLE));
            }
            if(theDamageFlags != DAMAGE_DOESNT_LEAVE_BODY && theDamageFlags != DAMAGE_BYPASSES_SHIELD)
            {
               app.foleyManager.playFoley(PVZFoleyType.NEWSPAPER_RIP);
            }
         }
         this.mShieldType = SHIELDTYPE_NONE;
      }
      
      public function Draw(g:Graphics2D) 
      {
         this.GetDrawPos(this.scratchDrawPos);
         if(mBoard.mGameScene == SCENE_ZOMBIES_WON)
         {
            if(!this.SetupDrawZombieWon(g))
            {
               return;
            }
         }
         this.DrawReanim(g,this.scratchDrawPos);
         g.clearClipRect();
         if(this.mHeadParticle != null)
         {
         }
         if(this.mArmParticle != null)
         {
            this.mArmParticle.draw(g);
         }
         if(this.mHelmParticle != null)
         {
            this.mHelmParticle.draw(g);
         }
         if(this.mFlagParticle != null)
         {
            this.mFlagParticle.draw(g);
         }
      }
      
      public function DropPole() 
      {
         if(this.mZombieType != ZOMBIE_POLEVAULTER)
         {
            return;
         }
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_innerarm_upper",false);
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_innerarm_lower",false);
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_innerhand",false);
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_pole",false);
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_pole2",false);
      }
      
      public function UpdateZombieRiseFromGrave() 
      {
         this.mAltitude = TodCommon.TodAnimateCurve(50,0,this.mPhaseCounter,-200,0,TodCommon.CURVE_LINEAR);
         if(this.mPhaseCounter == 0)
         {
            this.mZombiePhase = PHASE_ZOMBIE_NORMAL;
         }
      }
      
      public function GetBodyDamageIndex() : Int
      {
         if(this.mBodyHealth < this.mBodyMaxHealth / 3)
         {
            return 2;
         }
         if(this.mBodyHealth < this.mBodyMaxHealth * 2 / 3)
         {
            return 1;
         }
         return 0;
      }
      
      public function DropHead(theDamageFlags:Int) 
      {
         if(!this.CanLoseBodyParts())
         {
            return;
         }
         if(!this.mHasHead)
         {
            return;
         }
         this.mHasHead = false;
         this.mBodyReanim.setTrackVisible("anim_head1",false);
         this.mBodyReanim.setTrackVisible("anim_head2",false);
         this.mBodyReanim.setTrackVisible("anim_hair",false);
         this.mBodyReanim.setTrackVisible("anim_tongue",false);
         if(theDamageFlags == DAMAGE_DOESNT_LEAVE_BODY)
         {
            return;
         }
         if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            this.mBodyReanim.setTrackVisible("anim_hairpiece",false);
            this.mBodyReanim.setTrackVisible("anim_head_jaw",false);
            this.mBodyReanim.setTrackVisible("anim_head_glasses",false);
         }
         var aDrawPos= this.scratchDrawPos;
         this.GetDrawPos(aDrawPos);
         var aPosX= this.mPosX + aDrawPos.mHeadX + aDrawPos.mImageOffsetX;
         var aPosY= this.mPosY + aDrawPos.mHeadY + aDrawPos.mImageOffsetY;
         var aPoint= this.mBodyReanim.getTrackPosition("anim_head1");
         aPosX += aPoint.x;
         aPosY += aPoint.y;
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            aPosX += 0;
            aPosY += 40;
         }
         else if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            aPosX += -2;
            aPosY += 22;
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            aPosX += 4;
            aPosY += 40;
         }
         else
         {
            aPosX += -15;
            aPosY += 15;
         }
         var anEffect= PVZParticles.PARTICLE_ZOMBIEHEAD;
         if(this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            anEffect = PVZParticles.PARTICLE_MOWEREDZOMBIEHEAD;
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            anEffect = PVZParticles.PARTICLE_ZOMBIEFOOTBALLHEAD;
         }
         else if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            anEffect = PVZParticles.PARTICLE_ZOMBIENEWSPAPERHEAD;
         }
         else if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            anEffect = PVZParticles.PARTICLE_ZOMBIEPOLEVALUTHEAD;
         }
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            this.DropPole();
         }
         else if(this.mZombieType == ZOMBIE_FLAG)
         {
            this.DropFlag();
         }
         this.mHeadParticle = app.particleManager.spawnParticleSystem(anEffect);
         this.mHeadParticle.setPosition(aPosX,aPosY);
         if(this.mChilledCounter > 0)
         {
            this.mHeadParticle.mEmitterList[0].mColorOverride = gChilledColor;
         }
         mBoard.mRenderManager.add(new ParticleRenderable(this.mHeadParticle,GameObject.RENDER_LAYER_ZOMBIE + mRow));
         app.foleyManager.playFoley(PVZFoleyType.LIMBS_POP);
      }
      
      public function UpdateMowered() 
      {
      }
      
      public function RiseFromGrave(theCol:Int, theRow:Int) 
      {
         this.mPosX = mBoard.GridToPixelX(theCol,mRow);
         this.mPosY = this.GetPosYBasedOnRow(theRow);
         mRow = theRow;
         mX = Std.int(this.mPosX);
         mY = Std.int(this.mPosY);
         this.mZombiePhase = PHASE_RISING_FROM_GRAVE;
         this.mPhaseCounter = 150;
         this.mAltitude = -200;
         var aParticleX= Std.int(this.mPosX) + 20;
         var aParticleY= Std.int(this.mPosY) + 85;
         var anEffect= app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_ZOMBIERISE);
         anEffect.setPosition(aParticleX,aParticleY);
         mBoard.mRenderManager.add(new ParticleRenderable(anEffect,GameObject.RENDER_LAYER_ZOMBIE - 1));
         app.foleyManager.playFoley(PVZFoleyType.GRAVESTONE_RUMBLE);
      }
      
      public function CanTargetPlant(thePlant:CPlant, theAttackType:Int) : Bool
      {
         if(mBoard.IsWallnutBowlingLevel() && theAttackType != ATTACKTYPE_VAULT)
         {
            return false;
         }
         if(theAttackType == ATTACKTYPE_CHEW)
         {
         }
         if(theAttackType == ATTACKTYPE_VAULT)
         {
         }
         return true;
      }
      
      public function IsOnBoard() : Bool
      {
         if(this.mFromWave == -2)
         {
            return false;
         }
         return true;
      }
      
      public function PlayDeathAnim(theDamageFlags:Int) 
      {
         var aDeathAnimRate= Math.NaN;
         if(this.mZombiePhase == PHASE_ZOMBIE_DYING || this.mZombiePhase == PHASE_ZOMBIE_BURNED || this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            return;
         }
         if(theDamageFlags == DAMAGE_DOESNT_LEAVE_BODY)
         {
            this.DieNoLoot();
            return;
         }
         this.StopEating();
         this.mZombiePhase = PHASE_ZOMBIE_DYING;
         this.mVelX = 0;
         if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            aDeathAnimRate = 24;
         }
         else
         {
            aDeathAnimRate = TodCommon.RandRangeFloat(24,30);
         }
         this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
         this.mBodyReanim.currentTrack = "anim_death";
         this.mBodyReanim.animRate = aDeathAnimRate;
      }
      
      public function AnimateChewSound() 
      {
         var aPlant= this.FindPlantTarget(ATTACKTYPE_CHEW);
         if(aPlant == null)
         {
            return;
         }
         if(aPlant != null)
         {
            if(aPlant.mSeedType == SEED_WALLNUT)
            {
               app.foleyManager.playFoley(PVZFoleyType.CHOMP_SOFT);
            }
            else
            {
               app.foleyManager.playFoley(PVZFoleyType.CHOMP);
            }
         }
      }
      
      public function UpdateZombiePolevaulter() 
      {
         var aPlant:CPlant = null;
         var aAnimDuration= Math.NaN;
         var aJumpDistance= 0;
         var aLanded= false;
         var aOldPosX= Math.NaN;
         if(this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT && this.mHasHead && this.mZombieHeight == HEIGHT_ZOMBIE_NORMAL)
         {
            aPlant = this.FindPlantTarget(ATTACKTYPE_VAULT);
            if(aPlant != null)
            {
               this.mZombiePhase = PHASE_POLEVAULTER_IN_VAULT;
               this.PlayZombieReanim("anim_jump",Reanimation.LOOP_TYPE_ONCE_AND_HOLD,24);
               aAnimDuration = this.mBodyReanim.frameCount / this.mBodyReanim.animRate * 100;
               aJumpDistance = mX - aPlant.mX - 54;
               if(mBoard.IsWallnutBowlingLevel())
               {
                  aJumpDistance = 0;
               }
               this.mVelX = aJumpDistance / aAnimDuration;
               this.mHasObject = false;
            }
         }
         else if(this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT)
         {
            aLanded = false;
            if(this.mBodyReanim.animTime == 1)
            {
               this.mBodyReanim.animRate = 24;
               this.mBodyReanim.currentTrack = "anim_walk";
               this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
               aLanded = true;
               this.mPosX -= 101;
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.2))
            {
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.4))
            {
               app.foleyManager.playFoley(PVZFoleyType.POLEVAULT);
            }
            if(aLanded)
            {
               mX = Std.int(this.mPosX);
               this.mZombiePhase = PHASE_POLEVAULTER_POST_VAULT;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               this.StartWalkAnim(0);
            }
            else
            {
               aOldPosX = this.mPosX;
               this.mPosX -= 150 * this.mBodyReanim.animTime;
               this.mPosY = this.GetPosYBasedOnRow(mRow);
               this.mPosX = aOldPosX;
            }
         }
      }
      
      public function TakeBodyDamage(theDamage:Int, theDamageFlags:Int) 
      {
         if(theDamageFlags != DAMAGE_DOESNT_CAUSE_FLASH)
         {
            this.mJustGotShotCounter = 25;
         }
         if(theDamageFlags == DAMAGE_FREEZE)
         {
            this.ApplyChill(false);
         }
         var aOldHealth= this.mBodyHealth;
         var oldIndex= this.GetBodyDamageIndex();
         this.mBodyHealth -= theDamage;
         var newIndex= this.GetBodyDamageIndex();
         this.UpdateDamageStates(theDamageFlags);
         if(this.mBodyHealth <= 0)
         {
            this.mBodyHealth = 0;
            this.PlayDeathAnim(theDamageFlags);
            this.DropLoot();
         }
      }
      
      public function UpdateAnimSpeed() 
      {
         var aTrackIndex= 0;
         if(!this.IsOnBoard())
         {
            return;
         }
         if(this.IsDeadOrDying())
         {
            this.mBodyReanim.animRate = this.mOrginalAnimRate;
            return;
         }
         if(this.mIsEating)
         {
            if(this.mZombieType == ZOMBIE_POLEVAULTER)
            {
               if(this.mChilledCounter > 0)
               {
                  this.mBodyReanim.animRate = 10;
               }
               else
               {
                  this.mBodyReanim.animRate = 20;
               }
            }
            else if(this.mChilledCounter > 0)
            {
               this.mBodyReanim.animRate = 18;
            }
            else
            {
               this.mBodyReanim.animRate = 36;
            }
            return;
         }
         if(this.ZombieNotWalking())
         {
            this.mBodyReanim.animRate = this.mOrginalAnimRate;
            return;
         }
         var i= 0;while(i < this.mBodyReanim.definition.tracks.length)
         {
            if(this.mBodyReanim.definition.tracks[i].name == "_ground")
            {
               aTrackIndex = i;
               break;
            }
i++;
         }
         var aDistance= this.mBodyReanim.getTrackVelocity("_ground",true);
         if(Math.isNaN(aDistance) || aDistance < TodCommon.EPSILON)
         {
            return;
         }
         var aFramesPerPixel= this.mBodyReanim.frameCount / aDistance;
         var aSpeed= this.mVelX * aFramesPerPixel * 31 / this.mScaleZombie;
         if(Math.isNaN(aSpeed))
         {
            throw new Error();
         }
         this.mBodyReanim.animRate = aSpeed;
         if(this.mChilledCounter > 0)
         {
            this.mBodyReanim.animRate *= 0.5;
         }
      }
      
      public function UpdateActions() 
      {
         if(this.mZombieHeight == HEIGHT_FALLING)
         {
            this.UpdateZombieFalling();
         }
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            this.UpdateZombiePolevaulter();
         }
         if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            this.UpdateZombieNewspaper();
         }
      }
      
      public function UpdateDamageStates(theDamageFlags:Int) 
      {
         if(!this.CanLoseBodyParts())
         {
            return;
         }
         var aHealthLeft= this.mBodyHealth / this.mBodyMaxHealth;
         if(this.mHasArm && aHealthLeft <= 0.66 && this.mBodyHealth > 0)
         {
            this.DropArm(theDamageFlags);
         }
         if(this.mHasHead && aHealthLeft <= 0.33)
         {
            this.DropHead(theDamageFlags);
            this.DropLoot();
            this.StopZombieSound();
            if(mBoard.HasLevelAwardDropped())
            {
               this.PlayDeathAnim(theDamageFlags);
            }
         }
      }
      
      public function StartWalkAnim(theBlendTime:Int) 
      {
         if(this.mZombiePhase == PHASE_NEWSPAPER_MAD)
         {
            this.PickRandomSpeed();
            this.PlayZombieReanim("anim_walk_nopaper",Reanimation.LOOP_TYPE_ALWAYS,0);
            return;
         }
         var aWalkPermuation= Std.int(Math.random() * 2);
         if(this.mZombieType == ZOMBIE_FLAG)
         {
            aWalkPermuation = 0;
         }
         if(aWalkPermuation == 0)
         {
            if(this.mZombieType != ZOMBIE_POLEVAULTER && this.mZombieType != ZOMBIE_NEWSPAPER && this.mZombieType != ZOMBIE_FOOTBALL)
            {
               this.mBodyReanim.currentTrack = "anim_walk2";
               return;
            }
         }
         this.mBodyReanim.currentTrack = "anim_walk";
         this.PickRandomSpeed();
      }
      
      public function AnimateChewEffect() 
      {
         var aDrawPos:ZombieDrawPosition = null;
         var aPosX= Math.NaN;
         var aPosY= Math.NaN;
         var anEffect:ParticleSystem = null;
         var aPlant= this.FindPlantTarget(ATTACKTYPE_CHEW);
         if(aPlant == null)
         {
            return;
         }
         if(aPlant != null)
         {
            if(aPlant.mSeedType == SEED_WALLNUT)
            {
               aDrawPos = this.scratchDrawPos;
               this.GetDrawPos(aDrawPos);
               aPosX = this.mPosX + 37;
               aPosY = this.mPosY + 40 + aDrawPos.mBodyY;
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_WALLNUTEATSMALL);
               anEffect.setPosition(aPosX,aPosY);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,GameObject.RENDER_LAYER_PARTICLE));
            }
         }
         aPlant.mEatenFlashCountdown = Std.int(Math.max(aPlant.mEatenFlashCountdown,25));
      }
      
      public function SetupDoorArms(theShow:Bool) 
      {
         var aRenderArms= true;
         var aRenderDoor= false;
         if(theShow)
         {
            aRenderArms = false;
            aRenderDoor = true;
         }
         this.mBodyReanim.setTrackVisible("anim_innerarm1",aRenderArms);
         this.mBodyReanim.setTrackVisible("anim_innerarm2",aRenderArms);
         this.mBodyReanim.setTrackVisible("anim_innerarm3",aRenderArms);
         this.mBodyReanim.setTrackVisible("Zombie_outerarm_lower",aRenderArms);
         this.mBodyReanim.setTrackVisible("Zombie_outerarm_hand",aRenderArms);
         this.mBodyReanim.setTrackVisible("Zombie_outerarm_upper",aRenderArms);
         this.mBodyReanim.setTrackVisible("anim_innerarm",aRenderArms);
         this.mBodyReanim.setTrackVisible("Zombie_outerarm_screendoor",aRenderDoor);
         this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor",aRenderDoor);
         this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor_hand",aRenderDoor);
      }
      
      public function TrySpawnLevelAward() : Bool
      {
         var aCoinType:String = null;
         var aGridX= 0;
         if(!this.IsOnBoard())
         {
            return false;
         }
         if(mBoard.HasLevelAwardDropped())
         {
            return false;
         }
         if(this.mDroppedLoot)
         {
            return false;
         }
         if(app.IsScaryPotterLevel())
         {
            if(!mBoard.mChallenge.ScaryPotterIsCompleted())
            {
               return false;
            }
         }
         else
         {
            if(mBoard.mCurrentWave < mBoard.mNumWaves)
            {
               return false;
            }
            if(mBoard.AreEnemyZombiesOnScreen())
            {
               return false;
            }
         }
         mBoard.mLevelAwardSpawned = true;
         app.mBoardResult = PVZApp.BOARDRESULT_WON;
         var aZombieRect= this.GetZombieRect();
         var aCenterX= Std.int(aZombieRect.x + aZombieRect.width / 2);
         var aCenterY= Std.int(aZombieRect.y + aZombieRect.height / 4);
         mBoard.RemoveAllZombies();
         if(mBoard.mLevel == 14)
         {
            aCoinType = COIN_NONE;
            mBoard.FadeOutLevel();
         }
         else if(app.IsScaryPotterLevel())
         {
            aCoinType = COIN_NONE;
            aGridX = mBoard.PixelToGridXKeepOnBoard(Std.int(this.mPosX + 75),Std.int(this.mPosY));
            mBoard.mChallenge.PuzzlePhaseComplete(aGridX,mRow);
         }
         else if(app.IsAdventureMode() && mBoard.mLevel < 14)
         {
            if(mBoard.mLevel == 9)
            {
               aCoinType = COIN_NOTE;
            }
            else if(mBoard.mLevel == 4)
            {
               aCoinType = COIN_SHOVEL;
            }
            else
            {
               aCoinType = COIN_FINAL_SEED_PACKET;
            }
         }
         else if(app.IsSurvivalMode())
         {
            aCoinType = COIN_NONE;
            mBoard.FadeOutLevel();
         }
         else
         {
            aCoinType == COIN_NONE;
         }
         var aMotion= COIN_MOTION_COIN;
         app.foleyManager.playFoley(PVZFoleyType.SPAWN_SUN);
         mBoard.AddCoin(aCenterX,aCenterY,aCoinType,aMotion);
         this.mDroppedLoot = true;
         return true;
      }
      
      public function PlayZombieReanim(theTrackName:String, theLoopType:ReanimLoopType, theAnimRate:Float) 
      {
         if(this.mBodyReanim == null)
         {
            return;
         }
         this.mBodyReanim.currentTrack = theTrackName;
         this.mBodyReanim.loopType = theLoopType;
         this.mBodyReanim.animRate = theAnimRate;
         if(theAnimRate != 0)
         {
            this.mOrginalAnimRate = theAnimRate;
         }
         this.UpdateAnimSpeed();
      }
   }

