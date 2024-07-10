package com.popcap.flash.games.pvz
;
   import com.popcap.flash.framework.resources.foley.FoleyFlags;
   import com.popcap.flash.framework.resources.foley.FoleyType;
   import com.popcap.flash.games.pvz.resources.PVZSounds;
   
    class PVZFoleyType
   {
      
      public static final SPLAT:FoleyType = new FoleyType(10,[PVZSounds.SOUND_SPLAT,PVZSounds.SOUND_SPLAT2,PVZSounds.SOUND_SPLAT3],FoleyFlags.NONE);
      
      public static final CRAZYDAVESCREAM:FoleyType = new FoleyType(0,[PVZSounds.SOUND_CRAZYDAVESCREAM],FoleyFlags.NONE);
      
      public static final BOWLINGIMPACT2:FoleyType = new FoleyType(0,[PVZSounds.SOUND_BOWLINGIMPACT2],FoleyFlags.NONE);
      
      public static final BLEEP:FoleyType = new FoleyType(0,[PVZSounds.SOUND_BLEEP],FoleyFlags.NONE);
      
      public static final ROLL_IN:FoleyType = new FoleyType(0,[PVZSounds.SOUND_ROLL_IN],FoleyFlags.NONE);
      
      public static final HUGEWAVE:FoleyType = new FoleyType(0,[PVZSounds.SOUND_HUGEWAVE],FoleyFlags.NONE);
      
      public static final SUN:FoleyType = new FoleyType(10,[PVZSounds.SOUND_POINTS1,PVZSounds.SOUND_POINTS2,PVZSounds.SOUND_POINTS3,PVZSounds.SOUND_POINTS4,PVZSounds.SOUND_POINTS5],FoleyFlags.NONE);
      
      public static final CRAZYDAVEEXTRALONG:FoleyType = new FoleyType(0,[PVZSounds.SOUND_CRAZYDAVEEXTRALONG1,PVZSounds.SOUND_CRAZYDAVEEXTRALONG2,PVZSounds.SOUND_CRAZYDAVEEXTRALONG3],new FoleyFlags(FoleyFlags.DONT_REPEAT));
      
      public static final GRAVESTONE_RUMBLE:FoleyType = new FoleyType(10,[PVZSounds.SOUND_GRAVESTONE_RUMBLE],FoleyFlags.NONE);
      
      public static final NEWSPAPER_RIP:FoleyType = new FoleyType(-2,[PVZSounds.SOUND_NEWSPAPER_RIP],FoleyFlags.NONE);
      
      public static final PLASTIC_HIT:FoleyType = new FoleyType(5,[PVZSounds.SOUND_PLASTICHIT,PVZSounds.SOUND_PLASTICHIT2],FoleyFlags.NONE);
      
      public static final BRAINS:FoleyType = new FoleyType(0,[PVZSounds.SOUND_GROAN,PVZSounds.SOUND_GROAN2,PVZSounds.SOUND_GROAN3,PVZSounds.SOUND_GROAN4,PVZSounds.SOUND_GROAN5,PVZSounds.SOUND_GROAN6],FoleyFlags.NONE);
      
      public static final VASE_BREAKING:FoleyType = new FoleyType(-5,[PVZSounds.SOUND_VASE_BREAKING],FoleyFlags.NONE);
      
      public static final SPAWN_SUN:FoleyType = new FoleyType(10,[PVZSounds.SOUND_THROW1],FoleyFlags.NONE);
      
      public static final PLANT:FoleyType = new FoleyType(0,[PVZSounds.SOUND_PLANT,PVZSounds.SOUND_PLANT2],FoleyFlags.NONE);
      
      public static final SNOW_PEA_SPARKLES:FoleyType = new FoleyType(10,[PVZSounds.SOUND_SNOW_PEA_SPARKLES],FoleyFlags.NONE);
      
      public static final EVILLAUGH:FoleyType = new FoleyType(5,[PVZSounds.SOUND_EVILLAUGH],FoleyFlags.NONE);
      
      public static final JUICY:FoleyType = new FoleyType(2,[PVZSounds.SOUND_JUICY],FoleyFlags.NONE);
      
      public static final NEWSPAPER_RARRGH:FoleyType = new FoleyType(-2,[PVZSounds.SOUND_NEWSPAPER_RARRGH,PVZSounds.SOUND_NEWSPAPER_RARRGH2,PVZSounds.SOUND_NEWSPAPER_RARRGH2],FoleyFlags.NONE);
      
      public static final GRAVEBUTTON:FoleyType = new FoleyType(0,[PVZSounds.SOUND_GRAVEBUTTON],FoleyFlags.NONE);
      
      public static final POLEVAULT:FoleyType = new FoleyType(0,[PVZSounds.SOUND_POLEVAULT],FoleyFlags.NONE);
      
      public static final SIREN:FoleyType = new FoleyType(0,[PVZSounds.SOUND_SIREN],FoleyFlags.NONE);
      
      public static final FINALWAVE:FoleyType = new FoleyType(0,[PVZSounds.SOUND_FINALWAVE],FoleyFlags.NONE);
      
      public static final ZOMBIE_FALLING:FoleyType = new FoleyType(10,[PVZSounds.SOUND_ZOMBIE_FALLING_1,PVZSounds.SOUND_ZOMBIE_FALLING_2],FoleyFlags.NONE);
      
      public static final USE_SHOVEL:FoleyType = new FoleyType(0,[PVZSounds.SOUND_PLANT2],FoleyFlags.NONE);
      
      public static final CHOMP_SOFT:FoleyType = new FoleyType(4,[PVZSounds.SOUND_CHOMPSOFT],FoleyFlags.NONE);
      
      public static final DIRT_RISE:FoleyType = new FoleyType(5,[PVZSounds.SOUND_DIRT_RISE],FoleyFlags.NONE);
      
      public static final TAP:FoleyType = new FoleyType(0,[PVZSounds.SOUND_TAP],FoleyFlags.NONE);
      
      public static final PUFF:FoleyType = new FoleyType(10,[PVZSounds.SOUND_PUFF],FoleyFlags.NONE);
      
      public static final DIGGER:FoleyType = new FoleyType(0,[PVZSounds.SOUND_DIGGER_ZOMBIE],new FoleyFlags(FoleyFlags.LOOP | FoleyFlags.ONE_AT_A_TIME | FoleyFlags.MUTE_ON_PAUSE));
      
      public static final SHIELD_HIT:FoleyType = new FoleyType(10,[PVZSounds.SOUND_SHIELDHIT,PVZSounds.SOUND_SHIELDHIT2],FoleyFlags.NONE);
      
      public static final CRAZYDAVESHORT:FoleyType = new FoleyType(0,[PVZSounds.SOUND_CRAZYDAVESHORT1,PVZSounds.SOUND_CRAZYDAVESHORT2,PVZSounds.SOUND_CRAZYDAVESHORT3],new FoleyFlags(FoleyFlags.DONT_REPEAT));
      
      public static final FROZEN:FoleyType = new FoleyType(0,[PVZSounds.SOUND_FROZEN],FoleyFlags.NONE);
      
      public static final SHOVEL:FoleyType = new FoleyType(5,[PVZSounds.SOUND_SHOVEL],FoleyFlags.NONE);
      
      public static final CRAZYDAVESCREAM2:FoleyType = new FoleyType(0,[PVZSounds.SOUND_CRAZYDAVESCREAM2],FoleyFlags.NONE);
      
      public static final FUME:FoleyType = new FoleyType(10,[PVZSounds.SOUND_FUME],FoleyFlags.NONE);
      
      public static final CHOMP:FoleyType = new FoleyType(0,[PVZSounds.SOUND_CHOMP,PVZSounds.SOUND_CHOMP2],FoleyFlags.NONE);
      
      public static final BOWLING:FoleyType = new FoleyType(0,[PVZSounds.SOUND_BOWLING],FoleyFlags.NONE);
      
      public static final LIMBS_POP:FoleyType = new FoleyType(10,[PVZSounds.SOUND_LIMBS_POP1,PVZSounds.SOUND_LIMBS_POP2,PVZSounds.SOUND_LIMBS_POP3,PVZSounds.SOUND_LIMBS_POP4,PVZSounds.SOUND_LIMBS_POP5],FoleyFlags.NONE);
      
      public static final CRAZYDAVECRAZY:FoleyType = new FoleyType(0,[PVZSounds.SOUND_CRAZYDAVECRAZY],FoleyFlags.NONE);
      
      public static final GRAVEBUSTERCHOMP:FoleyType = new FoleyType(0,[PVZSounds.SOUND_GRAVEBUSTERCHOMP],new FoleyFlags(FoleyFlags.MUTE_ON_PAUSE));
      
      public static final REVERSE_EXPLOSION:FoleyType = new FoleyType(0,[PVZSounds.SOUND_REVERSE_EXPLOSION],FoleyFlags.NONE);
      
      public static final BUZZER:FoleyType = new FoleyType(0,[PVZSounds.SOUND_BUZZER],FoleyFlags.NONE);
      
      public static final CHERRYBOMB:FoleyType = new FoleyType(0,[PVZSounds.SOUND_CHERRYBOMB],FoleyFlags.NONE);
      
      public static final THUMP:FoleyType = new FoleyType(2,[PVZSounds.SOUND_GARGANTUAR_THUMP],FoleyFlags.NONE);
      
      public static final THROW:FoleyType = new FoleyType(10,[PVZSounds.SOUND_THROW1,PVZSounds.SOUND_THROW2,PVZSounds.SOUND_THROW3],FoleyFlags.NONE);
      
      public static final BIGCHOMP:FoleyType = new FoleyType(-2,[PVZSounds.SOUND_BIGCHOMP],FoleyFlags.NONE);
      
      public static final BONK:FoleyType = new FoleyType(2,[PVZSounds.SOUND_BONK],FoleyFlags.NONE);
      
      public static final READYSETPLANT:FoleyType = new FoleyType(0,[PVZSounds.SOUND_READYSETPLANT],FoleyFlags.NONE);
      
      public static final GRASS_STEP:FoleyType = new FoleyType(0,[PVZSounds.SOUND_GRASSSTEP],FoleyFlags.NONE);
      
      public static final LAWNMOWER:FoleyType = new FoleyType(10,[PVZSounds.SOUND_LAWNMOWER],FoleyFlags.NONE);
      
      public static final CRAZYDAVELONG:FoleyType = new FoleyType(0,[PVZSounds.SOUND_CRAZYDAVELONG1,PVZSounds.SOUND_CRAZYDAVELONG2,PVZSounds.SOUND_CRAZYDAVELONG3],new FoleyFlags(FoleyFlags.DONT_REPEAT));
      
      public static final PAUSE:FoleyType = new FoleyType(0,[PVZSounds.SOUND_PAUSE],FoleyFlags.NONE);
      
      public static final SWING:FoleyType = new FoleyType(2,[PVZSounds.SOUND_SWING],FoleyFlags.NONE);
      
      public static final PLANTGROW:FoleyType = new FoleyType(-2,[PVZSounds.SOUND_PLANTGROW],FoleyFlags.NONE);
      
      public static final BOWLINGIMPACT:FoleyType = new FoleyType(-3,[PVZSounds.SOUND_BOWLINGIMPACT],FoleyFlags.NONE);
      
      public static final SQUASH_HMM:FoleyType = new FoleyType(2,[PVZSounds.SOUND_SQUASH_HMM,PVZSounds.SOUND_SQUASH_HMM,PVZSounds.SOUND_SQUASH_HMM2],FoleyFlags.NONE);
      
      public static final DROP:FoleyType = new FoleyType(0,[PVZSounds.SOUND_TAP2],FoleyFlags.NONE);
      
      public static final AWOOGA:FoleyType = new FoleyType(0,[PVZSounds.SOUND_AWOOGA],FoleyFlags.NONE);
      
      public static final GROAN:FoleyType = new FoleyType(0,[PVZSounds.SOUND_GROAN,PVZSounds.SOUND_GROAN2,PVZSounds.SOUND_GROAN3,PVZSounds.SOUND_GROAN4,PVZSounds.SOUND_GROAN5,PVZSounds.SOUND_GROAN6],FoleyFlags.NONE);
      
      public static final GULP:FoleyType = new FoleyType(0,[PVZSounds.SOUND_GULP],FoleyFlags.NONE);
      
      public static final SEEDLIFT:FoleyType = new FoleyType(0,[PVZSounds.SOUND_SEEDLIFT],FoleyFlags.NONE);
      
      public static final SCREAM:FoleyType = new FoleyType(0,[PVZSounds.SOUND_SCREAM],FoleyFlags.NONE);
       
      
      public function new()
      {
         //super();
      }
   }

