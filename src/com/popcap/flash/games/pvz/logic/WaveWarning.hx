package com.popcap.flash.games.pvz.logic
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.utils.Utils;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import flash.geom.Rectangle;
   
    class WaveWarning
   {
      
      static final FINAL_WAVE_GREEN:Float = 50 / 255;
      
      static inline final FINAL_FADE_OUT_TIME:Float = 12;
      
      static final HUGE_WAVE_BLUE:Float = 9 / 255;
      
      static inline final HUGE_FADE_OUT_TIME:Float = 12;
      
      static final FINAL_WAVE_BLUE:Float = 50 / 255;
      
      static final HUGE_WAVE_GREEN:Float = 9 / 255;
      
      static inline final FINAL_FADE_IN_TIME:Float = 50;
      
      static inline final HUGE_FADE_IN_TIME:Float = 18;
      
      static inline final FINAL_WAVE_RED:Float = 1;
      
      static final HUGE_WAVE_RED:Float = 246 / 255;
       
      
      var mFinalWaveTimer:Float = 0;
      
      var mHugeWaveDuration:Float = 0;
      
      var mFinalWaveScale:Float = 1;
      
      var mHugeWaveAlpha:Float = 1;
      
      var mScreenBounds:Rectangle;
      
      var mFinalWaveDuration:Float = 0;
      
      var mFinalWaveAlpha:Float = 1;
      
      var mHugeWaveText:ImageInst;
      
      var mHugeWaveBounds:Rectangle;
      
      var mFinalWaveText:ImageInst;
      
      var mHugeWaveTimer:Float = 0;
      
      var mHugeWaveScale:Float = 1;
      
      var mApp:PVZApp;
      
      var mFinalWaveBounds:Rectangle;
      
      public function new(app:PVZApp)
      {
         this.mHugeWaveBounds = new Rectangle();
         this.mFinalWaveBounds = new Rectangle();
         this.mScreenBounds = new Rectangle(0,0,540,405);
         //super();
         this.mApp = app;
         var hugeWaveString= this.mApp.stringManager.translateString("[ADVICE_HUGE_WAVE]");
         var finalWaveString= this.mApp.stringManager.translateString("[ADVICE_FINAL_WAVE]");
         var waveFont= this.mApp.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR28);
         this.mHugeWaveText = Utils.createStringImage(hugeWaveString,waveFont,this.mScreenBounds,Utils.JUSTIFY_CENTER);
         this.mHugeWaveText.useColor = true;
         this.mFinalWaveText = Utils.createStringImage(finalWaveString,waveFont,this.mScreenBounds,Utils.JUSTIFY_CENTER);
         this.mFinalWaveText.useColor = true;
      }
      
      public function draw(g:Graphics2D) 
      {
         if(this.mHugeWaveTimer > 0)
         {
            this.mHugeWaveBounds.x = this.mHugeWaveText.x;
            this.mHugeWaveBounds.y = this.mHugeWaveText.y;
            this.mHugeWaveBounds.width = this.mHugeWaveText.width * this.mHugeWaveScale;
            this.mHugeWaveBounds.height = this.mHugeWaveText.height * this.mHugeWaveScale;
            this.mHugeWaveText.setColor(this.mHugeWaveAlpha,HUGE_WAVE_RED,HUGE_WAVE_GREEN,HUGE_WAVE_BLUE);
            Utils.align(this.mHugeWaveBounds,this.mScreenBounds,Utils.ALIGN_CENTER,Utils.ALIGN_CENTER);
            g.pushState();
            g.scale(this.mHugeWaveScale,this.mHugeWaveScale);
            g.drawImage(this.mHugeWaveText,this.mHugeWaveBounds.x,this.mHugeWaveBounds.y);
            g.popState();
         }
         if(this.mFinalWaveTimer > 0)
         {
            this.mFinalWaveBounds.x = this.mFinalWaveText.x;
            this.mFinalWaveBounds.y = this.mFinalWaveText.y;
            this.mFinalWaveBounds.width = this.mFinalWaveText.width * this.mFinalWaveScale;
            this.mFinalWaveBounds.height = this.mFinalWaveText.height * this.mFinalWaveScale;
            Utils.align(this.mFinalWaveBounds,this.mScreenBounds,Utils.ALIGN_CENTER,Utils.ALIGN_CENTER);
            this.mFinalWaveText.setColor(this.mFinalWaveAlpha,FINAL_WAVE_RED,FINAL_WAVE_GREEN,FINAL_WAVE_BLUE);
            g.pushState();
            g.scale(this.mFinalWaveScale,this.mFinalWaveScale);
            g.drawImage(this.mFinalWaveText,this.mFinalWaveBounds.x,this.mFinalWaveBounds.y);
            g.popState();
         }
      }
      
      public function update() 
      {
         var range:Float = 0;
         var lower:Float = 0;
         var diff:Float = 0;
         if(this.mHugeWaveTimer == this.mHugeWaveDuration - HUGE_FADE_IN_TIME)
         {
            this.mApp.foleyManager.playFoley(PVZFoleyType.HUGEWAVE);
         }
         if(this.mHugeWaveTimer > this.mHugeWaveDuration - HUGE_FADE_IN_TIME)
         {
            lower = this.mHugeWaveDuration - HUGE_FADE_IN_TIME;
            range = this.mHugeWaveDuration - lower;
            diff = this.mHugeWaveTimer - lower;
            this.mHugeWaveAlpha = 1 - diff / range;
            this.mHugeWaveScale = 2.9 * (diff / range) + 1;
         }
         else if(this.mHugeWaveTimer > this.mHugeWaveDuration - HUGE_FADE_OUT_TIME)
         {
            this.mHugeWaveAlpha = 1;
            this.mHugeWaveScale = 1;
         }
         else
         {
            lower = 0;
            range = HUGE_FADE_OUT_TIME;
            diff = this.mHugeWaveTimer;
            this.mHugeWaveAlpha = diff / range;
            this.mHugeWaveScale = 1;
         }
         if(this.mHugeWaveTimer > 0)
         {
            --this.mHugeWaveTimer;
         }
         if(this.mFinalWaveTimer == this.mFinalWaveDuration - FINAL_FADE_IN_TIME)
         {
            this.mApp.foleyManager.playFoley(PVZFoleyType.FINALWAVE);
         }
         if(this.mFinalWaveTimer > this.mFinalWaveDuration - FINAL_FADE_IN_TIME)
         {
            lower = this.mFinalWaveDuration - FINAL_FADE_IN_TIME;
            range = this.mFinalWaveDuration - lower;
            diff = this.mFinalWaveTimer - lower;
            this.mFinalWaveAlpha = 1 - diff / range;
            this.mFinalWaveScale = 2.9 * (diff / range) + 1;
         }
         else if(this.mFinalWaveTimer > this.mFinalWaveDuration - FINAL_FADE_OUT_TIME)
         {
            this.mFinalWaveAlpha = 1;
            this.mFinalWaveScale = 1;
         }
         else
         {
            lower = 0;
            range = FINAL_FADE_OUT_TIME;
            diff = this.mFinalWaveTimer;
            this.mFinalWaveAlpha = diff / range;
            this.mFinalWaveScale = 1;
         }
         if(this.mFinalWaveTimer > 0)
         {
            --this.mFinalWaveTimer;
         }
      }
      
      public function showFinalWave(duration:Int) 
      {
         this.mFinalWaveDuration = duration;
         this.mFinalWaveTimer = duration;
      }
      
      public function showHugeWave(duration:Int) 
      {
         this.mHugeWaveDuration = duration;
         this.mHugeWaveTimer = duration;
      }
   }

