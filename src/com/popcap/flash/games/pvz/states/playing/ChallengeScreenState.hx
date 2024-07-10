package com.popcap.flash.games.pvz.states.playing
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.ChallengeScreen;
   
    class ChallengeScreenState implements IState
   {
       
      
      var app:PVZApp;
      
      public function new(app:PVZApp)
      {
         //super();
         this.app = app;
      }
      
      public function onEnter() 
      {
         this.app.mChallengeScreen = new ChallengeScreen(this.app,this.app.mBoard);
         this.app.widgetManager.addWidget(this.app.mChallengeScreen);
         this.app.widgetManager.setFocus(this.app.mChallengeScreen);
         this.app.widgetManager.addWidget(this.app.mChallengeScreen.mStartButton);
         this.app.widgetManager.addWidget(this.app.mChallengeScreen.mBackToMenuButton);
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
         this.app.widgetManager.removeWidget(this.app.mChallengeScreen);
         this.app.widgetManager.removeWidget(this.app.mChallengeScreen.mStartButton);
         this.app.widgetManager.removeWidget(this.app.mChallengeScreen.mBackToMenuButton);
         this.app.mChallengeScreen = null;
      }
      
      public function update() 
      {
         this.app.widgetManager.updateFrame();
      }
      
      public function onPop() 
      {
      }
   }

