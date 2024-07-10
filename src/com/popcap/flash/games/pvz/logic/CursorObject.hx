package com.popcap.flash.games.pvz.logic
;
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
    class CursorObject extends GameObject
   {
      
      public static inline final SEED_EXPLODE_O_NUT= 50;
      
      static inline final CURSOR_TYPE_PLANT_FROM_BANK= 1;
      
      public static inline final SEED_PUFFSHROOM= 8;
      
      static inline final CURSOR_TYPE_NORMAL= 0;
      
      static inline final SEED_NONE= -1;
      
      static inline final SEED_CHERRYBOMB= 2;
      
      static inline final SEED_SQUASH= 4;
      
      static inline final SEED_PEASHOOTER= 0;
      
      static inline final CURSOR_TYPE_HAMMER= 4;
      
      static inline final SEED_CHOMPER= 6;
      
      public static inline final SEED_SUNSHROOM= 9;
      
      static inline final SEED_REPEATER= 7;
      
      static inline final STATE_HOLDING_SEED= "holding seed";
      
      static inline final CURSOR_TYPE_SHOVEL= 3;
      
      static inline final SEED_WALLNUT= 3;
      
      public static inline final SEED_FUMESHROOM= 10;
      
      static inline final CURSOR_TYPE_PLANT_FROM_USABLE_COIN= 2;
      
      static inline final STATE_EMPTY= "empty";
      
      public static inline final SEED_LEFTPEATER= 49;
      
      static inline final VARIATION_NORMAL= "normal";
      
      public static inline final SEED_GRAVEBUSTER= 11;
      
      static inline final SEED_SUNFLOWER= 1;
      
      static inline final SEED_SNOWPEA= 5;
       
      
      public var mCursorType:Int = 0;
      
      public var mType:Int = 0;
      
      var mShovelImage:ImageInst;
      
      var mSeedImages:Array<ASAny>;
      
      public var mSeedBankIndex:Int = 0;
      
      public var cursorState:String;
      
      public var mCoin:Coin;
      
      public function new(app:PVZApp, theBoard:Board)
      {
         super();
         this.mSeedImages = new Array<ASAny>();
         //super();
         this.mCoin = null;
         this.mCursorType = CURSOR_TYPE_NORMAL;
         this.cursorState = STATE_EMPTY;
         mBoard = theBoard;
         this.app = app;
         this.mShovelImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVEL_SMALL);
      }
      
      public function draw(g:Graphics2D) 
      {
         var anImg:ImageInst = null;
         var aOffsetX= Math.NaN;
         var aOffsetY= Math.NaN;
         if(this.mCursorType == CURSOR_TYPE_SHOVEL)
         {
            g.blitImage(this.mShovelImage,mX,mY - 41);
         }
         else if(this.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK || this.mCursorType == CURSOR_TYPE_PLANT_FROM_USABLE_COIN)
         {
            anImg = this.mSeedImages[this.mType];
            if(anImg == null)
            {
               anImg = this.GetPlantImage(this.mType);
            }
            aOffsetX = -anImg.width / 2;
            aOffsetY = -anImg.height / 2;
            g.drawImage(anImg,mX + aOffsetX,mY + aOffsetY);
         }
      }
      
      public function update() 
      {
         mVisible = true;
         mX = Std.int(app.widgetManager.lastMouseX);
         mY = Std.int(app.widgetManager.lastMouseY);
      }
      
      function GetPlantImage(theType:Int) : ImageInst
      {
         var aPlantImg:ImageInst = null;
         switch(theType)
         {
            case SEED_PEASHOOTER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTERSINGLE);
               
            case SEED_SUNFLOWER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNFLOWER);
               
            case SEED_CHERRYBOMB:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHERRYBOMB);
               
            case SEED_SQUASH:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SQUASH);
               
            case SEED_CHOMPER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHOMPER);
               
            case SEED_SNOWPEA:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SNOWPEA);
               
            case SEED_REPEATER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTER);
               
            case SEED_WALLNUT:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               
            case SEED_EXPLODE_O_NUT:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               aPlantImg.useColor = true;
               aPlantImg.setColor(1,1,64 / 255,64 / 255);
               
            case SEED_PUFFSHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM);
               
            case SEED_SUNSHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
               
            case SEED_FUMESHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
               
            case SEED_GRAVEBUSTER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
               
            case SEED_LEFTPEATER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_LEFTFACINGPEASHOOTER);
         }
         this.mSeedImages[theType] = aPlantImg;
         return aPlantImg;
      }
      
      function drawBufferedSeed(seedType:Float) : ImageInst
      {
         var aPlantReanimType= mBoard.GetPlantDefinition(Std.int(seedType));
         trace(aPlantReanimType);
         var aPlantReanim= app.reanimator.createReanimation(aPlantReanimType);
         switch(seedType)
         {
            case SEED_PEASHOOTER
               | SEED_REPEATER
               | SEED_SNOWPEA:
               aPlantReanim.currentTrack = "anim_full_idle";
               
            case SEED_WALLNUT:
               aPlantReanim.currentTrack = "anim_idle1";
               
            case SEED_EXPLODE_O_NUT:
               aPlantReanim.currentTrack = "anim_idle1";
               aPlantReanim.useColor = true;
               aPlantReanim.overrideColor = Color.RGB(1,64 / 255,64 / 255);
               
            case SEED_PUFFSHROOM:
               
            default:
               aPlantReanim.currentTrack = "anim_idle";
         }
         aPlantReanim.update();
         var aBounds= aPlantReanim.getBoundsForFrame();
         var aImage= new ImageInst(new ImageData(new BitmapData(Std.int(aBounds.width),Std.int(aBounds.height),true,0)));
         var bufferG= new Graphics2D(aImage.pixels);
         aPlantReanim.drawLerp(bufferG,new Matrix());
         this.mSeedImages[Std.int(seedType)] = aImage;
         return aImage;
      }
   }

