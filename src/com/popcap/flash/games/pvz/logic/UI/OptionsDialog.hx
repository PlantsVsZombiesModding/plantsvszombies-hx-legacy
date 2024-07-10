package com.popcap.flash.games.pvz.logic.UI;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.widgets.CWidget;
import com.popcap.flash.framework.widgets.ui.CheckboxWidget;
import com.popcap.flash.framework.widgets.ui.IButtonListener;
import com.popcap.flash.framework.widgets.ui.ICheckboxListener;
import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import com.popcap.flash.games.pvz.resources.PVZImages;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.net.URLRequest;
import com.XMLC;

class OptionsDialog extends CWidget implements IButtonListener implements ICheckboxListener {
	public static inline final DIALOG_RESTART = 0;

	public static inline final DIALOG_MAINMENU = 1;

	public var mDialogHeader:String;

	var mOptionsButton:ImageInst;

	var Menu_MusicCheckBox:Int = 105;

	public var mMusicCheckBox:CheckboxWidget;

	public var mUpsellButton:ImageButtonWidget;

	public var app:PVZApp;

	public var mSeedChooserShowing:Bool = false;

	public var mShowingDialogBox:Bool = false;

	var Menu_Restart:Int = 100;

	public var mDialogMessage:String;

	public var mBackToGameButton:ImageButtonWidget;

	var Menu_BackToGame:Int = 103;

	var mBackdropImage:ImageInst;

	public var mBackToMainButton:ImageButtonWidget;

	public var mRestartButton:ImageButtonWidget;

	var mReturnToGameButton:ImageInst;

	var Menu_Upsell:Int = 101;

	public var mDialogOk:String;

	public var mIsSound:Bool = false;

	public var mSoundCheckBox:CheckboxWidget;

	var upsellXML:XMLC;

	public var mIsMusic:Bool = false;

	var Menu_SoundCheckBox:Int = 104;

	public var mBoard:Board;

	var Menu_BackToMain:Int = 102;

	var mURLRequest:URLRequest;

	public var mDialogBox:DialogBox;

	public var mDialogCancel:String;

	public function new(app:PVZApp, theBoard:Board) {
		super();
		var font:FontInst = null;
		var aString:String = null;
		// this.upsellXML = <data>DeluxeDownload</data>;
		// super();
		this.app = app;
		this.mBoard = theBoard;
		this.mURLRequest = new URLRequest(app.mUpsellLink);
		this.mDialogBox = new DialogBox(app, this.mBoard);
		this.mDialogBox.setVisible(false);
		this.mOptionsButton = app.imageManager.getImageInst(PVZImages.IMAGE_OPTIONS_STANDARDBUTTON);
		this.mReturnToGameButton = app.imageManager.getImageInst(PVZImages.IMAGE_OPTIONS_BACKTOGAMEBUTTON0);
		font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36GREENINSET);
		font.scale = 0.4;
		var hiliteFont = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36BRIGHTGREENINSET);
		hiliteFont.scale = 0.4;
		var aPoint = new Point(1, 1);
		this.mRestartButton = new ImageButtonWidget(this.Menu_Restart, this);
		aString = app.stringManager.translateString("[RESTART_LEVEL]");
		this.mRestartButton.mUpImage = this.MakeButtonImage(aString, font, this.mOptionsButton);
		this.mRestartButton.mOverImage = this.MakeButtonImage(aString, hiliteFont, this.mOptionsButton);
		this.mRestartButton.mDownImage = this.MakeButtonImage(aString, hiliteFont, this.mOptionsButton);
		this.mRestartButton.mDownOffset = aPoint;
		this.mRestartButton.mDisabledImage = this.MakeButtonImage(aString, font, this.mOptionsButton);
		this.mRestartButton.doFinger = true;
		this.mRestartButton.visible = true;
		this.mRestartButton.setDisabled(false);
		this.mRestartButton.resize(182, 200, 156, 31);
		font.scale = 0.4;
		hiliteFont.scale = 0.4;
		this.mUpsellButton = new ImageButtonWidget(this.Menu_Upsell, this);
		aString = app.stringManager.translateString("[TRY_FULL_VERSION_BUTTON]");
		this.mUpsellButton.mUpImage = this.MakeButtonImage(aString, font, this.mOptionsButton);
		this.mUpsellButton.mOverImage = this.MakeButtonImage(aString, hiliteFont, this.mOptionsButton);
		this.mUpsellButton.mDownImage = this.MakeButtonImage(aString, hiliteFont, this.mOptionsButton);
		this.mUpsellButton.mDownOffset = aPoint;
		this.mUpsellButton.mDisabledImage = this.MakeButtonImage(aString, font, this.mOptionsButton);
		this.mUpsellButton.doFinger = true;
		this.mUpsellButton.visible = true;
		this.mUpsellButton.setDisabled(false);
		this.mUpsellButton.resize(182, 232, 156, 31);
		font.scale = 0.4;
		hiliteFont.scale = 0.4;
		this.mBackToMainButton = new ImageButtonWidget(this.Menu_BackToMain, this);
		aString = app.stringManager.translateString("[MAIN_MENU_BUTTON]");
		this.mBackToMainButton.mUpImage = this.MakeButtonImage(aString, font, this.mOptionsButton);
		this.mBackToMainButton.mOverImage = this.MakeButtonImage(aString, hiliteFont, this.mOptionsButton);
		this.mBackToMainButton.mDownImage = this.MakeButtonImage(aString, hiliteFont, this.mOptionsButton);
		this.mBackToMainButton.mDownOffset = aPoint;
		this.mBackToMainButton.mDisabledImage = this.MakeButtonImage(aString, font, this.mOptionsButton);
		this.mBackToMainButton.doFinger = true;
		this.mBackToMainButton.visible = true;
		this.mBackToMainButton.setDisabled(false);
		this.mBackToMainButton.resize(182, 264, 156, 31);
		this.mBackToGameButton = new ImageButtonWidget(this.Menu_BackToGame, this);
		aString = app.stringManager.translateString("[BACK_TO_GAME]");
		font.scale = 0.6;
		hiliteFont.scale = 0.6;
		this.mBackToGameButton.mUpImage = this.MakeButtonImage(aString, font, this.mReturnToGameButton);
		this.mBackToGameButton.mOverImage = this.MakeButtonImage(aString, hiliteFont, this.mReturnToGameButton);
		this.mBackToGameButton.mDownImage = this.MakeButtonImage(aString, hiliteFont, this.mReturnToGameButton);
		this.mBackToGameButton.mDownOffset = aPoint;
		this.mBackToGameButton.mDisabledImage = this.MakeButtonImage(aString, font, this.mReturnToGameButton);
		this.mBackToGameButton.doFinger = true;
		this.mBackToGameButton.visible = true;
		this.mBackToGameButton.setDisabled(false);
		this.mBackToGameButton.resize(132, 305, 243, 68);
		if (app.mSeedChooserScreen != null) {
			this.mRestartButton.visible = false;
		}
		this.mBackdropImage = app.imageManager.getImageInst(PVZImages.IMAGE_OPTIONS_MENUBACK);
		var emptyCheckbox = app.imageManager.getImageInst(PVZImages.IMAGE_OPTIONS_CHECKBOX0);
		var checkbox = app.imageManager.getImageInst(PVZImages.IMAGE_OPTIONS_CHECKBOX1);
		this.mSoundCheckBox = new CheckboxWidget(this.Menu_SoundCheckBox, checkbox, emptyCheckbox, this);
		this.mSoundCheckBox.resize(320, 140, 28, 26);
		this.mIsSound = false;
		this.mIsMusic = false;
		if (!app.soundManager.isMuted()) {
			this.mIsSound = true;
			this.mSoundCheckBox.setChecked(true, false);
		}
		this.mMusicCheckBox = new CheckboxWidget(this.Menu_MusicCheckBox, checkbox, emptyCheckbox, this);
		if (!app.musicManager.isMuted()) {
			this.mIsMusic = true;
			this.mMusicCheckBox.setChecked(true, false);
		}
		this.mMusicCheckBox.resize(320, 170, 28, 26);
	}

	public function buttonMouseMove(id:Float, x:Float, y:Float) {}

	public function buttonMouseEnter(id:Float) {}

	public function KillDialogBox() {
		this.mDialogBox.setVisible(false);
		this.mDialogBox.KillButtons();
		this.mRestartButton.setDisabled(false);
		this.mBackToGameButton.setDisabled(false);
		this.mBackToMainButton.setDisabled(false);
		this.mUpsellButton.setDisabled(false);
	}

	public function buttonMouseLeave(id:Float) {}

	public function buttonPress(id:Float) {}

	public function PickDialogType(theType:Int) {
		switch (theType) {
			case DIALOG_RESTART:
				if (this.app.IsAdventureMode()) {
					this.mDialogHeader = this.app.stringManager.translateString("[RESTART_LEVEL_HEADER]");
					this.mDialogMessage = this.app.stringManager.translateString("[RESTART_LEVEL_BODY]");
					this.mDialogOk = this.app.stringManager.translateString("[RESTART_BUTTON]");
					this.mDialogCancel = this.app.stringManager.translateString("[DIALOG_BUTTON_CANCEL]");
				} else if (this.app.IsSurvivalMode()) {
					this.mDialogHeader = this.app.stringManager.translateString("[RESTART_LEVEL_HEADER]");
					this.mDialogMessage = this.app.stringManager.translateString("[RESTART_LEVEL_BODY]");
					this.mDialogOk = this.app.stringManager.translateString("[RESTART_BUTTON]");
					this.mDialogCancel = this.app.stringManager.translateString("[DIALOG_BUTTON_CANCEL]");
				} else if (this.app.IsScaryPotterLevel()) {
					this.mDialogHeader = this.app.stringManager.translateString("[RESTART_PUZZLE_HEADER]");
					this.mDialogMessage = this.app.stringManager.translateString("[RESTART_PUZZLE_BODY]");
					this.mDialogOk = this.app.stringManager.translateString("[RESTART_BUTTON]");
					this.mDialogCancel = this.app.stringManager.translateString("[DIALOG_BUTTON_CANCEL]");
				}
			case DIALOG_MAINMENU:
				this.mDialogHeader = this.app.stringManager.translateString("[RETURN_MAIN_HEADER]");
				this.mDialogMessage = this.app.stringManager.translateString("[RETURN_MAIN_BODY]");
				this.mDialogOk = this.app.stringManager.translateString("[LEAVE_BUTTON]");
				this.mDialogCancel = this.app.stringManager.translateString("[DIALOG_BUTTON_CANCEL]");
		}
	}

	override public function draw(g:Graphics2D) {
		g.drawImage(this.mBackdropImage, 120, 50);
		var aMusicOffset = 0;
		var aSoundFXOffset = 0;
		var a3DAccelOffset = 0;
		var aFullScreenOffset = 0;
		var aFont = this.app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18);
		aFont.setColor(1, 107 / 255, 109 / 255, 145 / 255);
		var aString = this.app.stringManager.translateString("[SOUND_CHECKBOX]");
		g.pushState();
		g.setFont(aFont);
		g.drawString(aString, 200, 135);
		aString = this.app.stringManager.translateString("[MUSIC_CHECKBOX]");
		g.drawString(aString, 200, 165);
		g.popState();
	}

	public function buttonDownTick(id:Float) {}

	public function MakeButtonImage(theText:String, theFont:FontInst, theImage:ImageInst):ImageInst {
		var w = theImage.width;
		var h = theImage.height;
		var aBufferedImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = aBufferedImage.graphics;
		bufferG.drawImage(theImage, 0, 0);
		while (theFont.stringImageWidth(theText) > theImage.width) {
			theFont.scale -= 0.1;
		}
		bufferG.setFont(theFont);
		var offsetX = (theImage.width - theFont.stringImageWidth(theText)) / 2;
		var offsetY = (theImage.height - theFont.getHeight() - 5) / 2;
		bufferG.drawString(theText, offsetX, offsetY);
		return aBufferedImage;
	}

	override public function onKeyUp(keyCode:UInt) {
		if (keyCode == 32) {
			this.mBoard.onKeyUp(keyCode);
		}
	}

	override public function update() {}

	public function checkboxChecked(id:Float, checked:Bool) {
		switch (id) {
			case(_ == this.Menu_SoundCheckBox => true):
				this.mIsSound = checked;
			case(_ == this.Menu_MusicCheckBox => true):
				this.mIsMusic = checked;

			default:
		}
	}

	public function buttonRelease(id:Float) {
		switch (id) {
			case(_ == this.Menu_BackToGame => true):
				this.mBoard.mPaused = false;
				this.app.stateManager.changeState(PVZApp.STATE_PLAY_LEVEL);
			case(_ == this.Menu_BackToMain => true):
				if (this.app.mSeedChooserScreen != null) {
					this.app.stateManager.popState();
					this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
				} else {
					this.PickDialogType(DIALOG_MAINMENU);
					this.mDialogBox.mDialogType = DIALOG_MAINMENU;
					this.mDialogBox.resize(255 - 63 * 2, 130 - 36 * 2, 153 + 63 * 2, 184 + 36 * 2);
					this.mDialogBox.InitializeDialogBox(this.mDialogHeader, this.mDialogMessage, this.mDialogOk, this.mDialogCancel, 2, 2);
					this.mDialogBox.setVisible(true);
					this.mRestartButton.setDisabled(true);
					this.mBackToGameButton.setDisabled(true);

					this.mBackToMainButton.setDisabled(true);
					this.mUpsellButton.setDisabled(true);
				}
			case(_ == this.Menu_Restart => true):
				this.PickDialogType(DIALOG_RESTART);
				this.mDialogBox.mDialogType = DIALOG_RESTART;
				this.mDialogBox.resize(255 - 63 * 2, 130 - 36 * 2, 153 + 63 * 2, 184 + 36 * 2);
				this.mDialogBox.InitializeDialogBox(this.mDialogHeader, this.mDialogMessage, this.mDialogOk, this.mDialogCancel, 2, 2);
				this.mDialogBox.setVisible(true);
				this.mRestartButton.setDisabled(true);

				this.mBackToGameButton.setDisabled(true);
				this.mBackToMainButton.setDisabled(true);
				this.mUpsellButton.setDisabled(true);
			case(_ == this.Menu_Upsell => true):
				this.app.adAPI.CustomEvent(this.upsellXML, this.DoUpsell);
				if (!this.app.adAPI.enabled) {
					flash.Lib.getURL(this.mURLRequest);
				}
			default:
		}
	}

	public function DoUpsell() {}
}
