package com.popcap.flash.games.pvz.states.playing
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.AwardScreen;
   
    class ShowAwardState implements IState
   {
       
      
      var app:PVZApp;
      
      public function new(app:PVZApp)
      {
         //super();
         this.app = app;
      }
      
      public function onEnter() 
      {
         this.app.mAwardScreen = new AwardScreen(this.app);
         this.app.widgetManager.addWidget(this.app.mAwardScreen);
         this.app.widgetManager.setFocus(this.app.mAwardScreen);
         this.app.musicManager.playMusic(PVZMusic.ZENGARDEN);
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
         this.app.widgetManager.removeAllWidgets(true);
         this.app.mAwardScreen = null;
      }
      
      public function update() 
      {
         this.app.widgetManager.updateFrame();
         if(this.app.mAwardScreen.mFadedIn)
         {
            this.app.widgetManager.addWidget(this.app.mAwardScreen.mStartButton);
         }
      }
      
      public function onPop() 
      {
      }
   }

