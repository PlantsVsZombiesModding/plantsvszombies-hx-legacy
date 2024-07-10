package com.popcap.flash.games.pvz.states.playing
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.uI.UpsellScreen;
   
    class UpsellScreenState implements IState
   {
       
      
      var app:PVZApp;
      
      public function new(app:PVZApp)
      {
         //super();
         this.app = app;
      }
      
      public function onEnter() 
      {
         if(this.app.IsAdventureMode())
         {
            this.app.mUpsellScreen = new UpsellScreen(this.app,UpsellScreen.ADVENTURE);
         }
         else if(this.app.IsSurvivalMode())
         {
            this.app.mUpsellScreen = new UpsellScreen(this.app,UpsellScreen.SURVIVAL);
         }
         else if(this.app.IsScaryPotterLevel())
         {
            this.app.mUpsellScreen = new UpsellScreen(this.app,UpsellScreen.PUZZLE);
         }
         else
         {
            this.app.mUpsellScreen = new UpsellScreen(this.app,UpsellScreen.MINIGAME);
         }
         this.app.widgetManager.addWidget(this.app.mUpsellScreen);
         this.app.widgetManager.setFocus(this.app.mUpsellScreen);
         this.app.widgetManager.addWidget(this.app.mUpsellScreen.mBackToGameButton);
         this.app.widgetManager.addWidget(this.app.mUpsellScreen.mUpsellButton);
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
         this.app.widgetManager.removeWidget(this.app.mUpsellScreen);
         this.app.widgetManager.removeWidget(this.app.mUpsellScreen.mBackToGameButton);
         this.app.widgetManager.removeWidget(this.app.mUpsellScreen.mUpsellButton);
         this.app.mUpsellScreen = null;
      }
      
      public function update() 
      {
         this.app.widgetManager.updateFrame();
      }
      
      public function onPop() 
      {
      }
   }

