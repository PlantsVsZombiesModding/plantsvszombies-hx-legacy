package com.popcap.flash.games.pvz.logic.UI;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.widgets.CWidget;
import com.popcap.flash.framework.widgets.ui.CButtonWidget;
import com.popcap.flash.framework.widgets.ui.IButtonListener;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.renderables.StringRenderable;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import com.popcap.flash.games.pvz.resources.PVZImages;
import flash.net.URLRequest;
import com.XMLC;

class UpsellScreen extends CWidget implements IButtonListener {
	public static inline final ADVENTURE = 0;

	public static inline final PUZZLE = 1;

	public static inline final MINIGAME = 3;

	public static inline final SURVIVAL = 2;

	var mBackToGameButtonText:StringRenderable;

	public var mUpsellButton:CButtonWidget;

	var mTitleDescription:StringRenderable;

	var mHeader1:StringRenderable;

	var mHeader2:StringRenderable;

	var mBackgroundImage:ImageInst;

	public var app:PVZApp;

	var UpsellLink:Int = 100;

	public var mBackToGameButton:CButtonWidget;

	var mUpsellImage2:ImageInst;

	var mUpsellImage:ImageInst;

	var mHeader2Description:StringRenderable;

	var mType:Int = 0;

	var mUpsellButtonText:StringRenderable;

	var mTitleString:StringRenderable;

	var mHeader1Description:StringRenderable;

	var upsellXML:XMLC;

	var mURLRequest:URLRequest;

	var BackToGame:Int = 101;

	public function new(app:PVZApp, theType:Int) {
		super();
		// this.upsellXML = <data>DeluxeDownload</data>;
		// super();
		this.app = app;
		this.mURLRequest = new URLRequest(app.mUpsellLink);
		this.mBackToGameButton = new CButtonWidget(this.BackToGame, this);
		this.mBackToGameButton.setDisabled(false);
		this.mBackToGameButton.visible = true;
		this.mBackToGameButton.label = app.stringManager.translateString("[UPSELL_RETURN_TO_GAME_BUTTON]");
		this.mBackToGameButton.setColor(Std.int(CButtonWidget.COLOR_LABEL), Color.RGB(25 / 255, 30 / 255, 200 / 255));
		this.mBackToGameButton.setColor(Std.int(CButtonWidget.COLOR_LABEL_HILITE), Color.RGB(100 / 255, 150 / 255, 240 / 255));
		var font4 = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
		font4.scale = 0.9;
		this.mBackToGameButton.font = font4;
		this.mBackToGameButton.resize(287, 358, 152, 37);
		this.mUpsellButton = new CButtonWidget(this.UpsellLink, this);
		this.mUpsellButton.setDisabled(false);
		this.mUpsellButton.visible = true;
		this.mUpsellButton.label = app.stringManager.translateString("[UPSELL_BUY_BUTTON]");
		this.mUpsellButton.setColor(Std.int(CButtonWidget.COLOR_LABEL), Color.RGB(25 / 255, 30 / 255, 200 / 255));
		this.mUpsellButton.setColor(Std.int(CButtonWidget.COLOR_LABEL_HILITE), Color.RGB(100 / 255, 150 / 255, 240 / 255));
		var font5 = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
		font5.scale = 0.9;
		this.mUpsellButton.font = font5;
		this.mUpsellButton.resize(99, 358, 153, 37);
		switch (theType) {
			case ADVENTURE:
				this.Adventure();
			case PUZZLE:
				this.Puzzle();
			case SURVIVAL:
				this.Survival();
			case MINIGAME:
				this.Minigame();
		}
		this.mType = theType;
	}

	public function buttonMouseMove(id:Float, x:Float, y:Float) {}

	public function buttonMouseEnter(id:Float) {}

	public function buttonDownTick(id:Float) {}

	public function buttonPress(id:Float) {}

	override public function draw(g:Graphics2D) {
		g.drawImage(this.mBackgroundImage, 0, 0);
	}

	override public function update() {}

	public function Survival() {
		this.mBackgroundImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_UPSELL3);
	}

	public function buttonMouseLeave(id:Float) {}

	public function Minigame() {
		this.mBackgroundImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_UPSELL2);
	}

	public function CloseUpsell() {
		if (this.mType == MINIGAME) {
			this.app.stateManager.popState();
		} else {
			this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
		}
	}

	public function Adventure() {
		this.mBackgroundImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_UPSELL1);
	}

	public function buttonRelease(id:Float) {
		switch (id) {
			case(_ == this.UpsellLink => true):
				this.app.adAPI.CustomEvent(this.upsellXML, this.CloseUpsell);
				if (!this.app.adAPI.enabled) {
					flash.Lib.getURL(this.mURLRequest);
				}
			case(_ == this.BackToGame => true):
				if (this.mType == MINIGAME) {
					this.app.stateManager.popState();
				} else {
					this.app.adAPI.GameEnd();
					this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
				}

			default:
		}
	}

	public function Puzzle() {
		this.mBackgroundImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_UPSELL4);
	}
}
