package com.popcap.flash.framework.resources.particles
;
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
    class ParticleEmitter
   {
      
      public static inline final ONE_OVER_32K:Float = 0.0000305185094;
      
      static inline final TRACK_SYSTEM_ALPHA:Float = 8;
      
      static inline final TRACK_SYSTEM_BRIGHTNESS:Float = 9;
      
      static inline final TRACK_EMITTER_PATH:Float = 4;
      
      static inline final TRACK_SYSTEM_BLUE:Float = 7;
      
      static inline final TRACK_SPAWN_RATE:Float = 0;
      
      static inline final TRACK_SPAWN_MAX_ACTIVE:Float = 2;
      
      public static inline final CIRCLE_FULL:Float = 6.283185307179586;
      
      static inline final TRACK_SPAWN_MAX_LAUNCHED:Float = 3;
      
      static inline final TRACK_SYSTEM_GREEN:Float = 6;
      
      static inline final TRACK_SPAWN_MIN_ACTIVE:Float = 1;
      
      static inline final TRACK_SYSTEM_RED:Float = 5;
      
      public static inline final SECONDS_PER_UPDATE:Float = 0.01;
      
      static inline final NUM_SYSTEM_TRACKS:Float = 10;
       
      
      public var mEmitterDef:ParticleEmitterDefinition;
      
      public var mSystemTimeValue:Float = Math.NaN;
      
      public var mSystemLastTimeValue:Float = Math.NaN;
      
      public var mTrackInterp:Array<ASAny>;
      
      public var mSystemFieldInterp:Array<ASAny>;
      
      public var mParticleSystem:ParticleSystem;
      
      public var mSystemDuration:Float = Math.NaN;
      
      public var mParticleList:Array<ASAny>;
      
      public var mImageOverride:Bool = false;
      
      public var mSystemAge:Float = Math.NaN;
      
      public var mColorOverride:Color;
      
      public var mSpawnAccum:Float = Math.NaN;
      
      public var mDead:Bool = false;
      
      public var mEmitterCrossFadeCountDown:Float = Math.NaN;
      
      public var mSystemCenter:Point;
      
      public var mParticlesSpawned:Float = Math.NaN;
      
      public var mCrossFadeEmitter:ParticleEmitter;
      
      public function new()
      {
         this.mColorOverride = Color.ARGB(1,1,1,1);
         //super();
      }
      
      function crossFadeParticle(particle:Particle, emitter:ParticleEmitter) : Bool
      {
         throw new Error("Not implemented yet!");
      }
      
      function updateSystemField(field:ParticleField, time:Float, index:Int) 
      {
         var aLastX= Math.NaN;
         var aLastY= Math.NaN;
         var aInterpX= ASCompat.toNumber(this.mSystemFieldInterp[index][0]);
         var aInterpY= ASCompat.toNumber(this.mSystemFieldInterp[index][1]);
         var x= field.mX.evaluate(time,aInterpX);
         var y= field.mY.evaluate(time,aInterpY);
         if(field.mFieldType == ParticleFieldType.SYSTEM_POSITION)
         {
            aLastX = field.mX.evaluate(this.mSystemLastTimeValue,aInterpX);
            aLastY = field.mY.evaluate(this.mSystemLastTimeValue,aInterpY);
            this.mSystemCenter.x += x - aLastX;
            this.mSystemCenter.y += y - aLastY;
         }
         else if(field.mFieldType != ParticleFieldType.INVALID)
         {
            throw new Error("Bad system field type: " + field.mFieldType);
         }
      }
      
      function deleteNonCrossFading() 
      {
         var aParticle:Particle = null;
         var aNumParticles= this.mParticleList.length;
         var i= 0;while(i < aNumParticles)
         {
            aParticle = this.mParticleList[i];
            if(aParticle.mCrossFadeDuration <= 0)
            {
               this.deleteParticle(aParticle);
               i--;
               aNumParticles--;
            }
i++;
         }
      }
      
      function evalSystemTrack(track:FloatParameterTrack, index:Float) : Float
      {
         return track.evaluate(this.mSystemTimeValue,this.mTrackInterp[Std.int(index)]);
      }
      
      function spawnParticle(index:Int, spawnCount:Int) : Particle
      {
         var aLaunchAngle= Math.NaN;
         var aEmitterRadiusInterp= Math.NaN;
         var aRadius= Math.NaN;
         var aEmitterBoxXInterp= Math.NaN;
         var aEmitterBoxYInterp= Math.NaN;
         var aType= this.mEmitterDef.mEmitterType;
         var aParticle= new Particle();
         var aParticleFieldCount= this.mEmitterDef.mParticleFields.length;
         for(i in 0...aParticleFieldCount)
         {
            aParticle.mParticleFieldInterp[i] = new Array<ASAny>();
            aParticle.mParticleFieldInterp[i][0] = Math.random();
            aParticle.mParticleFieldInterp[i][1] = Math.random();
         }
         var i :ASAny= 0;while(i < Particle.NUM_PARTICLE_TRACKS)
         {
            aParticle.mParticleInterp[i] = Math.random();
i++;
         }
         var aParticleDurationInterp= Math.random();
         var aLaunchSpeedInterp= Math.random();
         var aEmitterOffsetXInterp= Math.random();
         var aEmitterOffsetYInterp= Math.random();
         aParticle.mParticleDuration = Std.int(this.mEmitterDef.mParticleDuration.evaluate(this.mSystemTimeValue,aParticleDurationInterp));
         aParticle.mParticleDuration = 1 > aParticle.mParticleDuration ? 1 : aParticle.mParticleDuration;
         aParticle.mParticleAge = 0;
         aParticle.mParticleEmitter = this;
         aParticle.mParticleTimeValue = -1;
         aParticle.mParticleLastTimeValue = -1;
         if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.RANDOM_START_TIME))
         {
            aParticle.mParticleAge = Math.random() * aParticle.mParticleDuration;
         }
         else
         {
            aParticle.mParticleAge = 0;
         }
         var aLaunchSpeed= this.mEmitterDef.mLaunchSpeed.evaluate(this.mSystemTimeValue,aLaunchSpeedInterp) * SECONDS_PER_UPDATE;
         var aLaunchAngleInterp= Math.random();
         if(aType == ParticleEmitterType.CIRCLE_PATH)
         {
            aLaunchAngle = this.mEmitterDef.mEmitterPath.evaluate(this.mSystemTimeValue,this.mTrackInterp[Std.int(TRACK_EMITTER_PATH)]) * CIRCLE_FULL;
            aLaunchAngle += this.mEmitterDef.mLaunchAngle.evaluate(this.mSystemTimeValue,aLaunchAngleInterp);
         }
         else if(aType == ParticleEmitterType.CIRCLE_EVEN_SPACING)
         {
            aLaunchAngle = CIRCLE_FULL * index / spawnCount;
            aLaunchAngle += this.mEmitterDef.mLaunchAngle.evaluate(this.mSystemTimeValue,aLaunchAngleInterp);
         }
         else if(this.mEmitterDef.mLaunchAngle.isConstantZero())
         {
            aLaunchAngle = Math.random() * CIRCLE_FULL;
         }
         else
         {
            aLaunchAngle = this.mEmitterDef.mLaunchAngle.evaluate(this.mSystemTimeValue,aLaunchAngleInterp);
         }
         var aPosX:Float = 0;
         var aPosY:Float = 0;
         if(aType == ParticleEmitterType.CIRCLE || aType == ParticleEmitterType.CIRCLE_PATH || aType == ParticleEmitterType.CIRCLE_EVEN_SPACING)
         {
            aEmitterRadiusInterp = Math.random();
            aRadius = this.mEmitterDef.mEmitterRadius.evaluate(this.mSystemTimeValue,aEmitterRadiusInterp);
            aPosX = Math.sin(aLaunchAngle) * aRadius;
            aPosY = Math.cos(aLaunchAngle) * aRadius;
         }
         else
         {
            if(aType != ParticleEmitterType.BOX)
            {
               if(aType == ParticleEmitterType.BOX_PATH)
               {
                  throw new Error("Not implemented yet!");
               }
               throw new Error("Unsupported emitter type \'" + aType + "\'");
            }
            aEmitterBoxXInterp = Math.random();
            aEmitterBoxYInterp = Math.random();
            aPosX = this.mEmitterDef.mEmitterBoxX.evaluate(this.mSystemTimeValue,aEmitterBoxXInterp);
            aPosY = this.mEmitterDef.mEmitterBoxY.evaluate(this.mSystemTimeValue,aEmitterBoxYInterp);
         }
         var aEmitterSkewXInterp= Math.random();
         var aEmitterSkewYInterp= Math.random();
         var aSkewX= this.mEmitterDef.mEmitterSkewX.evaluate(this.mSystemTimeValue,aEmitterSkewXInterp);
         var aSkewY= this.mEmitterDef.mEmitterSkewY.evaluate(this.mSystemTimeValue,aEmitterSkewYInterp);
         aParticle.mPosition.x = this.mSystemCenter.x + aPosX + aPosY * aSkewX;
         aParticle.mPosition.y = this.mSystemCenter.y + aPosY + aPosX * aSkewY;
         aParticle.mVelocity.x = Math.sin(aLaunchAngle) * aLaunchSpeed;
         aParticle.mVelocity.y = Math.cos(aLaunchAngle) * aLaunchSpeed;
         var aEmitterOffsetX= this.mEmitterDef.mEmitterOffsetX.evaluate(this.mSystemTimeValue,aEmitterOffsetXInterp);
         var aEmitterOffsetY= this.mEmitterDef.mEmitterOffsetY.evaluate(this.mSystemTimeValue,aEmitterOffsetYInterp);
         aParticle.mPosition.x += aEmitterOffsetX;
         aParticle.mPosition.y += aEmitterOffsetY;
         aParticle.mAnimationTimeValue = 0;
         if(this.mEmitterDef.mAnimated || this.mEmitterDef.mAnimationRate.isSet())
         {
            aParticle.mImageFrame = 0;
         }
         else
         {
            aParticle.mImageFrame = Std.int(Math.random() * this.mEmitterDef.mImageFrames);
         }
         if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.RANDOM_LAUNCH_SPIN))
         {
            aParticle.mSpinPosition = Math.random() * CIRCLE_FULL;
         }
         else if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.ALIGN_LAUNCH_SPIN))
         {
            aParticle.mSpinPosition = aLaunchAngle;
         }
         else
         {
            aParticle.mSpinPosition = 0;
         }
         aParticle.mSpinVelocity = 0;
         aParticle.mCrossFadeDuration = 0;
         this.mParticleList.unshift(aParticle);
         ++this.mParticlesSpawned;
         this.updateParticle(aParticle);
         return aParticle;
      }
      
      public function setPosition(x:Float, y:Float) 
      {
         var aNumParticles= 0;
         var i= 0;
         var aParticle:Particle = null;
         var deltaX= x - this.mSystemCenter.x;
         var deltaY= y - this.mSystemCenter.y;
         if(deltaX == 0 && deltaY == 0)
         {
            return;
         }
         this.mSystemCenter.x = x;
         this.mSystemCenter.y = y;
         if(!this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.PARTICLES_DONT_FOLLOW))
         {
            aNumParticles = this.mParticleList.length;
            var i :ASAny= 0;while(i < aNumParticles)
            {
               aParticle = this.mParticleList[i];
               aParticle.mPosition.x += deltaX;
               aParticle.mPosition.y += deltaY;
i += 1;
            }
         }
      }
      
      function getRenderParams(particle:Particle, params:ParticleRenderParams) : Bool
      {
         var aFraction= Math.NaN;
         var aEmitter= particle.mParticleEmitter;
         var aDef= aEmitter.mEmitterDef;
         params.mRedIsSet = false;
         params.mRedIsSet = aDef.mSystemRed.isSet() || params.mRedIsSet;
         params.mRedIsSet = aDef.mParticleRed.isSet() || params.mRedIsSet;
         params.mRedIsSet = aEmitter.mColorOverride.red != 1 || params.mRedIsSet;
         params.mGreenIsSet = false;
         params.mGreenIsSet = aDef.mSystemGreen.isSet() || params.mGreenIsSet;
         params.mGreenIsSet = aDef.mParticleGreen.isSet() || params.mGreenIsSet;
         params.mGreenIsSet = aEmitter.mColorOverride.green != 1 || params.mGreenIsSet;
         params.mBlueIsSet = false;
         params.mBlueIsSet = aDef.mSystemBlue.isSet() || params.mBlueIsSet;
         params.mBlueIsSet = aDef.mParticleBlue.isSet() || params.mBlueIsSet;
         params.mBlueIsSet = aEmitter.mColorOverride.blue != 1 || params.mBlueIsSet;
         params.mAlphaIsSet = false;
         params.mAlphaIsSet = aDef.mSystemAlpha.isSet() || params.mAlphaIsSet;
         params.mAlphaIsSet = aDef.mParticleAlpha.isSet() || params.mAlphaIsSet;
         params.mAlphaIsSet = aEmitter.mColorOverride.alpha != 1 || params.mAlphaIsSet;
         params.mParticleScaleIsSet = false;
         params.mParticleScaleIsSet = params.mParticleScaleIsSet || aDef.mParticleScale.isSet();
         params.mParticleStretchIsSet = aDef.mParticleStretch.isSet();
         params.mSpinPositionIsSet = false;
         params.mSpinPositionIsSet = params.mSpinPositionIsSet || aDef.mParticleSpinSpeed.isSet();
         params.mSpinPositionIsSet = params.mSpinPositionIsSet || aDef.mParticleSpinAngle.isSet();
         params.mSpinPositionIsSet = params.mSpinPositionIsSet || aDef.mParticleFlags.hasFlags(ParticleFlags.RANDOM_LAUNCH_SPIN);
         params.mSpinPositionIsSet = params.mSpinPositionIsSet || aDef.mParticleFlags.hasFlags(ParticleFlags.ALIGN_LAUNCH_SPIN);
         params.mPositionIsSet = false;
         params.mPositionIsSet = params.mPositionIsSet || aDef.mParticleFields.length > 0;
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterRadius.isSet();
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterOffsetX.isSet();
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterOffsetY.isSet();
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterBoxX.isSet();
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterBoxY.isSet();
         var aSystemRed= this.evalSystemTrack(aDef.mSystemRed,TRACK_SYSTEM_RED);
         var aSystemGreen= this.evalSystemTrack(aDef.mSystemGreen,TRACK_SYSTEM_GREEN);
         var aSystemBlue= this.evalSystemTrack(aDef.mSystemBlue,TRACK_SYSTEM_BLUE);
         var aSystemAlpha= this.evalSystemTrack(aDef.mSystemAlpha,TRACK_SYSTEM_ALPHA);
         var aSystemBrightness= this.evalSystemTrack(aDef.mSystemBrightness,TRACK_SYSTEM_BRIGHTNESS);
         var aParticleRed= this.evalParticleTrack(aDef.mParticleRed,particle,Particle.TRACK_PARTICLE_RED);
         var aParticleGreen= this.evalParticleTrack(aDef.mParticleGreen,particle,Particle.TRACK_PARTICLE_GREEN);
         var aParticleBlue= this.evalParticleTrack(aDef.mParticleBlue,particle,Particle.TRACK_PARTICLE_BLUE);
         var aParticleAlpha= this.evalParticleTrack(aDef.mParticleAlpha,particle,Particle.TRACK_PARTICLE_ALPHA);
         var aParticleBrightness= this.evalParticleTrack(aDef.mParticleBrightness,particle,Particle.TRACK_PARTICLE_BRIGHTNESS);
         var aBrightness= aParticleBrightness * aSystemBrightness;
         params.mRed = aParticleRed * aSystemRed * aEmitter.mColorOverride.red * aBrightness;
         params.mGreen = aParticleGreen * aSystemGreen * aEmitter.mColorOverride.green * aBrightness;
         params.mBlue = aParticleBlue * aSystemBlue * aEmitter.mColorOverride.blue * aBrightness;
         params.mAlpha = aParticleAlpha * aSystemAlpha * aEmitter.mColorOverride.alpha * aBrightness;
         params.mPosX = particle.mPosition.x;
         params.mPosY = particle.mPosition.y;
         params.mParticleScale = this.evalParticleTrack(aDef.mParticleScale,particle,Particle.TRACK_PARTICLE_SCALE);
         params.mParticleStretch = this.evalParticleTrack(aDef.mParticleStretch,particle,Particle.TRACK_PARTICLE_STRETCH);
         params.mSpinPosition = particle.mSpinPosition;
         var aCrossParticle= particle.mCrossFadeParticle;
         if(aCrossParticle == null)
         {
            return true;
         }
         var aCrossFadeParams= new ParticleRenderParams();
         if(this.getRenderParams(aCrossParticle,aCrossFadeParams))
         {
            aFraction = particle.mParticleAge / (aCrossParticle.mCrossFadeDuration - 1);
            params.mAlpha = this.crossFadeLerp(aCrossFadeParams.mAlpha,params.mAlpha,aCrossFadeParams.mAlphaIsSet,params.mAlphaIsSet,aFraction);
            params.mRed = this.crossFadeLerp(aCrossFadeParams.mRed,params.mRed,aCrossFadeParams.mRedIsSet,params.mRedIsSet,aFraction);
            params.mGreen = this.crossFadeLerp(aCrossFadeParams.mGreen,params.mGreen,aCrossFadeParams.mGreenIsSet,params.mGreenIsSet,aFraction);
            params.mBlue = this.crossFadeLerp(aCrossFadeParams.mBlue,params.mBlue,aCrossFadeParams.mBlueIsSet,params.mBlueIsSet,aFraction);
            params.mParticleScale = this.crossFadeLerp(aCrossFadeParams.mParticleScale,params.mParticleScale,aCrossFadeParams.mParticleScaleIsSet,params.mParticleScaleIsSet,aFraction);
            params.mParticleStretch = this.crossFadeLerp(aCrossFadeParams.mParticleStretch,params.mParticleStretch,aCrossFadeParams.mParticleStretchIsSet,params.mParticleStretchIsSet,aFraction);
            params.mSpinPosition = this.crossFadeLerp(aCrossFadeParams.mSpinPosition,params.mSpinPosition,aCrossFadeParams.mSpinPositionIsSet,params.mSpinPositionIsSet,aFraction);
            params.mPosX = this.crossFadeLerp(aCrossFadeParams.mPosX,params.mPosX,aCrossFadeParams.mPositionIsSet,params.mPositionIsSet,aFraction);
            params.mPosY = this.crossFadeLerp(aCrossFadeParams.mPosY,params.mPosY,aCrossFadeParams.mPositionIsSet,params.mPositionIsSet,aFraction);
            params.mAlphaIsSet = params.mAlphaIsSet || aCrossFadeParams.mAlphaIsSet;
            params.mRedIsSet = params.mRedIsSet || aCrossFadeParams.mRedIsSet;
            params.mGreenIsSet = params.mGreenIsSet || aCrossFadeParams.mGreenIsSet;
            params.mBlueIsSet = params.mBlueIsSet || aCrossFadeParams.mBlueIsSet;
            params.mParticleScaleIsSet = params.mParticleScaleIsSet || aCrossFadeParams.mParticleScaleIsSet;
            params.mParticleStretchIsSet = params.mParticleStretchIsSet || aCrossFadeParams.mParticleStretchIsSet;
            params.mSpinPositionIsSet = params.mSpinPositionIsSet || aCrossFadeParams.mSpinPositionIsSet;
            params.mPositionIsSet = params.mPositionIsSet || aCrossFadeParams.mPositionIsSet;
         }
         return true;
      }
      
      function evalParticleTrack(track:FloatParameterTrack, particle:Particle, index:Float) : Float
      {
         return track.evaluate(particle.mParticleTimeValue,particle.mParticleInterp[Std.int(index)]);
      }
      
      function clamp(value:Float, min:Float, max:Float) : Float
      {
         var tmp= value < max ? value : max;
         return tmp > min ? tmp : min;
      }
      
      function renderParticle(g:Graphics2D, particle:Particle, params:ParticleRenderParams) 
      {
         var anEmitter= particle.mParticleEmitter;
         var aDef= anEmitter.mEmitterDef;
         var aImage= aDef.mImage;
         if(aImage == null)
         {
            return;
         }
         var aFrame:Float = 0;
         var aNumFrames= this.mEmitterDef.mImageFrames;
         if(this.mEmitterDef.mAnimationRate.isSet())
         {
            aFrame = Std.int(particle.mAnimationTimeValue * aNumFrames);
            aFrame = this.clamp(aFrame,0,aNumFrames - 1);
         }
         else if(this.mEmitterDef.mAnimated)
         {
            aFrame = Std.int(particle.mParticleTimeValue * aNumFrames);
            aFrame = this.clamp(aFrame,0,aNumFrames - 1);
         }
         else
         {
            aFrame = particle.mImageFrame;
         }
         aImage.setFrame(Std.int(aFrame),Std.int(aDef.mImageCol),Std.int(aDef.mImageRow));
         var aTransform= new Matrix();
         aTransform.translate(-aImage.width / 2,-aImage.height / 2);
         if(params.mSpinPositionIsSet)
         {
            aTransform.rotate(params.mSpinPosition);
         }
         if(params.mParticleScaleIsSet)
         {
            aTransform.scale(params.mParticleScale,params.mParticleScale);
         }
         if(params.mParticleStretchIsSet)
         {
            aTransform.scale(1,params.mParticleStretch);
         }
         aImage.useColor = params.mAlphaIsSet || params.mRedIsSet || params.mGreenIsSet || params.mBlueIsSet;
         aImage.setColor(params.mAlphaIsSet ? params.mAlpha : 1,params.mRedIsSet ? params.mRed : 1,params.mGreenIsSet ? params.mGreen : 1,params.mBlueIsSet ? params.mBlue : 1);
         aTransform.translate(params.mPosX,params.mPosY);
         g.pushState();
         g.setTransform(aTransform);
         g.drawImage(aImage,0,0);
         g.popState();
      }
      
      public function update() 
      {
         var aEmitterCrossFade:ParticleEmitter = null;
         var aParticleField:ParticleField = null;
         var aParticle:Particle = null;
         if(this.mDead)
         {
            return;
         }
         ++this.mSystemAge;
         var aDie= false;
         if(this.mSystemAge >= this.mSystemDuration)
         {
            if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.SYSTEM_LOOPS))
            {
               this.mSystemAge = 0;
            }
            else
            {
               this.mSystemAge = this.mSystemDuration - 1;
               aDie = true;
            }
         }
         if(this.mEmitterCrossFadeCountDown > 0)
         {
            --this.mEmitterCrossFadeCountDown;
            if(this.mEmitterCrossFadeCountDown == 0)
            {
               aDie = true;
            }
         }
         if(this.mCrossFadeEmitter != null)
         {
            aEmitterCrossFade = this.mCrossFadeEmitter;
            if(aEmitterCrossFade == null || aEmitterCrossFade.mDead)
            {
               aDie = true;
            }
         }
         this.mSystemTimeValue = this.mSystemAge / (this.mSystemDuration - 1);
         var aSystemFieldCount= this.mEmitterDef.mSystemFields.length;
         for(i in 0...aSystemFieldCount)
         {
            aParticleField = this.mEmitterDef.mSystemFields[i];
            this.updateSystemField(aParticleField,this.mSystemTimeValue,i);
         }
         var aNumParticles= this.mParticleList.length;
         var k= 0;while(k < aNumParticles)
         {
            aParticle = this.mParticleList[k];
            if(!this.updateParticle(aParticle))
            {
               this.deleteParticle(aParticle);
               k--;
               aNumParticles--;
            }
k++;
         }
         this.updateSpawning();
         if(aDie)
         {
            this.deleteNonCrossFading();
            if(this.mParticleList.length == 0)
            {
               this.mDead = true;
               return;
            }
         }
         this.mSystemLastTimeValue = this.mSystemTimeValue;
      }
      
      function updateParticleField(particle:Particle, field:ParticleField, time:Float, index:Int) 
      {
         var aInterpX= Math.NaN;
         var aInterpY= Math.NaN;
         var x= Math.NaN;
         var y= Math.NaN;
         var aDiffX= Math.NaN;
         var aDiffY= Math.NaN;
         var aLastX= Math.NaN;
         var aLastY= Math.NaN;
         var aCollisionReflect= Math.NaN;
         var aCollisionSpin= Math.NaN;
         aInterpX = ASCompat.toNumber(particle.mParticleFieldInterp[index][0]);
         aInterpY = ASCompat.toNumber(particle.mParticleFieldInterp[index][1]);
         x = field.mX.evaluate(time,aInterpX);
         y = field.mY.evaluate(time,aInterpY);
         switch(field.mFieldType)
         {
            case ParticleFieldType.ACCELERATION:
               particle.mVelocity.x += x * SECONDS_PER_UPDATE;
               particle.mVelocity.y += y * SECONDS_PER_UPDATE;
               
            case ParticleFieldType.FRICTION:
               particle.mVelocity.x *= 1 - x;
               particle.mVelocity.y *= 1 - y;
               
            case ParticleFieldType.ATTRACTOR:
               aDiffX = x - (particle.mPosition.x - this.mSystemCenter.x);
               aDiffY = y - (particle.mPosition.y - this.mSystemCenter.y);
               particle.mVelocity.x += aDiffX * SECONDS_PER_UPDATE;
               particle.mVelocity.y += aDiffY * SECONDS_PER_UPDATE;
               
            case ParticleFieldType.MAX_VELOCITY:
               particle.mVelocity.x = this.clamp(particle.mVelocity.x,-x,x);
               particle.mVelocity.y = this.clamp(particle.mVelocity.y,-y,y);
               
            case ParticleFieldType.VELOCITY:
               particle.mPosition.x += x * SECONDS_PER_UPDATE;
               particle.mPosition.y += y * SECONDS_PER_UPDATE;
               
            case ParticleFieldType.POSITION:
               aLastX = field.mX.evaluate(particle.mParticleLastTimeValue,aInterpX);
               aLastY = field.mY.evaluate(particle.mParticleLastTimeValue,aInterpY);
               particle.mPosition.x += x - aLastX;
               particle.mPosition.y += y - aLastY;
               
            case ParticleFieldType.GROUND_CONSTRAINT:
               if(particle.mPosition.y > this.mSystemCenter.y + y)
               {
                  particle.mPosition.y = this.mSystemCenter.y + y;
                  aCollisionReflect = this.mEmitterDef.mCollisionReflect.evaluate(time,particle.mParticleInterp[Particle.TRACK_PARTICLE_COLLISION_REFLECT]);
                  aCollisionSpin = this.mEmitterDef.mCollisionSpin.evaluate(time,particle.mParticleInterp[Particle.TRACK_PARTICLE_COLLISION_SPIN]) / 1000;
                  particle.mSpinVelocity = particle.mVelocity.y * aCollisionSpin;
                  particle.mVelocity.x *= aCollisionReflect;
                  particle.mVelocity.y = -particle.mVelocity.y * aCollisionReflect;
               }
               
            case ParticleFieldType.SHAKE:
               particle.mPosition.x -= particle.mOffset.x;
               particle.mPosition.y -= particle.mOffset.y;
               particle.mOffset.x = x * (Math.random() * ONE_OVER_32K * 2 - 1);
               particle.mOffset.y = y * (Math.random() * ONE_OVER_32K * 2 - 1);
               particle.mPosition.x += particle.mOffset.x;
               particle.mPosition.y += particle.mOffset.y;
               
            default:
               throw new Error("Unsupported field type \'" + field.mFieldType + "\'");
         }
      }
      
      public function draw(g:Graphics2D) 
      {
         var aParticle:Particle = null;
         if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.HARDWARE_ONLY))
         {
            return;
         }
         var aNumParticles= this.mParticleList.length;
         for(i in 0...aNumParticles)
         {
            aParticle = this.mParticleList[i];
            this.drawParticle(g,aParticle);
         }
      }
      
      function deleteParticle(particle:Particle) 
      {
         var aCrossParticle= particle.mCrossFadeParticle;
         if(aCrossParticle != null)
         {
            aCrossParticle.mParticleEmitter.deleteParticle(aCrossParticle);
            particle.mCrossFadeParticle = null;
         }
         var index:Float = this.mParticleList.indexOf(particle);
         if(index > -1)
         {
            this.mParticleList.splice(Std.int(index),1);
         }
      }
      
      function drawParticle(g:Graphics2D, particle:Particle) 
      {
         var aCrossFadeParticle:Particle = null;
         if(particle.mCrossFadeDuration > 0)
         {
            return;
         }
         var aParams= new ParticleRenderParams();
         if(!this.getRenderParams(particle,aParams))
         {
            return;
         }
         if(aParams.mAlpha == 0)
         {
            return;
         }
         aParams.mPosX += g.getTransform().tx;
         aParams.mPosY += g.getTransform().ty;
         var aImageParticle= particle;
         if(this.mImageOverride || this.mEmitterDef.mImage != null)
         {
            aImageParticle = particle;
         }
         else
         {
            aCrossFadeParticle = null;
            if(aCrossFadeParticle == null)
            {
               return;
            }
            aImageParticle = aCrossFadeParticle;
         }
         this.renderParticle(g,aImageParticle,aParams);
      }
      
      public function initFromDef(emitterDef:ParticleEmitterDefinition, system:ParticleSystem) 
      {
         var aSystemDurationInterp= Math.NaN;
         this.mEmitterDef = emitterDef;
         this.mParticleSystem = system;
         this.mSpawnAccum = 0;
         this.mParticlesSpawned = 0;
         this.mSystemAge = -1;
         this.mDead = false;
         this.mSystemTimeValue = -1;
         this.mSystemLastTimeValue = -1;
         this.mSystemDuration = 0;
         this.mSystemCenter = new Point();
         this.mParticleList = new Array<ASAny>();
         if(this.mEmitterDef.mSystemDuration.isSet())
         {
            aSystemDurationInterp = Math.random();
            this.mSystemDuration = this.mEmitterDef.mSystemDuration.evaluate(0,aSystemDurationInterp);
         }
         else
         {
            this.mSystemDuration = this.mEmitterDef.mParticleDuration.evaluate(0,1);
         }
         this.mSystemDuration = this.mSystemDuration > 1 ? this.mSystemDuration : 1;
         var aSystemFieldCount= this.mEmitterDef.mSystemFields.length;
         this.mSystemFieldInterp = new Array<ASAny>();
         for(i in 0...aSystemFieldCount)
         {
            this.mSystemFieldInterp[i] = new Array<ASAny>();
            this.mSystemFieldInterp[i][0] = Math.random();
            this.mSystemFieldInterp[i][1] = Math.random();
         }
         this.mTrackInterp = ASCompat.allocArray(NUM_SYSTEM_TRACKS);
         var aNumInterps= this.mTrackInterp.length;
         for(k in 0...aNumInterps)
         {
            this.mTrackInterp[k] = Math.random();
         }
         this.update();
      }
      
      function updateParticle(particle:Particle) : Bool
      {
         var aField:ParticleField = null;
         if(particle.mParticleAge >= particle.mParticleDuration)
         {
            if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.PARTICLE_LOOPS))
            {
               particle.mParticleAge = 0;
            }
            else
            {
               if(particle.mCrossFadeDuration <= 0)
               {
                  return false;
               }
               particle.mParticleAge = particle.mParticleDuration - 1;
            }
         }
         particle.mParticleTimeValue = particle.mParticleAge / (particle.mParticleDuration - 1);
         var aFieldCount= this.mEmitterDef.mParticleFields.length;
         for(i in 0...aFieldCount)
         {
            aField = this.mEmitterDef.mParticleFields[i];
            this.updateParticleField(particle,aField,particle.mParticleTimeValue,i);
         }
         particle.mPosition.x += particle.mVelocity.x;
         particle.mPosition.y += particle.mVelocity.y;
         var aSpinSpeed= this.mEmitterDef.mParticleSpinSpeed.evaluate(particle.mParticleTimeValue,particle.mParticleInterp[Particle.TRACK_PARTICLE_SPIN_SPEED]) * SECONDS_PER_UPDATE;
         var aSpinAngle= this.mEmitterDef.mParticleSpinAngle.evaluate(particle.mParticleTimeValue,particle.mParticleInterp[Particle.TRACK_PARTICLE_SPIN_ANGLE]);
         var aLastSpinAngle= this.mEmitterDef.mParticleSpinAngle.evaluateLast(particle.mParticleLastTimeValue,particle.mParticleInterp[Particle.TRACK_PARTICLE_SPIN_ANGLE]);
         particle.mSpinPosition += aSpinSpeed + aSpinAngle - aLastSpinAngle;
         particle.mSpinPosition += particle.mSpinVelocity;
         if(this.mEmitterDef.mAnimationRate.isSet())
         {
            throw new Error("Not implemented!");
         }
         particle.mParticleLastTimeValue = particle.mParticleTimeValue;
         ++particle.mParticleAge;
         return true;
      }
      
      function updateSpawning() 
      {
         var aSpawnMinimum= Math.NaN;
         var aMaxCanSpawn= Math.NaN;
         var aSpawnMaxLaunched= 0;
         var aMaxCanSpawn2= Math.NaN;
         var aParticle:Particle = null;
         var aSpawnEmitter= this;
         var aCrossFadeEmitter= this.mCrossFadeEmitter;
         if(aCrossFadeEmitter != null)
         {
            aSpawnEmitter = aCrossFadeEmitter;
         }
         var aDef= aSpawnEmitter.mEmitterDef;
         var aTrack:FloatParameterTrack = null;
         var aTime:Float = 0;
         var anInterp:Float = 0;
         aTrack = aDef.mSpawnRate;
         aTime = aSpawnEmitter.mSystemTimeValue;
         anInterp = ASCompat.toNumber(aSpawnEmitter.mTrackInterp[Std.int(TRACK_SPAWN_RATE)]);
         this.mSpawnAccum += aTrack.evaluate(aTime,anInterp) * SECONDS_PER_UPDATE;
         var aSpawnCount= Std.int(this.mSpawnAccum);
         this.mSpawnAccum -= aSpawnCount;
         aTrack = aDef.mSpawnMinActive;
         aTime = aSpawnEmitter.mSystemTimeValue;
         anInterp = ASCompat.toNumber(aSpawnEmitter.mTrackInterp[Std.int(TRACK_SPAWN_MIN_ACTIVE)]);
         var aSpawnMinActive= Std.int(aTrack.evaluate(aTime,anInterp));
         if(aSpawnMinActive >= 0)
         {
            aSpawnMinimum = aSpawnMinActive - this.mParticleList.length;
            if(aSpawnCount < aSpawnMinimum)
            {
               aSpawnCount = Std.int(aSpawnMinimum);
            }
         }
         aTrack = aDef.mSpawnMaxActive;
         aTime = aSpawnEmitter.mSystemTimeValue;
         anInterp = ASCompat.toNumber(aSpawnEmitter.mTrackInterp[Std.int(TRACK_SPAWN_MAX_ACTIVE)]);
         var aSpawnMaxActive= Std.int(aTrack.evaluate(aTime,anInterp));
         if(aSpawnMaxActive >= 0)
         {
            aMaxCanSpawn = aSpawnMaxActive - this.mParticleList.length;
            if(aSpawnCount > aMaxCanSpawn)
            {
               aSpawnCount = Std.int(aMaxCanSpawn);
            }
         }
         if(aDef.mSpawnMaxLaunched.isSet())
         {
            aTrack = aDef.mSpawnMaxLaunched;
            aTime = aSpawnEmitter.mSystemTimeValue;
            anInterp = ASCompat.toNumber(aSpawnEmitter.mTrackInterp[Std.int(TRACK_SPAWN_MAX_LAUNCHED)]);
            aSpawnMaxLaunched = Std.int(aTrack.evaluate(aTime,anInterp));
            aMaxCanSpawn2 = aSpawnMaxLaunched - this.mParticlesSpawned;
            if(aSpawnCount > aMaxCanSpawn2)
            {
               aSpawnCount = Std.int(aMaxCanSpawn2);
            }
         }
         for(i in 0...aSpawnCount)
         {
            aParticle = this.spawnParticle(i,aSpawnCount);
            if(aCrossFadeEmitter != null)
            {
               this.crossFadeParticle(aParticle,aCrossFadeEmitter);
            }
         }
      }
      
      function crossFadeLerp(from:Float, to:Float, fromIsSet:Bool, toIsSet:Bool, fraction:Float) : Float
      {
         if(!fromIsSet)
         {
            return to;
         }
         if(!toIsSet)
         {
            return from;
         }
         return from + (to - from) * fraction;
      }
      
      public function deleteAll() 
      {
         this.mParticleList = new Array<ASAny>();
      }
   }

