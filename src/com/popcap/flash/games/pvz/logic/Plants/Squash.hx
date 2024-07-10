package com.popcap.flash.games.pvz.logic.plants;

import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.logic.TodCommon;
import com.popcap.flash.games.pvz.logic.zombies.Zombie;
import com.popcap.flash.games.pvz.resources.PVZReanims;
import openfl.geom.Rectangle;

class Squash extends CPlant {
	static inline final SQUASH_RISE_TIME = 50;

	static inline final DAMAGE_FREEZE = 0;

	static inline final DAMAGE_BYPASSES_SHIELD = 2;

	static inline final DAMAGE_DOESNT_CAUSE_FLASH = 1;

	static inline final SQUASH_FALL_HEIGHT = 120;

	static inline final SQUASH_LOOK_TIME = 80;

	static inline final DAMAGE_HITS_SHIELD_AND_BODY = 3;

	static inline final SQUASH_FALL_TIME = 10;

	static inline final SQUASH_DONE_TIME = 100;

	static inline final DAMAGE_DOESNT_LEAVE_BODY = 4;

	static inline final SQUASH_PRE_LAUNCH_TIME = 45;

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
		mLaunchRate = 2500;
		mReanimationType = CPlant.REANIM_SUNFLOWER;
		var aBodyReanim = app.reanimator.createReanimation(PVZReanims.REANIM_SQUASH);
		aBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
		aBodyReanim.animRate = TodCommon.RandRangeFloat(10, 15);
		aBodyReanim.currentTrack = "anim_idle";
		mBodyReanimation = aBodyReanim;
		mLaunchCounter = TodCommon.RandRangeInt(300, Std.int(mLaunchRate / 2));
	}

	public function DoSquashDamage() {
		var aZombie:Zombie = null;
		var aRowDiff = 0;
		var aZombieRect:Rectangle = null;
		var aRectOverlap = 0;
		var aRange = 0;
		var aAttackRect = GetPlantAttackRect(CPlant.WEAPON_PRIMARY);
		for (_tmp_ in mBoard.mZombies) {
			aZombie = _tmp_;
			aRowDiff = aZombie.mRow - mRow;
			if (aRowDiff == 0) {
				aZombieRect = aZombie.GetZombieRect();
				aRectOverlap = mBoard.GetRectOverlap(aAttackRect, aZombieRect);
				aRange = 0;
				if (aRectOverlap > aRange) {
					aZombie.TakeDamage(1800, DAMAGE_DOESNT_LEAVE_BODY);
				}
			}
		}
	}

	override public function Update() {
		if (mBoard.mGameScene == Board.SCENE_ZOMBIES_WON
			|| mBoard.mGameScene == Board.SCENE_AWARD
			|| mBoard.mGameScene == Board.SCENE_LEVEL_INTRO) {
			return;
		}
		if (mStateCountdown > 0) {
			--mStateCountdown;
		}
		this.UpdateSquash();
		Animate();
		if (mPlantHealth < 0) {
			Die();
		}
		UpdateReanimColor();

		UpdateReanim();
	}

	public function FindSquashTarget():Zombie {
		var aZombie:Zombie = null;
		var aRowDiff = 0;
		var aZombieRect:Rectangle = null;
		var aRange = 0;
		var aDist = 0;
		var aCheckLeftDistance = 0;
		var aAttackRect = GetPlantAttackRect(CPlant.WEAPON_PRIMARY);
		var aClosestRange = 0;
		var aClosestZombie:Zombie = null;
		for (_tmp_ in mBoard.mZombies) {
			aZombie = _tmp_;
			aRowDiff = aZombie.mRow - mRow;
			if (aRowDiff == 0) {
				if (aZombie.mHasHead) {
					aZombieRect = aZombie.GetZombieRect();
					if (!(aZombie.mZombiePhase == CPlant.PHASE_POLEVAULTER_PRE_VAULT && aZombieRect.x < mX + 20)) {
						if (aZombie.mZombiePhase == CPlant.PHASE_POLEVAULTER_PRE_VAULT
							|| aZombie.mZombiePhase == CPlant.PHASE_POLEVAULTER_IN_VAULT) {
							continue;
						}
					}
					aRange = 70;
					if (aZombie.mIsEating) {
						aRange = 110;
					}
					aDist = -mBoard.GetRectOverlap(aAttackRect, aZombieRect);
					if (aDist <= aRange) {
						aCheckLeftDistance = Std.int(aAttackRect.x);
						if (aZombie.mZombiePhase == CPlant.PHASE_POLEVAULTER_POST_VAULT
							|| aZombie.mZombiePhase == CPlant.PHASE_POLEVAULTER_PRE_VAULT) {
							aCheckLeftDistance = Std.int(aAttackRect.x - 60);
						}
						if (aZombieRect.x + aZombieRect.width >= aCheckLeftDistance) {
							if (aZombie == mTargetZombie) {
								return aZombie;
							}
							if (aClosestZombie == null || aDist < aClosestRange) {
								aClosestZombie = aZombie;
								aClosestRange = aDist;
							}
						}
					}
				}
			}
		}
		return aClosestZombie;
	}

	public function UpdateSquash() {
		var aZombie:Zombie = null;
		var aStartX = 0;
		var aStartY = 0;
		var aOffsetY = Math.NaN;
		if (mState == CPlant.STATE_NOTREADY) {
			aZombie = this.FindSquashTarget();
			if (aZombie == null) {
				return;
			}
			mTargetZombie = aZombie;
			mTargetX = Std.int(Std.int(aZombie.ZombieTargetLeadX(0)) - mWidth / 2);
			mState = CPlant.STATE_SQUASH_LOOK;
			mStateCountdown = SQUASH_LOOK_TIME;
			if (mTargetX < mX) {
				mBodyReanimation.currentTrack = "anim_lookleft";
				mBodyReanimation.animRate = 24;
				mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
			} else {
				mBodyReanimation.currentTrack = "anim_lookright";
				mBodyReanimation.animRate = 24;
				mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
			}
			app.foleyManager.playFoley(PVZFoleyType.SQUASH_HMM);
			return;
		}
		if (mState == CPlant.STATE_SQUASH_LOOK) {
			if (mStateCountdown == 0) {
				mBodyReanimation.currentTrack = "anim_jumpup";
				mBodyReanimation.animRate = 24;
				mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
				mState = CPlant.STATE_SQUASH_PRE_LAUNCH;
				mStateCountdown = SQUASH_PRE_LAUNCH_TIME;
			}
			return;
		}
		if (mState == CPlant.STATE_SQUASH_PRE_LAUNCH) {
			if (mStateCountdown == 0) {
				aZombie = this.FindSquashTarget();
				if (aZombie != null) {
					mTargetX = Std.int(Std.int(aZombie.ZombieTargetLeadX(30)) - mWidth / 2);
				}
				mState = CPlant.STATE_SQUASH_RISING;
				mStateCountdown = SQUASH_RISE_TIME;
			}
			return;
		}
		var aTargetCol = mBoard.PixelToGridXKeepOnBoard(mTargetX, mY);
		var aDestX = mTargetX;
		var aDestY = mBoard.GridToPixelY(aTargetCol, mRow) + 8;
		if (mState == CPlant.STATE_SQUASH_RISING) {
			aStartX = mBoard.GridToPixelX(mPlantCol, mStartRow);
			aStartY = mBoard.GridToPixelY(mPlantCol, mStartRow);
			mX = TodCommon.TodAnimateCurve(SQUASH_RISE_TIME, 20, mStateCountdown, aStartX, aDestX, TodCommon.CURVE_EASE_IN_OUT);
			mY = TodCommon.TodAnimateCurve(SQUASH_RISE_TIME, 20, mStateCountdown, aStartY, aDestY - SQUASH_FALL_HEIGHT, TodCommon.CURVE_EASE_IN_OUT);
			if (mStateCountdown == 0) {
				mBodyReanimation.currentTrack = "anim_jumpdown";
				mBodyReanimation.animRate = 24;
				mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
				mState = CPlant.STATE_SQUASH_FALLING;
				mStateCountdown = SQUASH_FALL_TIME;
			}
		} else if (mState == CPlant.STATE_SQUASH_FALLING) {
			mY = TodCommon.TodAnimateCurve(SQUASH_FALL_TIME, 0, mStateCountdown, aDestY - SQUASH_FALL_HEIGHT, aDestY, TodCommon.CURVE_LINEAR);
			if (mStateCountdown == 5) {
				this.DoSquashDamage();
				app.foleyManager.playFoley(PVZFoleyType.SPLAT);
			}
			if (mStateCountdown == 0) {
				mState = CPlant.STATE_SQUASH_DONE_FALLING;
				mStateCountdown = SQUASH_DONE_TIME;
				mBoard.ShakeBoard(1, 4);
				app.foleyManager.playFoley(PVZFoleyType.THUMP);
				aOffsetY = 80;
			}
		} else if (mState == CPlant.STATE_SQUASH_DONE_FALLING) {
			if (mStateCountdown == 0) {
				Die();
			}
		}
	}
}
