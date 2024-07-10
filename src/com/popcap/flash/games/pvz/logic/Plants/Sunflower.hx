package com.popcap.flash.games.pvz.logic.Plants;

import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.logic.TodCommon;
import com.popcap.flash.games.pvz.resources.PVZReanims;

class Sunflower extends CPlant {
	static inline final COIN_NONE = "none";

	static inline final COIN_MOTION_FROM_SKY = "from sky";

	static inline final COIN_MOTION_FROM_PLANT = "from plant";

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
		mDead = false;
		mSquished = false;
		mSeedType = theSeedType;
		mPlantHealth = 300;
		mDoSpecialCountdown = 0;
		mDisappearCountdown = 200;
		mTargetX = -1;
		mTargetY = -1;
		mStateCountdown = 0;
		mStartRow = mRow;
		mBlinkCountdown = 0;
		mRecentlyEatenCountdown = 0;
		mEatenFlashCountdown = 0;
		mHighlighted = false;
		mWidth = 54;
		mHeight = 54;
		mLaunchRate = 2500;
		mReanimationType = CPlant.REANIM_SUNFLOWER;
		var aBodyReanim = app.reanimator.createReanimation(PVZReanims.REANIM_SUNFLOWER);
		aBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
		aBodyReanim.animRate = TodCommon.RandRangeFloat(10, 15);
		aBodyReanim.currentTrack = "anim_idle";
		mBodyReanimation = aBodyReanim;
		mLaunchCounter = TodCommon.RandRangeInt(300, Std.int(mLaunchRate / 2));
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
		UpdateReanimColor();
		UpdateReanim();
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
			mBoard.AddCoin(mX, mY, COIN_SUN, COIN_MOTION_FROM_PLANT);
		}
	}

	public function UpdateAbilities() {
		if (!IsInPlay()) {
			return;
		}
		if (mStateCountdown > 0) {
			--mStateCountdown;
		}
		this.UpdateProductionPlant();
		if (mDoSpecialCountdown > 0) {
			--mDoSpecialCountdown;
			if (mDoSpecialCountdown == 0) {}
		}
	}
}
