package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.resources.particles.ParticleSystem;
import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import com.popcap.flash.games.pvz.resources.PVZImages;
import com.popcap.flash.games.pvz.resources.PVZParticles;
import com.popcap.flash.games.pvz.resources.PVZReanims;
import flash.display.BitmapData;
import flash.geom.Matrix;

class Coin extends GameObject {
	public static inline final CURVE_WEAK_FAST_IN_OUT = 8;

	public static inline final COIN_DYNAMITE = "dynamite";

	static inline final OBJECT_TYPE_PLANT = 1;

	public static inline final SEED_PUFFSHROOM = 8;

	static inline final OBJECT_TYPE_PROJECTILE = 2;

	public static inline final CURVE_SIN_WAVE = 12;

	public static inline final CURVE_BOUNCE_FAST_MIDDLE = 10;

	public static inline final CURVE_CONSTANT = 0;

	public static inline final CURVE_LINEAR = 1;

	public static inline final SEED_REPEATER = 7;

	public static inline final COIN_MOTION_FROM_SKY_SLOW = "from sky slow";

	public static inline final CURVE_EASE_IN_OUT = 4;

	static inline final OBJECT_TYPE_NONE = 0;

	public static inline final SEED_WALLNUT = 3;

	public static inline final SEED_FUMESHROOM = 10;

	public static inline final CURVE_EASE_IN = 2;

	public static inline final COIN_MOTION_FROM_SKY = "from sky";

	public static inline final COIN_NONE = "none";

	public static inline final SEED_PEASHOOTER = 0;

	public static inline final COIN_SHOVEL = "shovel";

	public static inline final SEED_SUNSHROOM = 9;

	public static inline final SEED_EXPLODE_O_NUT = 50;

	public static inline final SEED_SUNFLOWER = 1;

	public static inline final SEED_SNOWPEA = 5;

	public static inline final COIN_USABLE_SEED_PACKET = "usableseedpacket";

	public static inline final SEED_GRAVEBUSTER = 11;

	public static inline final SEED_NONE = -1;

	static inline final BOARD_HEIGHT = 405;

	static inline final OBJECT_TYPE_SHOVEL = 5;

	public static inline final SEED_CHERRYBOMB = 2;

	public static inline final CURVE_EASE_OUT = 3;

	public static inline final CURVE_FAST_IN_OUT_WEAK = 7;

	public static inline final CURVE_BOUNCE_SLOW_MIDDLE = 11;

	public static inline final SEED_SQUASH = 4;

	public static inline final COIN_SMALLSUN = "small sun";

	public static inline final COIN_MOTION_COIN = "coin";

	static inline final OBJECT_TYPE_SEEDPACKET = 4;

	public static inline final COIN_NOTE = "note";

	public static inline final CURVE_EASE_SIN_WAVE = 13;

	public static inline final CURVE_FAST_IN_OUT = 6;

	public static inline final CURVE_EASE_IN_OUT_WEAK = 5;

	public static inline final SEED_LEFTPEATER = 49;

	static inline final BOARD_WIDTH = 540;

	public static inline final SEED_CHOMPER = 6;

	public static inline final COIN_MOTION_FROM_PLANT = "from plant";

	static inline final OBJECT_TYPE_COIN = 3;

	public static inline final CURVE_BOUNCE = 9;

	public static inline final COIN_PRESENT_PLANT = "presentplant";

	public static inline final COIN_SUN = "sun";

	public static inline final COIN_FINAL_SEED_PACKET = "finalseedpacket";

	public var mCollectionDistance:Float = Math.NaN;

	public var mCoinAge:Int = 0;

	public var mReanimation:Reanimation;

	public var mGroundY:Int = 0;

	public var mFadeCount:Int = 0;

	public var mHitGround:Bool = false;

	public var mPosX:Float = Math.NaN;

	public var mPosY:Float = Math.NaN;

	var mZombieNote:ImageInst;

	public var mBouncyArrow:ParticleSystem;

	public var mIsBeingCollected:Bool = false;

	public var mHasBouncyArrow:Bool = false;

	public var mTimesDropped:Int = 0;

	var mSeedEffect:ParticleSystem;

	public var mUsableSeedType:Int = 0;

	public var mExplode:Int = 0;

	public var mType:String;

	var mShovelImage:ImageInst;

	var mBufferedImage:ImageInst;

	public var mScale:Float = Math.NaN;

	public var mDisappearCounter:Int = 0;

	public var mVelX:Float = Math.NaN;

	public var mVelY:Float = Math.NaN;

	public var mDead:Bool = false;

	public var mCoinMotion:String;

	public var mCollectX:Float = Math.NaN;

	public var mCollectY:Float = Math.NaN;

	public var mNeedsBouncyArrow:Bool = false;

	var mScaleMatrix:Matrix;

	public function new() {
		super();
		this.mScaleMatrix = new Matrix();
		// super();
	}

	public function GetDisappearTime():Int {
		var aDisappearTime = 750;
		if (this.mHasBouncyArrow) {
			aDisappearTime = 1500;
		}
		if (app.IsScaryPotterLevel()) {
			if (this.mType == COIN_USABLE_SEED_PACKET) {
				aDisappearTime = 1500;
			}
		}
		return aDisappearTime;
	}

	public function UpdateFall() {
		var aParticleOffsetX = Math.NaN;
		var aParticleOffsetY = Math.NaN;
		var aDisappearTime = 0;
		var aFinalScale = Math.NaN;
		if (this.mType == COIN_FINAL_SEED_PACKET) {}
		if (this.mType == COIN_FINAL_SEED_PACKET) {}
		if (this.mPosY + this.mVelY < this.mGroundY) {
			this.mPosY += this.mVelY;
			if (this.mCoinMotion == COIN_MOTION_FROM_PLANT) {
				this.mVelY += 0.09;
			} else if (this.mCoinMotion == COIN_MOTION_COIN) {
				this.mVelY += 0.15;
			}
			this.mPosX += this.mVelX;
			if (this.mPosX > BOARD_WIDTH - mWidth) {
				this.mPosX = BOARD_WIDTH - mWidth;
				this.mVelX = -0.4 - Math.random() * 0.4;
			} else if (this.mPosX < 0) {
				this.mPosX = 0;
				this.mVelX = 0.4 + Math.random() * 0.4;
			}
		} else {
			aParticleOffsetX = mWidth / 2 * this.mScale + 17;
			aParticleOffsetY = mHeight / 2 * this.mScale - 15;
			if (this.mType == COIN_SHOVEL || this.mType == COIN_NOTE) {
				aParticleOffsetX -= 20;
				aParticleOffsetY -= 30;
			}
			if (this.mNeedsBouncyArrow && !this.mHasBouncyArrow) {
				this.mBouncyArrow = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SEEDPACKET);
				this.mBouncyArrow.setPosition(this.mPosX + aParticleOffsetX, this.mPosY + aParticleOffsetY);
				mBoard.mRenderManager.add(new ParticleRenderable(this.mBouncyArrow, GameObject.RENDER_LAYER_PARTICLE));
				this.mHasBouncyArrow = true;
			}
			if (!this.mHitGround) {
				this.mHitGround = true;
			}
			this.mPosY = this.mGroundY;
			if (!this.IsLevelAward()) {
				++this.mDisappearCounter;
				aDisappearTime = this.GetDisappearTime();
				if (this.mDisappearCounter >= aDisappearTime) {
					this.StartFade();
				}
			}
		}
		if (this.mCoinMotion == COIN_MOTION_FROM_PLANT) {
			aFinalScale = 1;
			if (this.mScale < aFinalScale) {
				this.mScale += 0.02;
			} else {
				this.mScale = aFinalScale;
			}
		}
	}

	public function MouseHitTest(theX:Int, theY:Int, theHitResult:HitResult):Bool {
		var aResult = false;
		var aOffsetX = 0;
		var aOffsetY = 0;
		if (this.mType == COIN_DYNAMITE) {
			return false;
		}
		if (this.mType == COIN_FINAL_SEED_PACKET) {
			aOffsetX = Std.int((mWidth - mWidth * this.mScale) * 0.5);
			aOffsetY = Std.int((mHeight - mHeight * this.mScale) * 0.5);
		}
		var aExtraClickSize = 0;
		var aExtraClickHeight = 0;
		if (this.mType == COIN_SUN) {
			aExtraClickSize = 15;
		}
		if (this.mDead) {
			aResult = false;
		} else if (this.mIsBeingCollected) {
			aResult = false;
		} else if (this.mType == COIN_USABLE_SEED_PACKET
			&& mBoard != null
			&& mBoard.mCursorObject.mCursorType != Board.CURSOR_TYPE_NORMAL) {
			aResult = false;
		} else if (theX >= this.mPosX - aExtraClickSize + aOffsetX
			&& theX < this.mPosX
			+ mWidth * this.mScale
			+ aExtraClickSize
			+ aOffsetX && theY >= this.mPosY + aOffsetY - aExtraClickSize
			&& theY < this.mPosY
			+ mHeight * this.mScale
			+ aOffsetY
			+ aExtraClickSize
			+ aExtraClickHeight) {
			aResult = true;
		} else {
			aResult = false;
		}
		if (aResult) {
			theHitResult.mObject = this;
			theHitResult.mObjectType = OBJECT_TYPE_COIN;
			return true;
		}
		theHitResult.mObject = null;
		theHitResult.mObjectType = OBJECT_TYPE_NONE;
		return false;
	}

	public function IsPresentWithAdvice():Bool {
		return false;
	}

	public function UpdateFade() {
		if (this.mType != COIN_NOTE) {
			if (this.IsLevelAward()) {
				return;
			}
		}
		--this.mFadeCount;
		if (this.mFadeCount == 0) {
			this.Die();
		}
	}

	public function ScoreCoin() {
		var aSunValue = 0;
		if (this.IsSun()) {
			aSunValue = this.GetSunValue();
			this.mIsBeingCollected = false;
			mBoard.AddSunMoney(aSunValue);
		}
		this.Die();
	}

	public function Die() {
		this.mDead = true;
		if (this.mReanimation != null) {
			this.mReanimation.mIsDead = true;
		}
	}

	public function CoinInitialize(theX:Int, theY:Int, theCoinType:String, theCoinMotion:String, app:PVZApp, theBoard:Board) {
		var aReanim:Reanimation = null;
		this.app = app;
		mBoard = theBoard;
		this.mDead = false;
		this.mType = theCoinType;
		this.mPosX = theX;
		this.mPosY = theY;
		mWidth = 40;
		mHeight = 40;
		this.mDisappearCounter = 0;
		this.mIsBeingCollected = false;
		this.mFadeCount = 0;
		this.mCoinMotion = theCoinMotion;
		this.mCoinAge = 0;
		this.mCollectionDistance = 0;
		this.mScale = 1;
		this.mUsableSeedType = SEED_NONE;
		this.mNeedsBouncyArrow = false;
		this.mHasBouncyArrow = false;
		this.mHitGround = false;
		this.mTimesDropped = 0;
		var aOffsetX = Std.int(mWidth * 0.5);
		var aOffsetY = Std.int(mHeight * 0.5);
		if (this.IsSun()) {
			aReanim = app.reanimator.createReanimation("REANIM_SUN");
			aReanim.x = this.mPosX + aOffsetX;
			aReanim.y = this.mPosY + aOffsetY;
			aReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
			aReanim.animRate = 6;
			aReanim.currentTrack = "Sun1";
			this.mReanimation = aReanim;
		} else if (this.mType == COIN_DYNAMITE) {
			this.mPosX -= 20;
			this.mPosY -= 20;
			this.mExplode = 100;
			mWidth = 54;
			mHeight = 54;
			this.mScale = 1;
			aReanim = app.reanimator.createReanimation(PVZReanims.REANIM_DYNOMITE);
			aReanim.x = this.mPosX;
			aReanim.y = this.mPosY;
			aReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
			aReanim.animRate = 15;
			aReanim.currentTrack = "dynomite";
			this.mReanimation = aReanim;
			app.foleyManager.playFoley(PVZFoleyType.REVERSE_EXPLOSION);
		} else if (this.mType == COIN_FINAL_SEED_PACKET) {
			mWidth = 68;
			mHeight = 95;
			this.mScale = 0.5;
		} else if (this.mType == COIN_SHOVEL) {
			mWidth = 41;
			mHeight = 41;
			this.mScale = 1;
			this.mShovelImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVEL_SMALL);
		} else if (this.mType == COIN_NOTE) {
			mWidth = 53;
			mHeight = 35;
			this.mScale = 1;
			this.mZombieNote = app.imageManager.getImageInst(PVZImages.IMAGE_ZOMBIENOTESMALL);
		} else if (this.mType == COIN_USABLE_SEED_PACKET) {
			mWidth = 34;
			mHeight = 48;
			this.mScale = 0.5;
		}
		switch (this.mCoinMotion) {
			case COIN_MOTION_FROM_SKY:
				this.mVelY = 0.67;
				this.mVelX = 0;

				this.mGroundY = Std.int(Math.random() * 169 + 202);
			case COIN_MOTION_FROM_SKY_SLOW:
				this.mVelY = 0.33;
				this.mVelX = 0;

				this.mGroundY = Std.int(Math.random() * 169 + 202);
			case COIN_MOTION_FROM_PLANT:
				this.mVelY = -1.7 - Math.random() * 1.7;
				this.mVelX = -0.4 + Math.random() * 0.8;
				this.mGroundY = Std.int(this.mPosY + 10 + Math.random() * 13);

				this.mScale = 0.4;
			case COIN_MOTION_COIN:
				this.mVelY = -2.1 - Math.random() * 1.3;
				this.mVelX = -0.4 + Math.random() * 0.7;
				this.mGroundY = Std.int(this.mPosY + 30 + Math.random() * 13);
				if (this.mGroundY > BOARD_HEIGHT - 53) {
					this.mGroundY = BOARD_HEIGHT - 53;
				}
				if (this.mGroundY < 54) {
					this.mGroundY = 54;
				}
				if (this.mType == COIN_FINAL_SEED_PACKET
					|| this.mType == COIN_USABLE_SEED_PACKET
					|| this.mType == COIN_SHOVEL
					|| this.mType == COIN_NOTE) {
					this.mGroundY -= 21;
				}
				if (this.mType == COIN_DYNAMITE) {
					this.mVelX = 0;
					this.mGroundY -= 54;
				}
				if (this.mPosY > this.mGroundY) {
					this.mPosY = this.mGroundY;
				}
		}
		if (this.CoinGetsBouncyArrow()) {
			this.mNeedsBouncyArrow = true;
		}
		this.PlayLaunchSound();
	}

	public function IsSun():Bool {
		if (this.mType == COIN_SUN || this.mType == COIN_SMALLSUN) {
			return true;
		}
		return false;
	}

	public function IsLevelAward():Bool {
		if (this.mType == COIN_FINAL_SEED_PACKET || this.mType == COIN_SHOVEL || this.mType == COIN_NOTE) {
			return true;
		}
		return false;
	}

	public function Collect() {
		var anEffect:ParticleSystem = null;
		var aParticleOffsetX = Math.NaN;
		var aParticleOffsetY = Math.NaN;
		var i = 0;
		var aSeedPacket:SeedPacket = null;
		var aCost = 0;
		var aAmountOver = 0;
		if (this.mDead) {
			return;
		}
		this.mCollectX = this.mPosX;
		this.mCollectY = this.mPosY;
		this.mIsBeingCollected = true;
		var aIsEndlessAward = false;
		if (this.IsLevelAward()) {
			if (this.mHasBouncyArrow) {
				this.mBouncyArrow.mDead = true;
			}
			if (app.IsAdventureMode() && mBoard.mLevel == 4) {
				app.foleyManager.playFoley(PVZFoleyType.SHOVEL);
			} else {
				app.foleyManager.playFoley(PVZFoleyType.SEEDLIFT);
				app.foleyManager.playFoley(PVZFoleyType.DROP);
				anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_STARBURST);
				anEffect.setPosition(this.mPosX + mWidth * this.mScale / 2, this.mPosY + mHeight * this.mScale / 2);
				mBoard.mRenderManager.add(new ParticleRenderable(anEffect, GameObject.RENDER_LAYER_SCREEN_FADE));
			}
			mBoard.FadeOutLevel();
			if (this.mType == COIN_NOTE) {
				anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_PRESENTPICKUP);
				anEffect.setPosition(this.mPosX + mWidth * this.mScale / 2, this.mPosY + mHeight * this.mScale / 2);
				mBoard.mRenderManager.add(new ParticleRenderable(anEffect));
				this.StartFade();
			} else {
				aParticleOffsetX = mWidth * this.mScale / 2;
				aParticleOffsetY = mHeight * this.mScale / 2;
				this.mSeedEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_AWARD);
				this.mSeedEffect.setPosition(this.mPosX + aParticleOffsetX, this.mPosY + aParticleOffsetY);
				mBoard.mRenderManager.add(new ParticleRenderable(this.mSeedEffect, Board.RENDER_LAYER_PARTICLE));
			}
		} else {
			if (this.mType == COIN_USABLE_SEED_PACKET) {
				mBoard.mCursorObject.mType = this.mUsableSeedType;
				mBoard.mCursorObject.mCursorType = Board.CURSOR_TYPE_PLANT_FROM_USABLE_COIN;
				mBoard.mCursorObject.mCoin = this;
				this.mGroundY = Std.int(this.mPosY);
				this.mFadeCount = 0;
				return;
			}
			if (this.IsSun() && mBoard != null && !mBoard.HasConveyorBeltSeedBank()) {
				var i:ASAny = 0;
				while (i < mBoard.mSeedBank.mNumPackets) {
					aSeedPacket = mBoard.mSeedBank.mSeedPackets[i];
					aCost = mBoard.GetCurrentPlantCost(aSeedPacket.mPacketType);
					aAmountOver = mBoard.mSunMoney + mBoard.CountSunBeingCollected() - aCost;
					if (aAmountOver >= 0 && aAmountOver < this.GetSunValue()) {
						aSeedPacket.FlashIfReady();
					}
					i++;
				}
			}
		}
	}

	public function TryAutoCollectAfterLevelAward() {
		var aCollect = false;
		if (this.IsSun()) {
			aCollect = true;
		}
		if (aCollect) {
			this.PlayCollectSound();
			this.Collect();
		}
	}

	public function PlayLaunchSound() {}

	public function CoinGetsBouncyArrow():Bool {
		if (this.IsLevelAward()) {
			return true;
		}

		return false;
	}

	public function DroppedUsableSeed() {
		this.mIsBeingCollected = false;
		if (this.mTimesDropped == 0) {
			this.mDisappearCounter = Std.int(Math.min(this.mDisappearCounter, 1200));
		}

		++this.mTimesDropped;
	}

	public function GetFinalSeedPacketType():Int {
		var aArea = Std.int((mBoard.mLevel - 1) / 10 + 1);
		var aSubArea = (mBoard.mLevel - 1) % 10 + 1;
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

	public function MouseDown(x:Int, y:Int) {
		if (mBoard == null || mBoard.mPaused || mBoard.mGameScene != Board.SCENE_PLAYING) {
			return;
		}
		if (this.mDead) {
			return;
		}
		if (!this.mIsBeingCollected) {
			if (mBoard.mLevel == 1) {
				mBoard.DisplayAdvice("[ADVICE_CLICKED_ON_SUN]", Board.MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY, Board.ADVICE_CLICKED_ON_SUN);
			}
			this.PlayCollectSound();
			this.Collect();
		}
	}

	public function GetSunValue():Int {
		if (this.mType == COIN_SMALLSUN) {
			return 15;
		}

		return 25;
	}

	public function drawBufferedImage(g:Graphics2D) {
		var aSeedType = 0;
		var aSeedBackImg:ImageInst = null;
		var aPlantImg:ImageInst = null;
		var theFont:FontInst = null;
		var aCost = 0;
		var width = 0;
		var height = 0;
		var aTextOffsetX = 0;
		var aTextOffsetY = 0;
		if (this.mType == COIN_USABLE_SEED_PACKET) {
			aSeedType = this.mUsableSeedType;
		} else {
			aSeedType = this.GetFinalSeedPacketType();
		}
		aSeedBackImg = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDPACKET_LARGER);
		var w = aSeedBackImg.width;
		var h = aSeedBackImg.height;
		this.mBufferedImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = this.mBufferedImage.graphics;
		bufferG.drawImage(aSeedBackImg, 0, 0);
		var aOffsetX:Float = 10;
		var aOffsetY:Float = 15;
		var aScale:Float = 1;
		switch (aSeedType) {
			case SEED_EXPLODE_O_NUT:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);

				aPlantImg.useColor = true;
				aPlantImg.setColor(1, 1, 64 / 255, 64 / 255);
			case SEED_PEASHOOTER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTERSINGLE);
				aOffsetY += 4;
			case SEED_SUNFLOWER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNFLOWER);

				aOffsetY += 1;
				aOffsetX += 2;
			case SEED_CHERRYBOMB:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHERRYBOMB);

				aOffsetY += 1;
				aOffsetX += -1;
			case SEED_SQUASH:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SQUASH);

				aOffsetX += 0;
				aOffsetY += -2;
			case SEED_CHOMPER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHOMPER);
				aOffsetX += -2;

				aOffsetY += -3;
				aScale = 0.85;
			case SEED_SNOWPEA:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SNOWPEA);
				aOffsetY += 3;
			case SEED_REPEATER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTER);
				aOffsetY += 5;
			case SEED_PUFFSHROOM:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM);

				aOffsetY += 12;
				aOffsetX += 9;
			case SEED_SUNSHROOM:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);

				aOffsetY += 13;
				aOffsetX += 10;
			case SEED_GRAVEBUSTER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
				aOffsetY += 1;

				aOffsetX += -5;
				aScale = 0.85;
			case SEED_FUMESHROOM:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
				aOffsetX -= 2;

				aOffsetY += 1;
				aScale = 0.95;
			case SEED_WALLNUT:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
				aOffsetX += 3;
			case SEED_LEFTPEATER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_LEFTFACINGPEASHOOTER);
				aOffsetX += 2;
				aOffsetY += 5;
		}
		bufferG.pushState();
		bufferG.scale(aScale, aScale);
		bufferG.drawImage(aPlantImg, aOffsetX, aOffsetY);
		bufferG.popState();
		if (this.mType == COIN_FINAL_SEED_PACKET) {
			theFont = app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
			theFont.scale = 1.6;
			theFont.setColor(1, 0, 0, 0);
			aCost = mBoard.GetCurrentPlantCost(aSeedType);
			width = Std.int(theFont.stringWidth(Std.string(aCost)));
			height = Std.int(theFont.getAscent());
			aTextOffsetX = 45 - width;
			aTextOffsetY = 72;
			bufferG.setFont(theFont);
			bufferG.drawString(Std.string(aCost), aTextOffsetX, aTextOffsetY);
		}
	}

	public function Draw(g:Graphics2D) {
		var aAlpha = Math.NaN;
		var aFade = 0;
		var aGray = 0;
		var aDisappearTime = 0;
		var aFlashingColor = Color.ARGB(1, 1, 1, 1);
		if (this.IsLevelAward() && !this.mIsBeingCollected) {
			aFlashingColor = TodCommon.GetFlashingColor(this.mCoinAge, 75);
		}
		var aOffsetX = Std.int(mWidth * 0.5);
		var aOffsetY = Std.int(mHeight * 0.5);
		if (this.mReanimation != null) {
			this.mReanimation.x = this.mPosX + aOffsetX;
			this.mReanimation.y = this.mPosY + aOffsetY;
			g.pushState();
			if (this.mType == COIN_SMALLSUN) {
				this.mScaleMatrix.a = this.mScale * 0.5;
				this.mScaleMatrix.d = this.mScale * 0.5;
			} else {
				this.mScaleMatrix.a = this.mScale;
				this.mScaleMatrix.d = this.mScale;
			}
			aAlpha = 1;
			if (this.IsSun() && this.mIsBeingCollected) {
				aAlpha = TodCommon.ClampFloat(this.mCollectionDistance * 0.035, 0.35, 1);
			} else if (this.mFadeCount > 0) {
				aFade = TodCommon.TodAnimateCurve(15, 0, this.mFadeCount, 255, 0, CURVE_LINEAR);
				aAlpha = aFade / 255;
			}
			this.mReanimation.drawLerp(g, this.mScaleMatrix, aAlpha);
			g.popState();
		}
		if (this.mType == COIN_SUN || this.mType == COIN_SMALLSUN || this.mDead || this.mType == COIN_DYNAMITE) {
			return;
		}
		if (this.mType == COIN_FINAL_SEED_PACKET) {
			aOffsetX = Std.int((mWidth - mWidth * this.mScale) * 0.5);
			aOffsetY = Std.int((mHeight - mHeight * this.mScale) * 0.5);
			if (this.mBufferedImage == null) {
				this.drawBufferedImage(g);
			}
			g.pushState();
			this.mBufferedImage.useColor = true;
			this.mBufferedImage.setColor(aFlashingColor.alpha, aFlashingColor.red, aFlashingColor.green, aFlashingColor.blue);
			g.scale(this.mScale, this.mScale);
			g.drawImage(this.mBufferedImage, this.mPosX + aOffsetX, this.mPosY + aOffsetY);
			g.popState();
			return;
		}
		if (this.mType == COIN_SHOVEL) {
			g.pushState();
			g.scale(this.mScale, this.mScale);
			this.mShovelImage.useColor = true;
			this.mShovelImage.setColor(aFlashingColor.alpha, aFlashingColor.red, aFlashingColor.green, aFlashingColor.blue);
			g.drawImage(this.mShovelImage, this.mPosX, this.mPosY);
			g.popState();
		} else if (this.mType == COIN_NOTE) {
			g.pushState();
			g.scale(this.mScale, this.mScale);
			this.mZombieNote.useColor = true;
			this.mZombieNote.setColor(aFlashingColor.alpha, aFlashingColor.red, aFlashingColor.green, aFlashingColor.blue);
			g.drawImage(this.mZombieNote, this.mPosX, this.mPosY);
			g.popState();
		} else if (this.mType == COIN_USABLE_SEED_PACKET) {
			aGray = 255;
			if (this.mIsBeingCollected) {
				aGray = 128;
			} else {
				aDisappearTime = this.GetDisappearTime();
				if (this.mDisappearCounter > aDisappearTime - 300 && this.mDisappearCounter % 60 < 30) {
					aGray = 192;
				}
			}
			if (this.mBufferedImage == null) {
				this.drawBufferedImage(g);
			}
			g.pushState();
			this.mBufferedImage.useColor = true;
			this.mBufferedImage.setColor(1, aGray / 255, aGray / 255, aGray / 255);
			g.scale(0.5, 0.5);
			g.drawImage(this.mBufferedImage, this.mPosX, this.mPosY);
			g.popState();
			return;
		}
	}

	public function StartFade() {
		this.mFadeCount = 15;
	}

	public function UpdateCollected() {
		var aDestX = 0;
		var aDestY = 0;
		if (this.mType == COIN_FINAL_SEED_PACKET) {}
		if (this.IsSun()) {
			aDestX = 16;
			aDestY = 3;
		} else {
			if (this.mType == COIN_USABLE_SEED_PACKET) {
				++this.mDisappearCounter;
				return;
			}
			if (this.IsLevelAward()) {
				if (this.mType == COIN_SHOVEL) {
					aDestX = 250;
					aDestY = 115;
				} else {
					aDestX = 236;
					aDestY = 87;
				}
				++this.mDisappearCounter;
			}
		}
		if (this.IsLevelAward()) {
			if (this.mType == COIN_SHOVEL) {
				this.mScale = TodCommon.TodAnimateCurveFloat(0, 270, this.mDisappearCounter, 1, 1, TodCommon.CURVE_EASE_IN_OUT);
			} else {
				this.mScale = TodCommon.TodAnimateCurveFloat(0, 270, this.mDisappearCounter, 0.51, 1, TodCommon.CURVE_EASE_IN_OUT);
			}
			this.mPosX = TodCommon.TodAnimateCurveFloat(0, 236, this.mDisappearCounter, this.mCollectX, aDestX, TodCommon.CURVE_EASE_OUT);
			this.mPosY = TodCommon.TodAnimateCurveFloat(0, 236, this.mDisappearCounter, this.mCollectY, aDestY, TodCommon.CURVE_EASE_OUT);
			return;
		}
		var aDeltaX = Math.abs(this.mPosX - aDestX);
		var aDeltaY = Math.abs(this.mPosY - aDestY);
		if (this.mPosX > aDestX) {
			this.mPosX -= aDeltaX / 21;
		} else if (this.mPosX < aDestX) {
			this.mPosX += aDeltaX / 21;
		}
		if (this.mPosY > aDestY) {
			this.mPosY -= aDeltaY / 21;
		} else if (this.mPosY < aDestY) {
			this.mPosY += aDeltaY / 21;
		}
		this.mCollectionDistance = Math.sqrt(aDeltaY * aDeltaY + aDeltaX * aDeltaX);
		var aScoringDistance:Float = 8;
		if (this.mCollectionDistance < aScoringDistance) {
			this.ScoreCoin();
		}
		this.mScale = TodCommon.ClampFloat(this.mCollectionDistance * 0.05, 0.5, 1);

		this.mScale *= 1;
	}

	public function Update() {
		var anEffect:ParticleSystem = null;
		if (mBoard.mGameScene == Board.SCENE_ZOMBIES_WON
			|| mBoard.mGameScene == Board.SCENE_AWARD
			|| mBoard.mGameScene == Board.SCENE_LEVEL_INTRO) {
			return;
		}
		if (this.mExplode > 0) {
			--this.mExplode;
			if (this.mExplode == 0) {
				app.foleyManager.playFoley(PVZFoleyType.CHERRYBOMB);
				app.foleyManager.playFoley(PVZFoleyType.JUICY);
				anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_POWIE);
				anEffect.setPosition(this.mPosX + 40, this.mPosY + 50);
				mBoard.mRenderManager.add(new ParticleRenderable(anEffect, Board.RENDER_LAYER_PARTICLE));
				mBoard.ShakeBoard(10, -15);
				mBoard.mChallenge.ScaryPotterJackExplode(Std.int(this.mPosX + 40), Std.int(this.mPosY + 50));
				mBoard.KillAllPlantsInRadius(Std.int(this.mPosX + 40), Std.int(this.mPosY + 50), 90);
				this.Die();
			}
		}
		++this.mCoinAge;
		if (this.mReanimation != null) {
			this.mReanimation.update();
		}
		if (mBoard.mGameScene != Board.SCENE_PLAYING && mBoard.mGameScene != Board.SCENE_AWARD) {
			return;
		}
		if (this.mFadeCount > 0) {
			this.UpdateFade();
		} else if (!this.mIsBeingCollected) {
			this.UpdateFall();
		} else {
			this.UpdateCollected();
		}
		var aParticleOffsetX = mWidth / 2;
		var aParticleOffsetY = mHeight / 2;
		if (this.mSeedEffect != null) {
			this.mSeedEffect.setPosition(this.mPosX + aParticleOffsetX, this.mPosY + aParticleOffsetY);
		}
	}

	public function PlayCollectSound() {
		if (this.IsSun()) {
			app.foleyManager.playFoley(PVZFoleyType.SUN);
		} else if (this.mType == COIN_USABLE_SEED_PACKET) {
			app.foleyManager.playFoley(PVZFoleyType.SEEDLIFT);
		}
	}
}
