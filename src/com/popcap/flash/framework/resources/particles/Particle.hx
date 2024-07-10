package com.popcap.flash.framework.resources.particles
;
   import flash.geom.Point;
   
    class Particle
   {
      
      public static inline final TRACK_PARTICLE_STRETCH= 8;
      
      public static inline final TRACK_PARTICLE_SCALE= 7;
      
      public static inline final NUM_PARTICLE_TRACKS= 16;
      
      public static inline final TRACK_PARTICLE_COLLISION_REFLECT= 9;
      
      public static inline final TRACK_PARTICLE_RED= 0;
      
      public static inline final TRACK_PARTICLE_CLIP_TOP= 11;
      
      public static inline final TRACK_PARTICLE_COLLISION_SPIN= 10;
      
      public static inline final TRACK_PARTICLE_CLIP_BOTTOM= 12;
      
      public static inline final TRACK_PARTICLE_ALPHA= 3;
      
      public static inline final TRACK_PARTICLE_BLUE= 2;
      
      public static inline final TRACK_PARTICLE_ANIMATION_RATE= 15;
      
      public static inline final TRACK_PARTICLE_CLIP_RIGHT= 14;
      
      public static inline final TRACK_PARTICLE_BRIGHTNESS= 4;
      
      public static inline final TRACK_PARTICLE_SPIN_SPEED= 5;
      
      public static inline final TRACK_PARTICLE_CLIP_LEFT= 13;
      
      public static inline final TRACK_PARTICLE_SPIN_ANGLE= 6;
      
      public static inline final TRACK_PARTICLE_GREEN= 1;
       
      
      public var mParticleDuration:Float = Math.NaN;
      
      public var mParticleLastTimeValue:Float = Math.NaN;
      
      public var mSpinVelocity:Float = Math.NaN;
      
      public var mAnimationTimeValue:Float = Math.NaN;
      
      public var mParticleTimeValue:Float = Math.NaN;
      
      public var mCrossFadeParticle:Particle;
      
      public var mParticleInterp:Array<ASAny>;
      
      public var mParticleEmitter:ParticleEmitter;
      
      public var mSpinPosition:Float = Math.NaN;
      
      public var mOffset:Point;
      
      public var mParticleFieldInterp:Array<ASAny>;
      
      public var mCrossFadeDuration:Float = Math.NaN;
      
      public var mImageFrame:Float = Math.NaN;
      
      public var mVelocity:Point;
      
      public var mParticleAge:Float = Math.NaN;
      
      public var mPosition:Point;
      
      public function new()
      {
         //super();
         this.mPosition = new Point();
         this.mOffset = new Point();
         this.mVelocity = new Point();
         this.mParticleInterp = new Array<ASAny>();
         this.mParticleFieldInterp = new Array<ASAny>();
      }
   }

