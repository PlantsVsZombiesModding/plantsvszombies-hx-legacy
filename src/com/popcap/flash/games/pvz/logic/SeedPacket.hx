package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.resources.particles.ParticleSystem;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import com.popcap.flash.games.pvz.resources.PVZImages;
import com.popcap.flash.games.pvz.resources.PVZParticles;
import openfl.display.BitmapData;

class SeedPacket extends GameObject {
	static inline final CURSOR_TYPE_PLANT_FROM_BANK = 1;

	public static inline final TUTORIAL_MORESUN_COMPLETED = 12;

	static inline final SLOT_MACHINE_TIME = 400;

	public static inline final TUTORIAL_LEVEL_2_PLANT_SUNFLOWER = 6;

	static inline final OBJECT_TYPE_PLANT = 1;

	static inline final CURSOR_TYPE_HAMMER = 4;

	static inline final OBJECT_TYPE_PROJECTILE = 2;

	public static inline final SEED_REPEATER = 7;

	public static inline final TUTORIAL_MORESUN_PICK_UP_SUNFLOWER = 9;

	static inline final CURSOR_TYPE_PLANT_FROM_USABLE_COIN = 2;

	static inline final OBJECT_TYPE_NONE = 0;

	public static inline final TUTORIAL_LEVEL_1_COMPLETED = 4;

	public static inline final SEED_WALLNUT = 3;

	public static inline final SEED_PUFFSHROOM = 8;

	public static inline final TUTORIAL_MORESUN_PLANT_SUNFLOWER = 10;

	static inline final SECONDS_PER_UPDATE:Float = 0.01;

	static inline final CURSOR_TYPE_NORMAL = 0;

	static inline final VARIATION_NORMAL = "normal";

	public static inline final SEED_EXPLODE_O_NUT = 50;

	public static inline final SEED_SUNFLOWER = 1;

	public static inline final SEED_PEASHOOTER = 0;

	public static inline final SEED_FUMESHROOM = 10;

	public static inline final TUTORIAL_LEVEL_1_PLANT_PEASHOOTER = 2;

	public static inline final TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER = 7;

	public static inline final TUTORIAL_SHOVEL_DIG = 14;

	static inline final OBJECT_TYPE_SHOVEL = 5;

	public static inline final SEED_SNOWPEA = 5;

	public static inline final SEED_CHOMPER = 6;

	public static inline final SEED_NONE = -1;

	public static inline final TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER = 3;

	public static inline final TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER = 1;

	public static inline final TUTORIAL_SHOVEL_COMPLETED = 16;

	public static inline final SEED_CHERRYBOMB = 2;

	public static inline final TUTORIAL_MORESUN_REFRESH_SUNFLOWER = 11;

	static inline final OBJECT_TYPE_SEEDPACKET = 4;

	static inline final CURSOR_TYPE_SHOVEL = 3;

	public static inline final TUTORIAL_LEVEL_2_COMPLETED = 8;

	public static inline final SEED_SQUASH = 4;

	public static inline final SEED_LEFTPEATER = 49;

	public static inline final TUTORIAL_OFF = 0;

	public static inline final SEED_SUNSHROOM = 9;

	static inline final OBJECT_TYPE_COIN = 3;

	public static inline final TUTORIAL_SHOVEL_PICKUP = 13;

	public static inline final TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER = 5;

	public static inline final TUTORIAL_SHOVEL_KEEP_DIGGING = 15;

	public static inline final SEED_GRAVEBUSTER = 11;

	var mSlotMachiningPosition:Float = Math.NaN;

	public var mUpdateImage:Bool = false;

	var mBufferedImage:ImageInst;

	public var mActive:Bool = false;

	var mSeedPacketFont:FontInst;

	var mImitaterType:Int = 0;

	public var mRefreshTime:Int = 0;

	var mSlotMachiningNextSeed:Int = 0;

	public var mIndex:Int = 0;

	public var mRefreshCounter:Int = 0;

	public var mPacketType:Int = 0;

	public var mRefreshing:Bool = false;

	var mSlotMachineCountDown:Int = 0;

	public var mTimesUsed:Int = 0;

	public var mOffsetX:Int = 0;

	public function new(app:PVZApp, theBoard:Board) {
		super();
		// super();
		this.mSeedPacketFont = app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
		mBoard = theBoard;
		this.app = app;
		this.mPacketType = SEED_PEASHOOTER;
		this.mImitaterType = SEED_NONE;
		this.mIndex = -1;
		mWidth = 46;
		mHeight = 65;
		this.mRefreshCounter = 0;
		this.mRefreshTime = 0;
		this.mRefreshing = false;
		this.mActive = true;
		this.mOffsetX = 0;
		this.mSlotMachineCountDown = 0;
		this.mSlotMachiningNextSeed = SEED_NONE;
		this.mSlotMachiningPosition = 0;
		this.mTimesUsed = 0;
		mVisible = true;
		this.mUpdateImage = true;
	}

	public function MouseHitTest(theX:Int, theY:Int, theHitResult:HitResult):Bool {
		if (theX >= mX + this.mOffsetX && theX < mX + mWidth + this.mOffsetX && theY >= mY && theY < mY + mHeight && this.mPacketType != SEED_NONE) {
			theHitResult.mObject = this;
			theHitResult.mObjectType = OBJECT_TYPE_SEEDPACKET;
			return true;
		}
		theHitResult.mObject = null;
		theHitResult.mObjectType = OBJECT_TYPE_NONE;
		return false;
	}

	public function WasPlanted() {
		if (mBoard.HasConveyorBeltSeedBank()) {
			mBoard.mSeedBank.RemoveSeed(this.mIndex);
		} else {
			++this.mTimesUsed;
			this.mRefreshing = true;
			this.mRefreshTime = this.GetRefreshTime(this.mPacketType);
		}
	}

	public function FlashIfReady() {
		var anEffect:ParticleSystem = null;
		if (!this.CanPickUp()) {
			return;
		}
		if (mBoard.mEasyPlantingCheat) {
			return;
		}
		if (!mBoard.HasConveyorBeltSeedBank()) {
			anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SEEDPACKETFLASH);
			anEffect.setPosition(mX + 6, mY + 9);
			mBoard.mRenderManager.add(new ParticleRenderable(anEffect, Board.RENDER_LAYER_UI_BOTTOM + 2));
		}
		if (mBoard.mTutorialState == TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER) {
			mBoard.SetTutorialState(TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER);
		} else if (mBoard.mTutorialState == TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER && this.mPacketType == SEED_SUNFLOWER) {
			mBoard.SetTutorialState(TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER);
		} else if (mBoard.mTutorialState == TUTORIAL_MORESUN_REFRESH_SUNFLOWER && this.mPacketType == SEED_SUNFLOWER) {
			mBoard.SetTutorialState(TUTORIAL_MORESUN_PICK_UP_SUNFLOWER);
		}
	}

	public function PickNextSlotMachineSeed() {}

	public function update() {
		if (mBoard.mGameScene != PVZApp.SCENE_PLAYING) {
			return;
		}
		if (this.mPacketType == SEED_NONE) {
			return;
		}
		if (mBoard.mMainCounter == 0) {
			this.FlashIfReady();
		}
		if (!this.mActive && this.mRefreshing) {
			++this.mRefreshCounter;
			if (this.mRefreshCounter > this.mRefreshTime) {
				this.mRefreshCounter = 0;
				this.mRefreshing = false;
				this.Activate();
				this.FlashIfReady();
			}
		}
	}

	public function MouseDown(x:Float, y:Float) {
		var aCost = 0;
		if (mBoard.mPaused || mBoard.mGameScene != Board.SCENE_PLAYING) {
			return;
		}
		if (this.mPacketType == SEED_NONE) {
			return;
		}
		var aPlantingSeedType = this.mPacketType;
		if (!mBoard.mEasyPlantingCheat) {
			if (!this.mActive) {
				app.foleyManager.playFoley(PVZFoleyType.BUZZER);
				if (mBoard.mLevel == 1 && ASCompat.toBool(mBoard.mHelpDisplayed[Board.ADVICE_CLICK_ON_SUN])) {
					mBoard.DisplayAdvice("[ADVICE_SEED_REFRESH]", Board.MESSAGE_STYLE_TUTORIAL_LEVEL1, Board.ADVICE_SEED_REFRESH);
				}
				return;
			}
			aCost = mBoard.GetCurrentPlantCost(this.mPacketType);
			if (!mBoard.CanTakeSunMoney(aCost) && !mBoard.HasConveyorBeltSeedBank()) {
				app.foleyManager.playFoley(PVZFoleyType.BUZZER);
				mBoard.mOutOfMoneyCounter = 70;
				if (mBoard.mLevel == 1 && ASCompat.toBool(mBoard.mHelpDisplayed[Board.ADVICE_CLICK_ON_SUN])) {
					mBoard.DisplayAdvice("[ADVICE_CANT_AFFORD_PLANT]", Board.MESSAGE_STYLE_TUTORIAL_LEVEL1, Board.ADVICE_CANT_AFFORD_PLANT);
				}
				return;
			}
		}
		mBoard.mCursorObject.mType = this.mPacketType;
		mBoard.mCursorObject.mCursorType = CURSOR_TYPE_PLANT_FROM_BANK;
		mBoard.mCursorObject.mSeedBankIndex = this.mIndex;
		app.foleyManager.playFoley(PVZFoleyType.SEEDLIFT);
		if (mBoard.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER) {
			mBoard.SetTutorialState(TUTORIAL_LEVEL_1_PLANT_PEASHOOTER);
		} else if (mBoard.mTutorialState == TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER) {
			if (this.mPacketType == SEED_SUNFLOWER) {
				mBoard.SetTutorialState(TUTORIAL_LEVEL_2_PLANT_SUNFLOWER);
			} else {
				mBoard.SetTutorialState(TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER);
			}
		} else if (mBoard.mTutorialState == TUTORIAL_MORESUN_PICK_UP_SUNFLOWER) {
			if (this.mPacketType == SEED_SUNFLOWER) {
				mBoard.SetTutorialState(TUTORIAL_MORESUN_PLANT_SUNFLOWER);
			} else {
				mBoard.SetTutorialState(TUTORIAL_MORESUN_REFRESH_SUNFLOWER);
			}
		}
		this.Deactivate();
	}

	public function Deactivate() {
		this.mActive = false;
		this.mRefreshCounter = 0;
		this.mRefreshTime = 0;
		this.mRefreshing = false;
	}

	function drawBufferedImage(g:Graphics2D) {
		var aSeedBackImg:ImageInst = null;
		var aPlantImg:ImageInst = null;
		var aCost = 0;
		var width = 0;
		var height = 0;
		var aTextOffsetX = 0;
		var aTextOffsetY = 0;
		aSeedBackImg = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBACK);
		var w = aSeedBackImg.width;
		var h = aSeedBackImg.height;
		this.mBufferedImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = this.mBufferedImage.graphics;
		bufferG.drawImage(aSeedBackImg, 0, 0);
		var aOffsetX:Float = 5;
		var aOffsetY:Float = 10;
		var aScale:Float = 0.75;
		switch (this.mPacketType) {
			case SEED_EXPLODE_O_NUT:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
				aPlantImg.useColor = true;
				aPlantImg.setColor(1, 1, 64 / 255, 64 / 255);

				aOffsetX += 3;
			case SEED_PEASHOOTER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTERSINGLE);

				aOffsetY += 4;
			case SEED_SUNFLOWER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNFLOWER);
				aOffsetY += 1;

				aOffsetX += 2;
			case SEED_CHERRYBOMB:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHERRYBOMB);
				aOffsetY += 3;

				aOffsetX += -1;
			case SEED_SQUASH:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SQUASH);
				aOffsetX += 0;

				aOffsetY += -2;
			case SEED_CHOMPER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHOMPER);
				aOffsetX += -2;
				aOffsetY += -3;

				aScale = 0.6;
			case SEED_SNOWPEA:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SNOWPEA);

				aOffsetY += 3;
			case SEED_REPEATER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTER);

				aOffsetY += 5;
			case SEED_PUFFSHROOM:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM);
				aOffsetY += 10;

				aOffsetX += 7;
			case SEED_SUNSHROOM:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
				aOffsetY += 10;

				aOffsetX += 7;
			case SEED_GRAVEBUSTER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
				aOffsetY += 0;
				aOffsetX += -3;

				aScale = 0.6;
			case SEED_FUMESHROOM:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
				aOffsetY += 1;

				aScale = 0.65;
			case SEED_WALLNUT:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);

				aOffsetX += 3;
			case SEED_LEFTPEATER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_LEFTFACINGPEASHOOTER);
				aOffsetX += 4;
		}
		bufferG.pushState();
		bufferG.scale(aScale, aScale);
		bufferG.drawImage(aPlantImg, aOffsetX, aOffsetY);
		bufferG.popState();
		if (!mBoard.HasConveyorBeltSeedBank()) {
			aCost = mBoard.GetCurrentPlantCost(this.mPacketType);
			width = Std.int(this.mSeedPacketFont.stringWidth(Std.string(aCost)));
			height = Std.int(this.mSeedPacketFont.getAscent());
			aTextOffsetX = 30 - width;
			aTextOffsetY = 40 + height;
			this.mSeedPacketFont.setColor(1, 0, 0, 0);
			bufferG.setFont(this.mSeedPacketFont);
			bufferG.drawString(Std.string(aCost), aTextOffsetX, aTextOffsetY);
		}
	}

	public function SlotMachineStart() {}

	public function Activate() {
		this.mActive = true;
	}

	public function Draw(g:Graphics2D) {
		if (!mVisible) {
			return;
		}
		if (this.mUpdateImage) {
			this.mUpdateImage = false;
			this.drawBufferedImage(g);
		}
		var aPercentDark:Float = 0;
		if (!this.mActive) {
			if (this.mRefreshTime == 0) {
				aPercentDark = 1;
			} else {
				aPercentDark = (this.mRefreshTime - this.mRefreshCounter) / this.mRefreshTime;
			}
		}
		var aUseSeedType = this.mPacketType;
		var aDrawCost = true;
		g.pushState();
		if (mBoard.HasConveyorBeltSeedBank()) {
			g.setClipRect(2, 0, 380, 405);
			aDrawCost = false;
		}
		var aCost = mBoard.GetCurrentPlantCost(this.mPacketType);
		var aGrayness:Float = 1;
		if (mBoard.mGameScene != PVZApp.SCENE_PLAYING) {
			aGrayness = 0.5;
			aPercentDark = 0;
		} else if (mBoard.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER
			&& mBoard.mTutorialTimer == -1
			&& this.mPacketType == SEED_PEASHOOTER) {
			aGrayness = TodCommon.GetFlashingColor(mBoard.mMainCounter, 75).red;
		} else if (mBoard.mTutorialState == TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER && this.mPacketType == SEED_SUNFLOWER) {
			aGrayness = TodCommon.GetFlashingColor(mBoard.mMainCounter, 75).red;
		} else if (mBoard.mTutorialState == TUTORIAL_MORESUN_PICK_UP_SUNFLOWER && this.mPacketType == SEED_SUNFLOWER) {
			aGrayness = TodCommon.GetFlashingColor(mBoard.mMainCounter, 75).red;
		} else if (mBoard.mEasyPlantingCheat) {
			aGrayness = 1;
			aPercentDark = 0;
		} else if (!mBoard.CanTakeSunMoney(aCost) && aDrawCost) {
			aGrayness = 0.5;
		} else if (aPercentDark > 0) {
			aGrayness = 0.5;
		}
		this.mBufferedImage.useColor = true;
		this.mBufferedImage.setColor(1, aGrayness, aGrayness, aGrayness);
		g.drawImage(this.mBufferedImage, mX + this.mOffsetX, mY);
		g.setClipRect(mX + this.mOffsetX, mY, this.mBufferedImage.width, this.mBufferedImage.height * aPercentDark, false);
		this.mBufferedImage.useColor = true;
		this.mBufferedImage.setColor(1, 0.25, 0.25, 0.25);
		g.drawImage(this.mBufferedImage, mX + this.mOffsetX, mY);
		g.popState();
	}

	public function SetPacketType(theSeedType:Int) {}

	public function GetRefreshTime(thePacketType:Int):Int {
		var aRefreshTime = 0;
		switch (thePacketType) {
			case SEED_PEASHOOTER | SEED_SUNFLOWER | SEED_REPEATER | SEED_SNOWPEA | SEED_CHOMPER | SEED_PUFFSHROOM | SEED_GRAVEBUSTER | SEED_FUMESHROOM |
				SEED_SUNSHROOM:
				aRefreshTime = 750;
			case SEED_CHERRYBOMB:
				aRefreshTime = 5000;
			case SEED_WALLNUT | SEED_SQUASH:
				aRefreshTime = 3000;
			default:
				aRefreshTime = 750;
		}
		return aRefreshTime;
	}

	public function CanPickUp():Bool {
		if (mBoard.mPaused || mBoard.mGameScene != Board.SCENE_PLAYING) {
			return false;
		}
		if (this.mPacketType == SEED_NONE) {
			return false;
		}
		if (mBoard.mEasyPlantingCheat) {
			return true;
		}
		var aUseSeedType = this.mPacketType;
		if (!this.mActive) {
			return false;
		}
		var aCost = mBoard.GetCurrentPlantCost(this.mPacketType);
		if (!mBoard.CanTakeSunMoney(aCost) && !mBoard.HasConveyorBeltSeedBank()) {
			return false;
		}
		return true;
	}
}
