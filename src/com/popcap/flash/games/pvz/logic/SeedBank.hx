package com.popcap.flash.games.pvz.logic
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.utils.Utils;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import flash.geom.Rectangle;
   
    class SeedBank extends GameObject
   {
      
      static inline final CURSOR_TYPE_PLANT_FROM_BANK= 1;
      
      public static inline final SEED_PUFFSHROOM= 8;
      
      static inline final OBJECT_TYPE_PLANT= 1;
      
      static inline final CURSOR_TYPE_HAMMER= 4;
      
      public static inline final SEED_SUNSHROOM= 9;
      
      public static inline final CONVEYOR_PACKET_OFFSET_X= 48;
      
      static inline final CURSOR_TYPE_PLANT_FROM_USABLE_COIN= 2;
      
      static inline final OBJECT_TYPE_PROJECTILE= 2;
      
      public static inline final SEED_REPEATER= 7;
      
      static inline final OBJECT_TYPE_NONE= 0;
      
      static inline final CURSOR_TYPE_NORMAL= 0;
      
      public static inline final SEED_WALLNUT= 3;
      
      public static inline final SEED_FUMESHROOM= 10;
      
      public static inline final SEED_PEASHOOTER= 0;
      
      public static inline final SEED_EXPLODE_O_NUT= 50;
      
      public static inline final SEEDBANK_MAX= 10;
      
      static inline final CONVEYOR_SPEED= 4;
      
      public static inline final SEED_SUNFLOWER= 1;
      
      public static inline final SEED_SNOWPEA= 5;
      
      static inline final OBJECT_TYPE_SHOVEL= 5;
      
      public static inline final SEED_CHERRYBOMB= 2;
      
      public static inline final SEED_CHOMPER= 6;
      
      public static inline final SEED_SQUASH= 4;
      
      static inline final OBJECT_TYPE_SEEDPACKET= 4;
      
      static inline final CURSOR_TYPE_SHOVEL= 3;
      
      public static inline final CONVEYOR_PACKET_MIN_OFFSET= 40;
      
      public static inline final SEED_NONE= -1;
      
      public static inline final SEED_LEFTPEATER= 49;
      
      static inline final OBJECT_TYPE_COIN= 3;
      
      public static inline final SEED_GRAVEBUSTER= 11;
       
      
      var mConveyorBeltCounter:Int = 0;
      
      public var mSeedBankFont:FontInst;
      
      public var mSunText:ImageInst;
      
      public var mSeedPackets:Array<ASAny>;
      
      public var mSunRenderable:StringRenderable;
      
      public var mSunBounds:Rectangle;
      
      var mCutSceneDarken:Int = 0;
      
      public var mNumPackets:Int = 0;
      
      public function new(app:PVZApp, theBoard:Board)
      {
         super();
         this.mSeedPackets = new Array<ASAny>();
         this.mSunBounds = new Rectangle(11,59,40,15);
         //super();
         this.mSeedBankFont = app.fontManager.getFontInst(PVZFonts.FONT_CONTINUUMBOLD14);
         this.mSeedBankFont.scale = 0.8;
         mBoard = theBoard;
         this.app = app;
         if(mBoard.HasConveyorBeltSeedBank())
         {
            mWidth = 387;
         }
         else
         {
            mWidth = 401;
         }
         mHeight = 78;
         this.mNumPackets = 6;
         this.mCutSceneDarken = 255;
         this.mConveyorBeltCounter = 0;
         mVisible = true;
         var bounds= new Rectangle(0,0,40,15);
         this.mSunText = Utils.createStringImage(Std.string(mBoard.mSunMoney),this.mSeedBankFont,bounds,Utils.JUSTIFY_CENTER);
         this.mSunText.useColor = true;
         this.mSunText.setColor(1,0,0,0);
      }
      
      public function MouseHitTest(x:Int, y:Int, theHitResult:HitResult) : Bool
      {
         var aSeedPacket:SeedPacket = null;
         var i= 0;while(i < this.mNumPackets)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.MouseHitTest(x - mX,y - mY,theHitResult))
            {
               return true;
            }
i++;
         }
         theHitResult.mObject = null;
         theHitResult.mObjectType = OBJECT_TYPE_NONE;
         return false;
      }
      
      public function AddSeed(theSeedType:Int, thePlaceOnLeft:Bool) 
      {
         var aSeedPacket:SeedPacket = null;
         var aPrevSeedPacket:SeedPacket = null;
         var aNextIndex= this.GetNumSeedsOnConveyorBelt();
         if(aNextIndex == this.mNumPackets)
         {
            return;
         }
         aSeedPacket = this.mSeedPackets[aNextIndex];
         aSeedPacket.mUpdateImage = true;
         aSeedPacket.mPacketType = theSeedType;
         aSeedPacket.mRefreshCounter = 0;
         aSeedPacket.mRefreshTime = 0;
         aSeedPacket.mRefreshing = false;
         aSeedPacket.mActive = true;
         aSeedPacket.mOffsetX = 380 - CONVEYOR_PACKET_OFFSET_X * aNextIndex;
         if(thePlaceOnLeft)
         {
            aSeedPacket.mOffsetX = 0;
         }
         if(aNextIndex > 0)
         {
            aPrevSeedPacket = this.mSeedPackets[aNextIndex - 1];
            if(aSeedPacket.mOffsetX < aPrevSeedPacket.mOffsetX)
            {
               aSeedPacket.mOffsetX = aPrevSeedPacket.mOffsetX + CONVEYOR_PACKET_MIN_OFFSET;
            }
         }
         this.mSeedPackets[aNextIndex];
      }
      
      public function Draw(g:Graphics2D) 
      {
         var aImage:ImageInst = null;
         var aFrame= 0;
         var aSeedPacket:SeedPacket = null;
         var aCenterX= Math.NaN;
         var aCenterY= Math.NaN;
         var aPosX= Math.NaN;
         var aPosY= Math.NaN;
         if(!mVisible)
         {
            return;
         }
         g.pushState();
         g.translate(-mBoard.x,-mBoard.y);
         g.translate(mX,mY);
         aImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBANK);
         if(mBoard.HasConveyorBeltSeedBank())
         {
            aImage = app.imageManager.getImageInst(PVZImages.IMAGE_CONVEYORBELT_BACKDROP);
            g.drawImage(aImage,0,0);
            aFrame = Std.int(this.mConveyorBeltCounter / CONVEYOR_SPEED % 6);
            aImage = app.imageManager.getImageInst(PVZImages.IMAGE_CONVEYORBELT);
            aImage.frame = aFrame;
            g.drawImage(aImage,5,56);
         }
         else
         {
            aImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBANK);
            g.drawImage(aImage,0,0);
         }
         var i= 0;while(i < this.mNumPackets)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.mPacketType != SEED_NONE)
            {
               aSeedPacket.Draw(g);
            }
i++;
         }
         if(!mBoard.HasConveyorBeltSeedBank() && this.mVisible)
         {
            this.mSunText.setColor(1,0,0,0);
            this.mSunText.useColor = true;
            if(mBoard.mOutOfMoneyCounter > 0)
            {
               if(mBoard.mOutOfMoneyCounter % 20 < 10)
               {
                  this.mSunText.setColor(1,1,0,0);
               }
            }
            aCenterX = this.mSunBounds.x + this.mSunBounds.width / 2;
            aCenterY = this.mSunBounds.y + this.mSunBounds.height / 2;
            aPosX = aCenterX - this.mSunText.width / 2;
            aPosY = aCenterY - this.mSunText.height / 2;
            g.drawImage(this.mSunText,aPosX,aPosY);
         }
         g.popState();
      }
      
      public function GetNumSeedsOnConveyorBelt() : Int
      {
         var aSeedPacket:SeedPacket = null;
         var i= 0;while(i < this.mNumPackets)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.mPacketType == SEED_NONE)
            {
               return i;
            }
i++;
         }
         return this.mNumPackets;
      }
      
      public function Move(x:Int, y:Int) 
      {
         mX = x;
         mY = y;
      }
      
      public function CountOfTypeOnConveyorBelt(aSeedType:Int) : Int
      {
         var aSeedPacket:SeedPacket = null;
         var aCount= 0;
         var i= 0;while(i < this.mNumPackets)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.mPacketType == aSeedType)
            {
               aCount++;
            }
i++;
         }
         return aCount;
      }
      
      public function RemoveSeed(theIndex:Int) 
      {
         var aSeedPacket:SeedPacket = null;
         var aNextSeedPacket:SeedPacket = null;
         var i= theIndex;while(i < this.mNumPackets)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.mPacketType == SEED_NONE)
            {
               break;
            }
            if(i == this.mNumPackets - 1)
            {
               aSeedPacket.mPacketType = SEED_NONE;
               aSeedPacket.mOffsetX = 0;
            }
            else
            {
               aNextSeedPacket = this.mSeedPackets[i + 1];
               aSeedPacket.mPacketType = aNextSeedPacket.mPacketType;
               aSeedPacket.mOffsetX = aNextSeedPacket.mOffsetX + CONVEYOR_PACKET_OFFSET_X;
            }
            aSeedPacket.mUpdateImage = true;
            aSeedPacket.mRefreshCounter = 0;
            aSeedPacket.mRefreshTime = 0;
            aSeedPacket.mRefreshing = false;
            aSeedPacket.mActive = true;
i++;
         }
      }
      
      public function UpdateConveyorBelt() 
      {
         var i= 0;
         var aSeedPacket:SeedPacket = null;
         ++this.mConveyorBeltCounter;
         if(this.mConveyorBeltCounter % CONVEYOR_SPEED == 0)
         {
            var i :ASAny= 0;while(i < this.mNumPackets)
            {
               aSeedPacket = this.mSeedPackets[i];
               if(aSeedPacket.mOffsetX > 0)
               {
                  aSeedPacket.mOffsetX = Std.int(Math.max(aSeedPacket.mOffsetX - 1,0));
               }
i++;
            }
         }
      }
   }

