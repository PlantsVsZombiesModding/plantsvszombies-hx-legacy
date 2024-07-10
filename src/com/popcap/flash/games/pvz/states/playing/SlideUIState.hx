package com.popcap.flash.games.pvz.states.playing
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.LawnMower;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   
    class SlideUIState implements IState
   {
      
      public static inline final TimeSeedBankOnStart= 0;
      
      public static inline final TimeSeedBankOnEnd= 500;
      
      public static final TimeLawnMowerStart:Array<ASAny> = [TimeSeedBankOnEnd + 200,TimeSeedBankOnEnd + 150,TimeSeedBankOnEnd + 100,TimeSeedBankOnEnd + 50,TimeSeedBankOnEnd];
      
      public static inline final TimeLawnMowerDuration= 250;
       
      
      var app:PVZApp;
      
      public function new(app:PVZApp)
      {
         //super();
         this.app = app;
      }
      
      public function onEnter() 
      {
         this.app.mCutsceneTime = 0;
         if(!this.app.mBoard.ChooseSeedsOnCurrentLevel())
         {
            this.app.mBoard.mSeedBank.Move(0,-78);
            this.app.mBoard.mSeedBank.mVisible = true;
         }
         else
         {
            this.app.mCutsceneTime = TimeSeedBankOnStart;
         }
         if(this.app.IsScaryPotterLevel() || this.app.mBoard.mChallenge.mSurvivalStage > 0)
         {
            this.app.stateManager.changeState(PVZApp.STATE_START_LEVEL);
         }
      }
      
      public function draw(g:Graphics2D) 
      {
         this.app.widgetManager.drawScreen(g);
      }
      
      public function onPush() 
      {
      }
      
      public function onExit() 
      {
      }
      
      public function update() 
      {
         var y= 0;
         var aTimeMowerStart= 0;
         var aTimeMowerEnd= 0;
         var aLawnMower:LawnMower = null;
         var x= 0;
         this.app.widgetManager.updateFrame();
         this.app.mCutsceneTime += 10;
         if(this.app.mCutsceneTime > TimeSeedBankOnStart && this.app.mCutsceneTime <= TimeSeedBankOnEnd)
         {
            if(!this.app.mBoard.ChooseSeedsOnCurrentLevel())
            {
               y = TodCommon.TodAnimateCurve(TimeSeedBankOnStart,TimeSeedBankOnEnd,this.app.mCutsceneTime,-78,0,TodCommon.CURVE_EASE_IN_OUT);
               this.app.mBoard.mSeedBank.Move(0,y);
            }
         }
         for(i in 0...Board.GRIDSIZEY)
         {
            aTimeMowerStart = ASCompat.toInt(TimeLawnMowerStart[i]);
            aTimeMowerEnd = aTimeMowerStart + TimeLawnMowerDuration;
            if(this.app.mCutsceneTime > aTimeMowerStart)
            {
               aLawnMower = this.app.mBoard.FindLawnMowerInRow(i);
               if(aLawnMower != null)
               {
                  aLawnMower.mVisible = true;
                  x = TodCommon.TodAnimateCurve(aTimeMowerStart,aTimeMowerEnd,this.app.mCutsceneTime,-54,-25,TodCommon.CURVE_EASE_IN_OUT);
                  aLawnMower.mPosX = x;
               }
            }
         }
         var endTime:Int = TimeSeedBankOnEnd + TimeLawnMowerStart[1] + TimeLawnMowerDuration;
         if(this.app.mCutsceneTime >= endTime)
         {
            if(this.app.IsSurvivalMode() || this.app.mLevel == 1 || this.app.mLevel == 5)
            {
               this.app.stateManager.changeState(PVZApp.STATE_START_LEVEL);
            }
            else
            {
               this.app.stateManager.changeState(PVZApp.STATE_READY_SET_START);
            }
         }
      }
      
      public function onPop() 
      {
      }
   }

