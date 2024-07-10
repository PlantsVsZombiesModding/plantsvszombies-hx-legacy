package com.popcap.flash.games.pvz.resources
;
   import com.popcap.flash.framework.resources.reanimator.ByteReanimDescriptor;
   import flash.utils.ByteArray;
   
    class PVZReanimLoader
   {
      
      static final REANIM_ZOMBIE_FOOTBALL_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_ZOMBIE_FOOTBALL_CLASS;
      
      static final REANIM_ZOMBIE_PAPER_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_ZOMBIE_PAPER_CLASS;
      
      static final REANIM_ZOMBIE_HAND_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_ZOMBIE_HAND_CLASS;
      
      static final REANIM_DYNOMITE_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_DYNOMITE_CLASS;
      
      static final REANIM_ZOMBIE_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_ZOMBIE_CLASS;
      
      static final REANIM_SUNFLOWER_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_SUNFLOWER_CLASS;
      
      static final REANIM_PUFFSHROOM_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_PUFFSHROOM_CLASS;
      
      static final REANIM_LOADBAR_ZOMBIEHEAD_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_LOADBAR_ZOMBIEHEAD_CLASS;
      
      static final REANIM_ZOMBIE_CHARRED_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_ZOMBIE_CHARRED_CLASS;
      
      static final REANIM_CHOMPER_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_CHOMPER_CLASS;
      
      static final REANIM_SUNSHROOM_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_SUNSHROOM_CLASS;
      
      static final REANIM_LAWNMOWER_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_LAWNMOWER_CLASS;
      
      static final REANIM_SELECTORSCREEN_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_SELECTORSCREEN_CLASS;
      
      static final REANIM_WALLNUT_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_WALLNUT_CLASS;
      
      static final REANIM_SODROLL_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_SODROLL_CLASS;
      
      static final REANIM_HAMMER_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_HAMMER_CLASS;
      
      static final REANIM_SUN_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_SUN_CLASS;
      
      static final REANIM_FUMESHROOM_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_FUMESHROOM_CLASS;
      
      static final REANIM_LEFTPEATER_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_LEFTPEATER_CLASS;
      
      static final REANIM_LOADBAR_SPROUT_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_LOADBAR_SPROUT_CLASS;
      
      static final REANIM_ZOMBIE_POLEVAULTER_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_ZOMBIE_POLEVAULTER_CLASS;
      
      static final REANIM_GRAVEBUSTER_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_GRAVEBUSTER_CLASS;
      
      static final REANIM_SNOWPEA_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_SNOWPEA_CLASS;
      
      static final REANIM_CHERRYBOMB_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_CHERRYBOMB_CLASS;
      
      static final REANIM_SQUASH_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_SQUASH_CLASS;
      
      static final REANIM_PEASHOOTER_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_PEASHOOTER_CLASS;
      
      static final REANIM_LAWNMOWEREDZOMBIE_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_LAWNMOWEREDZOMBIE_CLASS;
      
      static final REANIM_CRAZYDAVE_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_CRAZYDAVE_CLASS;
      
      static final REANIM_PEASHOOTERSINGLE_CLASS:Class<Dynamic> = PVZReanimLoader_REANIM_PEASHOOTERSINGLE_CLASS;
       
      
      public function new()
      {
         //super();
      }
      
      public static function init(param1:ASDictionary<ASAny,ASAny>) 
      {
         param1[PVZReanims.REANIM_CHERRYBOMB] = new ByteReanimDescriptor((Type.createInstance(REANIM_CHERRYBOMB_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_CHOMPER] = new ByteReanimDescriptor((Type.createInstance(REANIM_CHOMPER_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_CRAZYDAVE] = new ByteReanimDescriptor((Type.createInstance(REANIM_CRAZYDAVE_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_DYNOMITE] = new ByteReanimDescriptor((Type.createInstance(REANIM_DYNOMITE_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_FUMESHROOM] = new ByteReanimDescriptor((Type.createInstance(REANIM_FUMESHROOM_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_GRAVEBUSTER] = new ByteReanimDescriptor((Type.createInstance(REANIM_GRAVEBUSTER_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_HAMMER] = new ByteReanimDescriptor((Type.createInstance(REANIM_HAMMER_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_LAWNMOWER] = new ByteReanimDescriptor((Type.createInstance(REANIM_LAWNMOWER_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_LAWNMOWEREDZOMBIE] = new ByteReanimDescriptor((Type.createInstance(REANIM_LAWNMOWEREDZOMBIE_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_LEFTPEATER] = new ByteReanimDescriptor((Type.createInstance(REANIM_LEFTPEATER_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_LOADBAR_SPROUT] = new ByteReanimDescriptor((Type.createInstance(REANIM_LOADBAR_SPROUT_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_LOADBAR_ZOMBIEHEAD] = new ByteReanimDescriptor((Type.createInstance(REANIM_LOADBAR_ZOMBIEHEAD_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_PEASHOOTER] = new ByteReanimDescriptor((Type.createInstance(REANIM_PEASHOOTER_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_PEASHOOTERSINGLE] = new ByteReanimDescriptor((Type.createInstance(REANIM_PEASHOOTERSINGLE_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_PUFFSHROOM] = new ByteReanimDescriptor((Type.createInstance(REANIM_PUFFSHROOM_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_SELECTORSCREEN] = new ByteReanimDescriptor((Type.createInstance(REANIM_SELECTORSCREEN_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_SNOWPEA] = new ByteReanimDescriptor((Type.createInstance(REANIM_SNOWPEA_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_SODROLL] = new ByteReanimDescriptor((Type.createInstance(REANIM_SODROLL_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_SQUASH] = new ByteReanimDescriptor((Type.createInstance(REANIM_SQUASH_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_SUN] = new ByteReanimDescriptor((Type.createInstance(REANIM_SUN_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_SUNFLOWER] = new ByteReanimDescriptor((Type.createInstance(REANIM_SUNFLOWER_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_SUNSHROOM] = new ByteReanimDescriptor((Type.createInstance(REANIM_SUNSHROOM_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_WALLNUT] = new ByteReanimDescriptor((Type.createInstance(REANIM_WALLNUT_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_ZOMBIE] = new ByteReanimDescriptor((Type.createInstance(REANIM_ZOMBIE_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_ZOMBIE_CHARRED] = new ByteReanimDescriptor((Type.createInstance(REANIM_ZOMBIE_CHARRED_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_ZOMBIE_FOOTBALL] = new ByteReanimDescriptor((Type.createInstance(REANIM_ZOMBIE_FOOTBALL_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_ZOMBIE_HAND] = new ByteReanimDescriptor((Type.createInstance(REANIM_ZOMBIE_HAND_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_ZOMBIE_PAPER] = new ByteReanimDescriptor((Type.createInstance(REANIM_ZOMBIE_PAPER_CLASS, []) : ByteArray) );
         param1[PVZReanims.REANIM_ZOMBIE_POLEVAULTER] = new ByteReanimDescriptor((Type.createInstance(REANIM_ZOMBIE_POLEVAULTER_CLASS, []) : ByteArray) );
      }
   }

