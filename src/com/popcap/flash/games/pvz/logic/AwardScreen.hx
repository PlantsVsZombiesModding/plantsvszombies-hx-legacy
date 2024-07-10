package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.render.RenderManager;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.widgets.CWidget;
import com.popcap.flash.framework.widgets.ui.IButtonListener;
import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.renderables.StringRenderable;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import com.popcap.flash.games.pvz.resources.PVZImages;
import com.popcap.flash.games.pvz.resources.PVZReanims;
import flash.display.BitmapData;
import flash.geom.Point;

class AwardScreen extends CWidget implements IButtonListener {
	public static inline final SEED_PUFFSHROOM = 8;

	static inline final SEED_NONE = -1;

	static inline final SEED_CHERRYBOMB = 2;

	static inline final SEED_SQUASH = 4;

	static inline final SEED_PEASHOOTER = 0;

	static inline final SEED_CHOMPER = 6;

	public static inline final SEED_SUNSHROOM = 9;

	static inline final SEED_REPEATER = 7;

	static inline final SEED_WALLNUT = 3;

	public static inline final SEED_FUMESHROOM = 10;

	public static inline final SEED_GRAVEBUSTER = 11;

	static inline final SEED_SUNFLOWER = 1;

	static inline final SEED_SNOWPEA = 5;

	public var mFadedIn:Bool = false;

	var mZombieNote:ImageInst;

	public var mStartButton:ImageButtonWidget;

	var mFadeInCounter:Int = 0;

	var mButtonImage:ImageInst;

	var app:PVZApp;

	var mDescriptionTextRenderable:StringRenderable;

	var mNameTextRenderable:StringRenderable;

	var mTitleTextRenderable:StringRenderable;

	public var mRenderManager:RenderManager;

	var mShovelImage:ImageInst;

	var mZombieNote1:ImageInst;

	var mBufferedImage:ImageInst;

	var mBackground:ImageInst;

	public function new(app:PVZApp) {
		super();
		this.mRenderManager = new RenderManager();
		// super();
		this.app = app;
		this.mFadeInCounter = 180;
		this.mStartButton = new ImageButtonWidget(0, this);
		this.mStartButton.visible = true;
		var aString = app.stringManager.translateString("[NEXT_LEVEL_BUTTON]");
		var font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
		font.scale = 0.7;
		var anImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON);
		var aGlowImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON_GLOW);
		this.mStartButton.mUpImage = this.MakeButton(anImage, font, aString);
		this.mStartButton.mDisabledImage = this.MakeButton(anImage, font, aString);
		font.setColor(1, 1.5, 1.5, 1.5);
		this.mStartButton.mDownImage = this.MakeGlowButton(anImage, aGlowImage, font, aString);
		this.mStartButton.mDownOffset = new Point(1, 1);
		this.mStartButton.mOverImage = this.MakeGlowButton(anImage, aGlowImage, font, aString);
		anImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON_DISABLED);
		this.mStartButton.resize(215, 337, 105, 28);
		if (app.mLevel == 9) {
			this.mBackground = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1);
			this.mZombieNote = app.imageManager.getImageInst(PVZImages.IMAGE_ZOMBIENOTE);
		} else {
			this.mBackground = app.imageManager.getImageInst(PVZImages.IMAGE_AWARDSCREEN_BACK);
		}
		this.mButtonImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON);
		this.mShovelImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVEL_SMALL);
		var aLevel = app.mLevel;
		var awardSeed = this.GetAwardSeedForLevel(aLevel);
		var seedName = this.GetSeedName(awardSeed);
		var seedToolTip = this.GetSeedToolTip(awardSeed);
		var title = app.stringManager.translateString("[NEW_PLANT]");
		if (aLevel == 4) {
			title = app.stringManager.translateString("[GOT_SHOVEL]");
			seedName = app.stringManager.translateString("[SHOVEL]");
			seedToolTip = app.stringManager.translateString("[SHOVEL_DESCRIPTION]");
		} else if (aLevel == 9) {
			title = app.stringManager.translateString("[FOUND_NOTE]");
			seedName = "";
			seedToolTip = "";
		}
		font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT24);
		font.scale = 0.9;
		font.setColor(1, 213 / 255, 159 / 255, 43 / 255);
		this.mTitleTextRenderable = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI);
		this.mTitleTextRenderable.setBounds(95, 20, 350, 27);
		this.mTitleTextRenderable.font = font;
		this.mTitleTextRenderable.text = title;
		font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
		font.setColor(1, 1, 1, 1);
		font.scale = 1;
		this.mNameTextRenderable = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI);
		this.mNameTextRenderable.setBounds(157, 197, 225, 40);
		this.mNameTextRenderable.font = font;
		this.mNameTextRenderable.text = seedName;
		font = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
		font.setColor(1, 40 / 255, 50 / 255, 90 / 255);
		font.scale = 1;
		this.mDescriptionTextRenderable = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI);
		this.mDescriptionTextRenderable.setBounds(175, 235, 185, 80);
		this.mDescriptionTextRenderable.font = font;
		this.mDescriptionTextRenderable.text = seedToolTip;
		this.mRenderManager.add(this.mDescriptionTextRenderable);
		this.mRenderManager.add(this.mTitleTextRenderable);
		this.mRenderManager.add(this.mNameTextRenderable);
	}

	public function buttonMouseMove(id:Float, x:Float, y:Float) {}

	public function GetPlantDefinition(theSeedType:Int):String {
		var aReanimType:String = null;
		switch (theSeedType) {
			case SEED_PEASHOOTER:
				aReanimType = PVZReanims.REANIM_PEASHOOTERSINGLE;
			case SEED_SUNFLOWER:
				aReanimType = PVZReanims.REANIM_SUNFLOWER;
			case SEED_CHERRYBOMB:
				aReanimType = PVZReanims.REANIM_CHERRYBOMB;
			case SEED_CHOMPER:
				aReanimType = PVZReanims.REANIM_CHOMPER;
			case SEED_SNOWPEA:
				aReanimType = PVZReanims.REANIM_SNOWPEA;
			case SEED_SQUASH:
				aReanimType = PVZReanims.REANIM_SQUASH;
			case SEED_REPEATER:
				aReanimType = PVZReanims.REANIM_PEASHOOTER;
			case SEED_WALLNUT:
				aReanimType = PVZReanims.REANIM_WALLNUT;
			case SEED_PUFFSHROOM:
				aReanimType = PVZReanims.REANIM_PUFFSHROOM;
			case SEED_SUNSHROOM:
				aReanimType = PVZReanims.REANIM_SUNSHROOM;
			case SEED_FUMESHROOM:
				aReanimType = PVZReanims.REANIM_FUMESHROOM;
			case SEED_GRAVEBUSTER:
				aReanimType = PVZReanims.REANIM_GRAVEBUSTER;
		}
		return aReanimType;
	}

	public function buttonMouseEnter(id:Float) {}

	public function GetSeedToolTip(theType:Int):String {
		var aName:String = null;
		switch (theType) {
			case 0:
				aName = this.app.stringManager.translateString("[PEASHOOTER_TOOLTIP]");
			case 1:
				aName = this.app.stringManager.translateString("[SUNFLOWER_TOOLTIP]");
			case 2:
				aName = this.app.stringManager.translateString("[CHERRY_BOMB_TOOLTIP]");
			case 3:
				aName = this.app.stringManager.translateString("[WALL_NUT_TOOLTIP]");
			case 4:
				aName = this.app.stringManager.translateString("[SQUASH_TOOLTIP]");
			case 5:
				aName = this.app.stringManager.translateString("[SNOW_PEA_TOOLTIP]");
			case 6:
				aName = this.app.stringManager.translateString("[CHOMPER_TOOLTIP]");
			case 7:
				aName = this.app.stringManager.translateString("[REPEATER_TOOLTIP]");
			case 8:
				aName = this.app.stringManager.translateString("[PUFF_SHROOM_TOOLTIP]");
			case 9:
				aName = this.app.stringManager.translateString("[SUN_SHROOM_TOOLTIP]");
			case 10:
				aName = this.app.stringManager.translateString("[FUME_SHROOM_TOOLTIP]");
			case 11:
				aName = this.app.stringManager.translateString("[GRAVE_BUSTER_TOOLTIP]");
		}
		return aName;
	}

	public function DrawBottom(g:Graphics2D) {
		g.drawImage(this.mBackground, 0, 0);
	}

	public function GetCurrentPlantCost(theSeedType:Int):Int {
		var aCost = 0;
		switch (theSeedType) {
			case SEED_PEASHOOTER:
				aCost = 100;
			case SEED_SUNFLOWER:
				aCost = 50;
			case SEED_CHERRYBOMB:
				aCost = 150;
			case SEED_WALLNUT:
				aCost = 50;
			case SEED_CHOMPER:
				aCost = 150;
			case SEED_SQUASH:
				aCost = 50;
			case SEED_SNOWPEA:
				aCost = 175;
			case SEED_REPEATER:
				aCost = 200;
			case SEED_PUFFSHROOM:
				aCost = 0;
			case SEED_SUNSHROOM:
				aCost = 25;
			case SEED_FUMESHROOM:
				aCost = 75;
			case SEED_GRAVEBUSTER:
				aCost = 75;
			default:
				aCost = 100;
		}
		return aCost;
	}

	public function buttonDownTick(id:Float) {}

	public function GetAwardSeedForLevel(aLevel:Int):Int {
		var aArea = Std.int((aLevel - 1) / 10 + 1);
		var aSubArea = (aLevel - 1) % 10 + 1;
		var aSeeds = (aArea - 1) * 8 + aSubArea;
		if (aSubArea >= 10) {
			aSeeds -= 2;
		} else if (aSubArea >= 5) {
			aSeeds--;
		}
		if (aSeeds > 40) {
			aSeeds = 40;
		}
		return aSeeds;
	}

	public function buttonPress(id:Float) {}

	override public function draw(g:Graphics2D) {
		var aLevel = this.app.mLevel;
		if (aLevel == 4) {
			this.DrawBottom(g);
			g.drawImage(this.mShovelImage, 250, 115);
		} else if (aLevel == 9) {
			g.pushState();
			g.scale(2, 2);
			g.drawImage(this.mBackground, -472, -202);
			g.popState();
			g.drawImage(this.mZombieNote, 60, 55);
		} else {
			this.DrawAwardSeed(g);
		}
		var aAlpha = TodCommon.TodAnimateCurve(180, 0, this.mFadeInCounter, 255, 0, TodCommon.CURVE_LINEAR);
		var aColor:UInt = aAlpha << 24;
		if (this.IsPaperNote()) {
			aColor |= 0;
		} else {
			aColor |= 16777215;
		}
		this.mRenderManager.draw(g);
		g.fillRect(0, 0, 540, 405, aColor);
		if (aAlpha <= 0) {
			this.mFadedIn = true;
		}
	}

	override public function update() {
		this.mRenderManager.update();
		markDirty();
		if (this.mFadeInCounter > 0) {
			--this.mFadeInCounter;
		}
	}

	public function MakeGlowButton(theImage:ImageInst, theGlowImage:ImageInst, theFont:FontInst, theText:String):ImageInst {
		var w = theImage.width;
		var h = theImage.height;
		var aBufferedImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = aBufferedImage.graphics;
		bufferG.drawImage(theImage, 0, 0);
		bufferG.drawImage(theGlowImage, 0, 0);
		while (theFont.stringImageWidth(theText) > theImage.width) {
			theFont.scale -= 0.1;
		}
		bufferG.setFont(theFont);
		var offsetX = (theImage.width - theFont.stringImageWidth(theText)) / 2;
		var offsetY = (theImage.height - theFont.getHeight()) / 2;
		bufferG.drawString(theText, offsetX, offsetY);
		return aBufferedImage;
	}

	public function SaveUserData() {
		++this.app.mSaveObject.level;
		++this.app.mLevel;
		if (this.app.mSaveObject.level > 14) {
			this.app.mSaveObject.level == 1;
			this.app.mLevel = 1;
			if (this.app.mSaveObject.puzzleLocked) {
				this.app.mSaveObject.puzzleLocked = false;
				this.app.mPuzzleLocked = false;
			}
			if (this.app.mSaveObject.survivalLocked) {
				this.app.mSaveObject.survivalLocked = false;
				this.app.mSurvivalLocked = false;
			}
		}
		this.app.setSaveData(this.app.mSaveObject);
	}

	function GameContinue() {
		if (this.app.adAPI.enabled) {
			this.app.musicManager.resumeMusic();
			this.app.soundManager.resumeAll();
		}
		++this.app.mLevel;
		++this.app.mSaveObject.level;
		this.app.setSaveData(this.app.mSaveObject);
		this.app.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
	}

	public function DrawSeedPacket(g:Graphics2D, theType:Int) {
		var aSeedBackImg:ImageInst = null;
		var aPlantImg:ImageInst = null;
		aSeedBackImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SEEDPACKET_LARGER);
		var w = aSeedBackImg.width;
		var h = aSeedBackImg.height;
		this.mBufferedImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = this.mBufferedImage.graphics;
		bufferG.drawImage(aSeedBackImg, 0, 0);
		var aOffsetX:Float = 10;
		var aOffsetY:Float = 15;
		var aScale:Float = 1;
		switch (theType) {
			case SEED_PEASHOOTER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTERSINGLE);

				aOffsetY += 4;
			case SEED_SUNFLOWER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SUNFLOWER);
				aOffsetY += 1;

				aOffsetX += 2;
			case SEED_CHERRYBOMB:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHERRYBOMB);
				aOffsetY += 1;

				aOffsetX += -1;
			case SEED_SQUASH:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SQUASH);
				aOffsetX += 0;

				aOffsetY += -2;
			case SEED_CHOMPER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHOMPER);
				aOffsetX += -2;
				aOffsetY += -3;

				aScale = 0.85;
			case SEED_SNOWPEA:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SNOWPEA);

				aOffsetY += 3;
			case SEED_REPEATER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTER);

				aOffsetY += 5;
			case SEED_PUFFSHROOM:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM);
				aOffsetY += 12;

				aOffsetX += 9;
			case SEED_SUNSHROOM:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
				aOffsetY += 13;

				aOffsetX += 10;
			case SEED_GRAVEBUSTER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
				aOffsetY += 1;
				aOffsetX += -5;

				aScale = 0.85;
			case SEED_FUMESHROOM:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
				aOffsetX -= 2;
				aOffsetY += 1;

				aScale = 0.95;
			case SEED_WALLNUT:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
				aOffsetX += 3;
		}
		bufferG.pushState();
		bufferG.scale(aScale, aScale);
		bufferG.drawImage(aPlantImg, aOffsetX, aOffsetY);
		bufferG.popState();
		var theFont = this.app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
		theFont.scale = 1.6;
		theFont.setColor(1, 0, 0, 0);
		var aCost = this.GetCurrentPlantCost(theType);
		var width = Std.int(theFont.stringWidth(Std.string(aCost)));
		var height = Std.int(theFont.getAscent());
		var aTextOffsetX = 45 - width;
		var aTextOffsetY = 72;
		bufferG.setFont(theFont);
		bufferG.drawString(Std.string(aCost), aTextOffsetX, aTextOffsetY);
	}

	public function MakeButton(theImage:ImageInst, theFont:FontInst, theText:String):ImageInst {
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
		var offsetY = (theImage.height - theFont.getHeight()) / 2;
		bufferG.drawString(theText, offsetX, offsetY);
		return aBufferedImage;
	}

	public function buttonMouseLeave(id:Float) {}

	public function DrawAwardSeed(g:Graphics2D) {
		var aLevel = this.app.mLevel;
		var awardSeed = this.GetAwardSeedForLevel(aLevel);
		this.DrawBottom(g);
		if (this.mBufferedImage == null) {
			this.DrawSeedPacket(g, awardSeed);
		}
		g.drawImage(this.mBufferedImage, 236, 87);
	}

	public function GetSeedName(theType:Int):String {
		var aName:String = null;
		switch (theType) {
			case 0:
				aName = this.app.stringManager.translateString("[PEASHOOTER]");
			case 1:
				aName = this.app.stringManager.translateString("[SUNFLOWER]");
			case 2:
				aName = this.app.stringManager.translateString("[CHERRY_BOMB]");
			case 3:
				aName = this.app.stringManager.translateString("[WALL_NUT]");
			case 4:
				aName = this.app.stringManager.translateString("[SQUASH]");
			case 5:
				aName = this.app.stringManager.translateString("[SNOW_PEA]");
			case 6:
				aName = this.app.stringManager.translateString("[CHOMPER]");
			case 7:
				aName = this.app.stringManager.translateString("[REPEATER]");
			case 8:
				aName = this.app.stringManager.translateString("[PUFF_SHROOM]");
			case 9:
				aName = this.app.stringManager.translateString("[SUN_SHROOM]");
			case 10:
				aName = this.app.stringManager.translateString("[FUME_SHROOM]");
			case 11:
				aName = this.app.stringManager.translateString("[GRAVE_BUSTER]");
		}
		return aName;
	}

	public function IsPaperNote():Bool {
		var aLevel = 0;
		if (this.app.IsAdventureMode()) {
			aLevel = this.app.mLevel;
			if (aLevel == 9) {
				return true;
			}
		}
		return false;
	}

	public function buttonRelease(id:Float) {
		if (this.app.adAPI.enabled) {
			this.app.musicManager.pauseMusic();
			this.app.soundManager.pauseAll();
		}
		this.mStartButton.setDisabled(true);
		this.app.adAPI.GameBreak(this.app.mLevel, this.GameContinue);
	}
}
