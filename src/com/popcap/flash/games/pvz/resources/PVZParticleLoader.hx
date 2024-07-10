package com.popcap.flash.games.pvz.resources
;
   import com.popcap.flash.framework.resources.particles.ByteParticleDescriptor;
   import flash.utils.ByteArray;
   
    class PVZParticleLoader
   {
      
      public static final PARTICLE_ZOMBIEFLAG_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEFLAG_CLASS;
      
      public static final PARTICLE_SNOWPEASPLAT_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_SNOWPEASPLAT_CLASS;
      
      public static final PARTICLE_DIGGERRISE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_DIGGERRISE_CLASS;
      
      public static final PARTICLE_STARBURST_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_STARBURST_CLASS;
      
      public static final PARTICLE_ZOMBIEHEADLIGHT_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEHEADLIGHT_CLASS;
      
      public static final PARTICLE_ZOMBIENEWSPAPERHEAD_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIENEWSPAPERHEAD_CLASS;
      
      public static final PARTICLE_ZOMBIEHEADPOOL_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEHEADPOOL_CLASS;
      
      public static final PARTICLE_COINPICKUPARROW_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_COINPICKUPARROW_CLASS;
      
      public static final PARTICLE_VASESHATTERLEAF_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_VASESHATTERLEAF_CLASS;
      
      public static final PARTICLE_VASESHATTERZOMBIE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_VASESHATTERZOMBIE_CLASS;
      
      public static final PARTICLE_GRAVEBUSTER_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_GRAVEBUSTER_CLASS;
      
      public static final PARTICLE_WALLNUTEATLARGE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_WALLNUTEATLARGE_CLASS;
      
      public static final PARTICLE_PUFFSHROOMTRAIL_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_PUFFSHROOMTRAIL_CLASS;
      
      public static final PARTICLE_ZOMBIENEWSPAPER_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIENEWSPAPER_CLASS;
      
      public static final PARTICLE_PEASPLAT_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_PEASPLAT_CLASS;
      
      public static final PARTICLE_ARTCHALLENGEPLANT_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ARTCHALLENGEPLANT_CLASS;
      
      public static final PARTICLE_DUST_SQUASH_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_DUST_SQUASH_CLASS;
      
      public static final PARTICLE_SEEDPACKETFLASH_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_SEEDPACKETFLASH_CLASS;
      
      public static final PARTICLE_JACKEXPLODE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_JACKEXPLODE_CLASS;
      
      public static final PARTICLE_MOWEREDZOMBIEARM_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_MOWEREDZOMBIEARM_CLASS;
      
      public static final PARTICLE_SEEDPACKET_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_SEEDPACKET_CLASS;
      
      public static final PARTICLE_POTATOMINE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_POTATOMINE_CLASS;
      
      public static final PARTICLE_ZOMBIEPAIL_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEPAIL_CLASS;
      
      public static final PARTICLE_POWIE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_POWIE_CLASS;
      
      public static final PARTICLE_ZOMBIEARM_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEARM_CLASS;
      
      public static final PARTICLE_UPSELLARROW_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_UPSELLARROW_CLASS;
      
      public static final PARTICLE_PUFFSPLAT_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_PUFFSPLAT_CLASS;
      
      public static final PARTICLE_ZOMBIEHEAD_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEHEAD_CLASS;
      
      public static final PARTICLE_ZOMBIEPOLEVALUTHEAD_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEPOLEVALUTHEAD_CLASS;
      
      public static final PARTICLE_SODROLL_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_SODROLL_CLASS;
      
      public static final PARTICLE_ICETRAP_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ICETRAP_CLASS;
      
      public static final PARTICLE_PLANTING_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_PLANTING_CLASS;
      
      public static final PARTICLE_SEEDPACKETPICKUP_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_SEEDPACKETPICKUP_CLASS;
      
      public static final PARTICLE_AWARD_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_AWARD_CLASS;
      
      public static final PARTICLE_ZOMBIERISE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIERISE_CLASS;
      
      public static final PARTICLE_MOWERCLOUD_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_MOWERCLOUD_CLASS;
      
      public static final PARTICLE_MOWEREDZOMBIEHEAD_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_MOWEREDZOMBIEHEAD_CLASS;
      
      public static final PARTICLE_ZOMBIEFOOTBALLARM_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEFOOTBALLARM_CLASS;
      
      public static final PARTICLE_DIGGERTUNNEL_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_DIGGERTUNNEL_CLASS;
      
      public static final PARTICLE_ZOMBIEFOOTBALLHEAD_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEFOOTBALLHEAD_CLASS;
      
      public static final PARTICLE_PRESENTPICKUP_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_PRESENTPICKUP_CLASS;
      
      public static final PARTICLE_VASESHATTER_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_VASESHATTER_CLASS;
      
      public static final PARTICLE_ZOMBIEHELMET_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEHELMET_CLASS;
      
      public static final PARTICLE_ZOMBIEPOLEVAULTARM_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEPOLEVAULTARM_CLASS;
      
      public static final PARTICLE_AWARDPICKUPARROW_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_AWARDPICKUPARROW_CLASS;
      
      public static final PARTICLE_ZOMBIEDOOR_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIEDOOR_CLASS;
      
      public static final PARTICLE_PUFFSHROOMMUZZLE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_PUFFSHROOMMUZZLE_CLASS;
      
      public static final PARTICLE_ZOMBIETRAFFICCONE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ZOMBIETRAFFICCONE_CLASS;
      
      public static final PARTICLE_SCREENFLASH_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_SCREENFLASH_CLASS;
      
      public static final PARTICLE_GRAVEBUSTERDIE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_GRAVEBUSTERDIE_CLASS;
      
      public static final PARTICLE_SEEDPACKETPICK_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_SEEDPACKETPICK_CLASS;
      
      public static final PARTICLE_CIRCLEEVENSPACING_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_CIRCLEEVENSPACING_CLASS;
      
      public static final PARTICLE_ICESPARKLE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_ICESPARKLE_CLASS;
      
      public static final PARTICLE_SNOWPEAPUFF_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_SNOWPEAPUFF_CLASS;
      
      public static final PARTICLE_SNOWPEATRAIL_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_SNOWPEATRAIL_CLASS;
      
      public static final PARTICLE_WALLNUTEATSMALL_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_WALLNUTEATSMALL_CLASS;
      
      public static final PARTICLE_FUMECLOUD_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_FUMECLOUD_CLASS;
      
      public static final PARTICLE_GRAVESTONERISE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_GRAVESTONERISE_CLASS;
      
      public static final PARTICLE_POTATOMINERISE_CLASS:Class<Dynamic> = PVZParticleLoader_PARTICLE_POTATOMINERISE_CLASS;
       
      
      public function new()
      {
         //super();
      }
      
      public static function init(param1:ASDictionary<ASAny,ASAny>) 
      {
         param1[PVZParticles.PARTICLE_ARTCHALLENGEPLANT] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ARTCHALLENGEPLANT_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_AWARD] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_AWARD_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_AWARDPICKUPARROW] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_AWARDPICKUPARROW_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_CIRCLEEVENSPACING] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_CIRCLEEVENSPACING_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_COINPICKUPARROW] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_COINPICKUPARROW_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_DIGGERRISE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_DIGGERRISE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_DIGGERTUNNEL] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_DIGGERTUNNEL_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_DUST_SQUASH] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_DUST_SQUASH_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_FUMECLOUD] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_FUMECLOUD_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_GRAVEBUSTER] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_GRAVEBUSTER_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_GRAVEBUSTERDIE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_GRAVEBUSTERDIE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_GRAVESTONERISE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_GRAVESTONERISE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ICESPARKLE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ICESPARKLE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ICETRAP] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ICETRAP_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_JACKEXPLODE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_JACKEXPLODE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_MOWERCLOUD] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_MOWERCLOUD_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_MOWEREDZOMBIEARM] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_MOWEREDZOMBIEARM_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_MOWEREDZOMBIEHEAD] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_MOWEREDZOMBIEHEAD_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_PEASPLAT] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_PEASPLAT_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_PLANTING] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_PLANTING_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_POTATOMINE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_POTATOMINE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_POTATOMINERISE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_POTATOMINERISE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_POWIE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_POWIE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_PRESENTPICKUP] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_PRESENTPICKUP_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_PUFFSHROOMMUZZLE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_PUFFSHROOMMUZZLE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_PUFFSHROOMTRAIL] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_PUFFSHROOMTRAIL_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_PUFFSPLAT] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_PUFFSPLAT_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_SCREENFLASH] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_SCREENFLASH_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_SEEDPACKET] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_SEEDPACKET_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_SEEDPACKETFLASH] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_SEEDPACKETFLASH_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_SEEDPACKETPICK] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_SEEDPACKETPICK_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_SEEDPACKETPICKUP] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_SEEDPACKETPICKUP_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_SNOWPEAPUFF] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_SNOWPEAPUFF_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_SNOWPEASPLAT] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_SNOWPEASPLAT_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_SNOWPEATRAIL] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_SNOWPEATRAIL_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_SODROLL] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_SODROLL_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_STARBURST] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_STARBURST_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_UPSELLARROW] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_UPSELLARROW_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_VASESHATTER] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_VASESHATTER_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_VASESHATTERLEAF] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_VASESHATTERLEAF_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_VASESHATTERZOMBIE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_VASESHATTERZOMBIE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_WALLNUTEATLARGE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_WALLNUTEATLARGE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_WALLNUTEATSMALL] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_WALLNUTEATSMALL_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEARM] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEARM_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEDOOR] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEDOOR_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEFLAG] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEFLAG_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEFOOTBALLARM] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEFOOTBALLARM_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEFOOTBALLHEAD] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEFOOTBALLHEAD_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEHEAD] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEHEAD_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEHEADLIGHT] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEHEADLIGHT_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEHEADPOOL] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEHEADPOOL_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEHELMET] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEHELMET_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIENEWSPAPER] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIENEWSPAPER_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIENEWSPAPERHEAD] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIENEWSPAPERHEAD_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEPAIL] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEPAIL_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEPOLEVALUTHEAD] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEPOLEVALUTHEAD_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIEPOLEVAULTARM] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIEPOLEVAULTARM_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIERISE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIERISE_CLASS, []) : ByteArray) );
         param1[PVZParticles.PARTICLE_ZOMBIETRAFFICCONE] = new ByteParticleDescriptor((Type.createInstance(PARTICLE_ZOMBIETRAFFICCONE_CLASS, []) : ByteArray) );
      }
   }

