package com.popcap.flash.games.pvz.login.plants;

import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopOnceAndIdle;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.logic.TodCommon;
import com.popcap.flash.games.pvz.logic.zombies.Zombie;
import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
import com.popcap.flash.games.pvz.resources.PVZParticles;
import com.popcap.flash.games.pvz.resources.PVZReanims;

class PuffShroom extends CPlant {
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
		mState = CPlant.STATE_NOTREADY;
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
		if (IsNocturnal(mSeedType) && mBoard != null && !mBoard.StageIsNight()) {
			SetSleeping(true);
		}
		mLaunchCounter = TodCommon.RandRangeInt(0, mLaunchRate);
		mBodyReanimation = app.reanimator.createReanimation(PVZReanims.REANIM_PUFFSHROOM);
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

	public function FindTargetAndFire(theRow:Int, thePlantWeapon:Int):Bool {
		var aZombie = FindTargetZombie(theRow, thePlantWeapon);
		if (aZombie == null) {
			return false;
		}
		var idleRate = TodCommon.RandRangeFloat(15, 20);
		mBodyReanimation.animRate = 35;
		mBodyReanimation.currentTrack = "anim_shooting";
		mBodyReanimation.loopType = new ReanimLoopOnceAndIdle("anim_idle", idleRate);
		mShootingCounter = 29;
		return true;
	}

	public function UpdateShooter() {
		--mLaunchCounter;
		if (mLaunchCounter <= 0) {
			mLaunchCounter = Std.int(mLaunchRate - Math.random() * 15);
			this.FindTargetAndFire(mRow, CPlant.WEAPON_PRIMARY);
		}
		if (mLaunchCounter == 25) {
			if (mSeedType == CPlant.SEED_REPEATER) {
				this.FindTargetAndFire(mRow, CPlant.WEAPON_PRIMARY);
			}
		}
	}

	public function Fire(theTargetZombie:Zombie, theRow:Int, thePlantWeapon:Int) {
		var aProjectileType = 0;
		switch (mSeedType) {
			case CPlant.SEED_PEASHOOTER:
				aProjectileType = CPlant.PROJECTILE_PEA;
			case CPlant.SEED_REPEATER:
				aProjectileType = CPlant.PROJECTILE_PEA;
			case CPlant.SEED_SNOWPEA:
				aProjectileType = CPlant.PROJECTILE_SNOWPEA;
			case CPlant.SEED_PUFFSHROOM:
				aProjectileType = CPlant.PROJECTILE_PUFF;
		}
		app.foleyManager.playFoley(PVZFoleyType.PUFF);
		var aOriginX = mX + 30;
		var aOriginY = mY + 30;
		var anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_PUFFSHROOMMUZZLE);
		anEffect.setPosition(aOriginX + 6, aOriginY + 10);
		mBoard.mRenderManager.add(new ParticleRenderable(anEffect));
		var aProjectile = mBoard.AddProjectile(aOriginX, aOriginY, mRenderOrder, theRow, aProjectileType);
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
