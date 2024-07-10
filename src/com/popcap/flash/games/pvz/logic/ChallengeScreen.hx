package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.widgets.CWidget;
import com.popcap.flash.framework.widgets.ui.CButtonWidget;
import com.popcap.flash.framework.widgets.ui.IButtonListener;
import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.renderables.StringRenderable;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import com.popcap.flash.games.pvz.resources.PVZImages;
import flash.display.BitmapData;
import flash.geom.Point;

class ChallengeScreen extends CWidget implements IButtonListener {
	public var mStartButton:ImageButtonWidget;

	var mButtonText:String;

	var StartGame:Int = 100;

	var mUpsellText:StringRenderable;

	var mTitleString:String;

	public var mBackToMenuButton:CButtonWidget;

	public var app:PVZApp;

	var mBackgroundImage:ImageInst;

	var mBackToMenuImage:ImageInst;

	var BackToMenu:Int = 101;

	public var mBoard:Board;

	public function new(app:PVZApp, theBoard:Board) {
		super();
		// super();
		this.app = app;
		this.mBoard = theBoard;
		this.mStartButton = new ImageButtonWidget(this.StartGame, this);
		if (app.IsScaryPotterLevel()) {
			this.mButtonText = app.stringManager.translateString("[SCARY_POTTER_ENDLESS]");
			this.mStartButton.resize(20, 62, 80, 81);
		} else if (app.IsSurvivalMode()) {
			this.mButtonText = app.stringManager.translateString("[SURVIVAL_POOL_ENDLESS]");
			this.mStartButton.resize(20, 100, 80, 81);
		}
		this.mStartButton.mUpImage = this.MakeUpButtonImage();
		this.mStartButton.mDownImage = this.MakeDownButtonImage();
		this.mStartButton.mOverImage = this.MakeDownButtonImage();
		this.mStartButton.mDownOffset = new Point(1, 1);
		this.mStartButton.mDisabledImage = this.MakeUpButtonImage();
		this.mBackToMenuButton = new CButtonWidget(this.BackToMenu, this);
		this.mBackToMenuButton.setDisabled(false);
		this.mBackToMenuButton.visible = true;
		this.mBackToMenuButton.label = app.stringManager.translateString("[BACK_TO_MENU]");
		this.mBackToMenuButton.setColor(Std.int(CButtonWidget.COLOR_LABEL), Color.RGB(218 / 255, 184 / 255, 33 / 255));
		var font = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
		font.scale = 0.6;
		this.mBackToMenuButton.font = font;
		this.mBackToMenuButton.resize(20, 360, 75, 18);
		this.mBackToMenuImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON2);
		this.mBackgroundImage = app.imageManager.getImageInst(PVZImages.IMAGE_CHALLENGE_BACKGROUND);
		font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36GREENINSET);
		font.scale = 0.8;
		font.setColor(1, 90 / 255, 40 / 255, 30 / 255);
		this.mUpsellText = new StringRenderable(0);
		this.mUpsellText.font = font;
		if (app.IsScaryPotterLevel()) {
			this.mUpsellText.setBounds(20, 150, 500, 200);
			this.mUpsellText.text = app.stringManager.translateString("[PUZZLE_UPSELL_MESSAGE]");
			this.mTitleString = app.stringManager.translateString("[SCARY_POTTER]");
		} else if (app.IsSurvivalMode()) {
			this.mUpsellText.setBounds(70, 150, 420, 200);
			this.mUpsellText.text = app.stringManager.translateString("[SURVIVAL_UPSELL_MESSAGE]");
			this.mTitleString = app.stringManager.translateString("[PICK_AREA]");
		}
	}

	public function buttonMouseMove(id:Float, x:Float, y:Float) {}

	public function buttonMouseEnter(id:Float) {}

	override public function update() {}

	public function buttonDownTick(id:Float) {}

	public function MakeDownButtonImage():ImageInst {
		var w:Float = 80;
		var h:Float = 81;
		var aBufferedImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = aBufferedImage.graphics;
		var anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHALLENGE_WINDOW_HIGHLIGHT);
		bufferG.drawImage(anImage, 0, 0);
		anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_SURVIVAL_THUMBNAILS);
		var aStringRenderable = new StringRenderable(0);
		var aFont = this.app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
		aFont.setColor(1, 250 / 255, 40 / 255, 40 / 255);
		aFont.scale = 0.6;
		aStringRenderable.text = this.mButtonText;
		aStringRenderable.font = aFont;
		aStringRenderable.setBounds(7, 50, 65, 23);
		aStringRenderable.draw(bufferG);
		return aBufferedImage;
	}

	public function MakeUpButtonImage():ImageInst {
		var w:Float = 80;
		var h:Float = 81;
		var aBufferedImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = aBufferedImage.graphics;
		var anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHALLENGE_WINDOW);
		bufferG.drawImage(anImage, 0, 0);
		anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_SURVIVAL_THUMBNAILS);
		var aStringRenderable = new StringRenderable(0);
		var aFont = this.app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
		aFont.setColor(1, 42 / 255, 42 / 255, 90 / 255);
		aFont.scale = 0.6;
		aStringRenderable.text = this.mButtonText;
		aStringRenderable.font = aFont;
		aStringRenderable.setBounds(7, 50, 65, 23);
		aStringRenderable.draw(bufferG);
		return aBufferedImage;
	}

	public function buttonMouseLeave(id:Float) {}

	override public function draw(g:Graphics2D) {
		var aPosX = 0;
		var aPosY = 0;
		var aRow = 0;
		var aCol = 0;
		g.drawImage(this.mBackgroundImage, 0, 0);
		var aFont = this.app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR28);
		aFont.scale = 0.7;
		aFont.setColor(1, 220 / 255, 220 / 255, 220 / 255);
		g.setFont(aFont);
		g.drawString(this.mTitleString, 230, 12);
		var i = 1;
		var aBlank = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHALLENGE_BLANK);
		if (this.app.IsScaryPotterLevel()) {
			var i:ASAny = 1;
			while (i < 20) {
				aRow = Std.int(i / 5);
				aCol = i % 5;
				aPosX = 23 + aCol * 105;
				aPosY = 62 + aRow * 81;
				g.drawImage(aBlank, aPosX, aPosY);
				i++;
			}
		} else if (this.app.IsSurvivalMode()) {
			var i:ASAny = 1;
			while (i < 10) {
				aRow = Std.int(i / 5);
				aCol = i % 5;
				aPosX = 23 + aCol * 105;
				aPosY = 100 + aRow * 100;
				g.drawImage(aBlank, aPosX, aPosY);
				i++;
			}
			aPosX = 23 + 2 * 105;
			aPosY = 100 + 2 * 100;
			g.drawImage(aBlank, aPosX, aPosY);
		}

		this.mUpsellText.draw(g);
		g.drawImage(this.mBackToMenuImage, 20, 361);
	}

	public function buttonPress(id:Float) {}

	public function buttonRelease(id:Float) {
		switch (id) {
			case(_ == this.StartGame => true):
				this.app.stateManager.popState();
				this.app.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
			case(_ == this.BackToMenu => true):
				this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);

			default:
		}
	}
}
