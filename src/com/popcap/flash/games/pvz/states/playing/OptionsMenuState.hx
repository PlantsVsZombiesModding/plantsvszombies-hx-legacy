package com.popcap.flash.games.pvz.states.playing
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.uI.OptionsDialog;
   
    class OptionsMenuState implements IState
   {
       
      
      var app:PVZApp;
      
      public function new(app:PVZApp)
      {
         //super();
         this.app = app;
      }
      
      public function onEnter() 
      {
         this.app.adAPI.pauseBroadcast();
         this.app.mBoard.mMenuButton.disabled = true;
         if(this.app.mOptionsMenu == null)
         {
            this.app.mOptionsMenu = new OptionsDialog(this.app,this.app.mBoard);
         }
         this.app.widgetManager.addWidget(this.app.mOptionsMenu);
         this.app.widgetManager.setFocus(this.app.mOptionsMenu);
         this.app.widgetManager.addWidget(this.app.mOptionsMenu.mRestartButton);
         this.app.widgetManager.addWidget(this.app.mOptionsMenu.mUpsellButton);
         this.app.widgetManager.addWidget(this.app.mOptionsMenu.mBackToGameButton);
         this.app.widgetManager.addWidget(this.app.mOptionsMenu.mBackToMainButton);
         this.app.widgetManager.addWidget(this.app.mOptionsMenu.mSoundCheckBox);
         this.app.widgetManager.addWidget(this.app.mOptionsMenu.mMusicCheckBox);
         this.app.widgetManager.addWidget(this.app.mOptionsMenu.mDialogBox);
         this.app.widgetManager.addWidget(this.app.mOptionsMenu.mDialogBox.mOkButton);
         this.app.widgetManager.addWidget(this.app.mOptionsMenu.mDialogBox.mCancelButton);
         this.app.soundManager.pauseAll();
         this.app.musicManager.pauseMusic();
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
         if(this.app.mOptionsMenu.mIsSound)
         {
            this.app.soundManager.unmute();
            this.app.mSaveObject.soundOn = true;
         }
         else
         {
            this.app.soundManager.mute();
            this.app.mSaveObject.soundOn = false;
         }
         if(this.app.mOptionsMenu.mIsMusic)
         {
            this.app.musicManager.unmute();
            this.app.mSaveObject.musicOn = true;
         }
         else
         {
            this.app.musicManager.mute();
            this.app.mSaveObject.musicOn = false;
         }
         this.app.setSaveData(this.app.mSaveObject);
         this.app.soundManager.resumeAll();
         this.app.musicManager.resumeMusic();
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu);
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu.mRestartButton);
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu.mUpsellButton);
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu.mBackToGameButton);
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu.mBackToMainButton);
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu.mSoundCheckBox);
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu.mMusicCheckBox);
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu.mDialogBox);
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu.mDialogBox.mOkButton);
         this.app.widgetManager.removeWidget(this.app.mOptionsMenu.mDialogBox.mCancelButton);
         this.app.mBoard.mMenuButton.disabled = false;
         this.app.widgetManager.setFocus(this.app.mBoard);
         this.app.mOptionsMenu = null;
         this.app.adAPI.resumeBroadcast();
      }
      
      public function update() 
      {
         this.app.widgetManager.updateFrame();
      }
      
      public function onPop() 
      {
         this.app.soundManager.pauseAll();
         this.app.musicManager.pauseMusic();
      }
   }

