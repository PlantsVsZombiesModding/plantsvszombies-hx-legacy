package com.popcap.flash.games.pvz.logic.Plants;

import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopOnceAndIdle;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.logic.Projectile;
import com.popcap.flash.games.pvz.logic.TodCommon;
import com.popcap.flash.games.pvz.logic.zombies.Zombie;
import com.popcap.flash.games.pvz.resources.PVZReanims;

class LeftPeater extends CPlant {
	public function new(theGridX:Int, theGridY:Int, theSeedType:Int, app:PVZApp, theBoard:Board) {
		super();
		// super();
		this.app = app;
		mBoard = theBoard;
		mPlantCol = theGridX;
		mRow = theGridY;
		if (mBoard != null) {
			mX = mBoard.GridToPixelX(theGridX, theGridY) - 20;
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
		mWidth = 54;
		mHeight = 54;
		mLaunchRate = 150;
		mReanimationType = CPlant.REANIM_PEASHOOTER;
		mBodyReanimation = app.reanimator.createReanimation(PVZReanims.REANIM_LEFTPEATER);
		mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ALWAYS;
		mBodyReanimation.currentTrack = "anim_idle";
		mLaunchCounter = TodCommon.RandRangeInt(0, mLaunchRate);
		if (mBodyReanimation != null) {
			mBodyReanimation.animRate = TodCommon.RandRangeFloat(15, 20);
			mHeadReanimation = app.reanimator.createReanimation(PVZReanims.REANIM_LEFTPEATER);
			mHeadReanimation.loopType = Reanimation.LOOP_TYPE_ALWAYS;
			mHeadReanimation.animRate = mBodyReanimation.animRate;
			mHeadReanimation.currentTrack = "anim_head_idle";
			mBodyReanimation.attachReanimation(mHeadReanimation, "anim_stem");
		}
		mPlantMaxHealth = mPlantHealth;
	}

	override public function Update() {
		if (mBoard.mGameScene == Board.SCENE_ZOMBIES_WON
			|| mBoard.mGameScene == Board.SCENE_AWARD
			|| mBoard.mGameScene == Board.SCENE_LEVEL_INTRO) {
			return;
		}
		this.UpdateShooting();
		this.UpdateShooter();
		this.Animate();
		if (mPlantHealth < 0) {
			Die();
		}
		UpdateReanimColor();
		UpdateReanim();
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

	public function FindTargetAndFire(theRow:Int, thePlantWeapon:Int):Bool {
		var aZombie = FindTargetZombie(theRow, thePlantWeapon);
		if (aZombie == null) {
			return false;
		}
		var idleRate = TodCommon.RandRangeFloat(15, 20);
		mHeadReanimation.animRate = 35;
		mHeadReanimation.currentTrack = "anim_shooting";
		mHeadReanimation.loopType = new ReanimLoopOnceAndIdle("anim_head_idle", mBodyReanimation.animRate);
		mShootingCounter = 35;
		if (mSeedType == CPlant.SEED_REPEATER || mSeedType == CPlant.SEED_LEFTPEATER) {
			mHeadReanimation.animRate = 45;
			mShootingCounter = 26;
		}
		return true;
	}

	public function UpdateShooter() {
		--mLaunchCounter;
		if (mLaunchCounter <= 0) {
			mLaunchCounter = Std.int(mLaunchRate - Math.random() * 15);
			this.FindTargetAndFire(mRow, CPlant.WEAPON_PRIMARY);
		}
		if (mLaunchCounter == 25) {
			if (mSeedType == CPlant.SEED_REPEATER || mSeedType == CPlant.SEED_LEFTPEATER) {
				this.FindTargetAndFire(mRow, CPlant.WEAPON_PRIMARY);
			}
		}
	}

	public function Fire(theTargetZombie:Zombie, theRow:Int, thePlantWeapon:Int) {
		var aProjectileType = 0;
		var aOriginX = 0;
		var aOriginY = 0;
		var aOffsetX = 0;
		var aOffsetY = 0;
		switch (mSeedType) {
			case CPlant.SEED_LEFTPEATER:
				aProjectileType = CPlant.PROJECTILE_PEA;
			case CPlant.SEED_PEASHOOTER:
				aProjectileType = CPlant.PROJECTILE_PEA;
			case CPlant.SEED_REPEATER:
				aProjectileType = CPlant.PROJECTILE_PEA;
			case CPlant.SEED_SNOWPEA:
				aProjectileType = CPlant.PROJECTILE_SNOWPEA;
		}
		app.foleyManager.playFoley(PVZFoleyType.THROW);
		if (mSeedType == CPlant.SEED_SNOWPEA) {}
		if (mSeedType == CPlant.SEED_PEASHOOTER || mSeedType == CPlant.SEED_SNOWPEA || mSeedType == CPlant.SEED_REPEATER || mSeedType == CPlant.SEED_LEFTPEATER) {
			this.GetPeaHeadOffset(aOffsetX, aOffsetY);
			aOriginX = mX + aOffsetX + 20;
			aOriginY = mY + aOffsetY + 5;
		}
		var aProjectile = mBoard.AddProjectile(aOriginX, aOriginY, mRenderOrder, theRow, aProjectileType);
		if (mSeedType == CPlant.SEED_LEFTPEATER) {
			aProjectile.mMotionType = Projectile.MOTION_BACKWARDS;
		}
	}

	public function GetPeaHeadOffset(theOffsetX:Int, theOffsetY:Int) {}

	public function UpdateShooting() {
		if (mShootingCounter == 0) {
			return;
		}
		--mShootingCounter;
		if (mShootingCounter == 1) {
			this.Fire(null, mRow, CPlant.WEAPON_PRIMARY);
		}
		if (mShootingCounter != 0) {
			return;
		}
		mShootingCounter = 1;
	}
}
