package com.popcap.flash.games.pvz.logic.plants;

import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopQueue;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.logic.TodCommon;
import com.popcap.flash.games.pvz.resources.PVZReanims;

class SunShroom extends CPlant {
	static inline final COIN_NONE = "none";

	static inline final COIN_MOTION_FROM_SKY = "from sky";

	static inline final COIN_MOTION_FROM_PLANT = "from plant";

	static inline final COIN_SMALLSUN = "small sun";

	static inline final COIN_MOTION_FROM_SKY_SLOW = "from sky slow";

	static inline final COIN_SUN = "sun";

	public function new(theGridX:Int, theGridY:Int, theSeedType:Int, app:PVZApp, theBoard:Board) {
		super();
		// super();
		this.app = app;
		mBoard = theBoard;
		mPlantCol = theGridX;
		mRow = theGridY;
		if (mBoard != null) {
			mX = mBoard.GridToPixelX(theGridX, theGridY);
			mY = mBoard.GridToPixelY(theGridX, theGridY);
		}
		mAnimCounter = 0;
		mAnimPing = true;
		mFrame = 0;
		mShootingCounter = 0;
		mFrameLength = 18;
		mNumFrames = 5;
		mState = CPlant.STATE_SUNSHROOM_SMALL;
		mDead = false;
		mSquished = false;
		mSeedType = theSeedType;
		mPlantHealth = 300;
		mDoSpecialCountdown = 0;
		mDisappearCountdown = 200;
		mTargetX = -1;
		mTargetY = -1;
		mStateCountdown = 120 * CPlant.TICKS_PER_SECOND;
		mStartRow = mRow;
		mBlinkCountdown = 0;
		mRecentlyEatenCountdown = 0;
		mEatenFlashCountdown = 0;
		mWidth = 54;
		mHeight = 54;
		if (IsNocturnal(mSeedType) && mBoard != null && !mBoard.StageIsNight()) {
			SetSleeping(true);
		}
		mLaunchRate = 2500;
		mLaunchCounter = TodCommon.RandRangeInt(0, mLaunchRate);
		mBodyReanimation = app.reanimator.createReanimation(PVZReanims.REANIM_SUNSHROOM);
		mBodyReanimation.animRate = TodCommon.RandRangeFloat(15, 20);
		mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ALWAYS;
		mBodyReanimation.currentTrack = "anim_idle";
		if (IsInPlay()) {
			mX += Std.int(Math.random() * 6 - 3);
			mY += Std.int(Math.random() * 4 - 2);
		}
	}

	override public function Animate() {
		var maxTime = 0;
		if (mRecentlyEatenCountdown > 0) {
			--mRecentlyEatenCountdown;
		}
		if (mEatenFlashCountdown > 0) {
			--mEatenFlashCountdown;
		}
		if (mSquished) {
			mFrame = 0;
			return;
		}
		UpdateBlink();
		if (mAnimPing) {
			maxTime = mFrameLength * mNumFrames - 1;
			if (mAnimCounter < maxTime) {
				++mAnimCounter;
			} else {
				mAnimPing = false;
				mAnimCounter -= mFrameLength;
			}
		} else if (mAnimCounter > 0) {
			--mAnimCounter;
		} else {
			mAnimPing = true;
			mAnimCounter += mFrameLength;
		}
		mFrame = Std.int(mAnimCounter / mFrameLength);
	}

	override public function Update() {
		if (mBoard.mGameScene == Board.SCENE_ZOMBIES_WON
			|| mBoard.mGameScene == Board.SCENE_AWARD
			|| mBoard.mGameScene == Board.SCENE_LEVEL_INTRO) {
			return;
		}
		this.UpdateAbilities();
		this.Animate();
		if (mPlantHealth < 0) {
			Die();
		}
		UpdateReanimColor();
		UpdateReanim();
	}

	public function UpdateSunShroom() {
		var anArray:Array<ASAny> = null;
		if (mState == CPlant.STATE_SUNSHROOM_SMALL) {
			if (mStateCountdown == 0) {
				mBodyReanimation.currentTrack = "anim_grow";
				anArray = ["anim_bigidle"];
				mBodyReanimation.loopType = new ReanimLoopQueue(anArray);
				mBodyReanimation.animRate = 12;
				mState = CPlant.STATE_SUNSHROOM_GROWING;
				app.foleyManager.playFoley(PVZFoleyType.PLANTGROW);
			}
			this.UpdateProductionPlant();
		} else if (mState == CPlant.STATE_SUNSHROOM_GROWING) {
			if (mBodyReanimation.currentTrack == "anim_bigidle") {
				mBodyReanimation.animRate = TodCommon.RandRangeFloat(12, 15);
				mState = CPlant.STATE_SUNSHROOM_BIG;
			}
		} else {
			this.UpdateProductionPlant();
		}
	}

	public function UpdateProductionPlant() {
		var aLightUpAmount = 0;
		if (mBoard.HasLevelAwardDropped()) {
			return;
		}
		--mLaunchCounter;
		if (mLaunchCounter <= 100) {
			aLightUpAmount = TodCommon.TodAnimateCurve(100, 0, mLaunchCounter, 0, 100, TodCommon.CURVE_LINEAR);
			mEatenFlashCountdown = Std.int(Math.max(mEatenFlashCountdown, aLightUpAmount));
		}
		if (mLaunchCounter <= 0) {
			mLaunchCounter = TodCommon.RandRangeInt(mLaunchRate - 150, mLaunchRate);
			app.foleyManager.playFoley(PVZFoleyType.SPAWN_SUN);
			if (mState == CPlant.STATE_SUNSHROOM_SMALL) {
				mBoard.AddCoin(mX, mY, COIN_SMALLSUN, COIN_MOTION_FROM_PLANT);
			} else {
				mBoard.AddCoin(mX, mY, COIN_SUN, COIN_MOTION_FROM_PLANT);
			}
		}
	}

	public function UpdateAbilities() {
		if (!IsInPlay()) {
			return;
		}
		if (mStateCountdown > 0) {
			--mStateCountdown;
		}
		this.UpdateSunShroom();
		this.UpdateProductionPlant();
	}
}
