package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.zombies.Zombie;
import com.popcap.flash.games.pvz.resources.PVZReanims;
import flash.geom.Rectangle;

class LawnMower {
	static inline final PHASE_ZOMBIE_BURNED = 2;

	public static inline final MOWER_ROLLING_IN = 0;

	static inline final PHASE_POLEVAULTER_POST_VAULT = 6;

	static inline final PHASE_ZOMBIE_MOWERED = 3;

	static inline final PHASE_POLEVAULTER_IN_VAULT = 5;

	public static inline final LAWNMOWER_LAWN = 0;

	public static inline final MOWER_TRIGGERED = 2;

	static inline final PHASE_ZOMBIE_DYING = 1;

	public static inline final MOWER_SQUISHED = 3;

	public static inline final MOWER_READY = 1;

	static inline final BOARD_WIDTH = 540;

	public static inline final CHOMP_TIME = 50;

	static inline final PHASE_POLEVAULTER_PRE_VAULT = 4;

	static inline final PHASE_ZOMBIE_NORMAL = 0;

	public var mChompCounter:Int = 0;

	public var mVisible:Bool = false;

	public var mSquishedCounter:Int = 0;

	public var mLastPortalX:Int = 0;

	public var mPosX:Float = Math.NaN;

	public var mPosY:Float = Math.NaN;

	public var mReanim:Reanimation;

	public var mMowerHeight:Int = 0;

	public var mRollingInCounter:Int = 0;

	public var app:PVZApp;

	public var mAnimTicksPerFrame:Int = 0;

	public var mRenderOrder:Int = 0;

	public var mRow:Int = 0;

	public var mMowerType:Int = 0;

	public var mDead:Bool = false;

	public var mAltitude:Float = Math.NaN;

	public var mBoard:Board;

	public var mMowerState:Int = 0;

	public function new(app:PVZApp, theBoard:Board, theRow:Int) {
		// super();
		this.app = app;
		this.mBoard = theBoard;
		this.mRow = theRow;
		this.mPosX = -108;
		this.mPosY = this.mBoard.GetPosYBasedOnRow(this.mPosX + 28, theRow) + 10;
		this.mDead = false;
		this.mMowerState = MOWER_READY;
		this.mVisible = true;
		this.mChompCounter = 0;
		this.mRollingInCounter = 0;
		this.mSquishedCounter = 0;
		this.mLastPortalX = -1;
		this.mMowerType = LAWNMOWER_LAWN;
		this.mAltitude = 0;
		this.mReanim = app.reanimator.createReanimation(PVZReanims.REANIM_LAWNMOWER);
		this.mReanim.animRate = 0;
		this.mReanim.x = this.mPosX;
		this.mReanim.y = this.mPosY;
		this.mReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
		this.mReanim.currentTrack = "anim_normal";
	}

	public function Draw(g:Graphics2D) {
		var aShadowImageIndex = 0;
		var aScaleX = Math.NaN;
		var aScaleY = Math.NaN;
		var aShadowX = Math.NaN;
		var aShadowY = Math.NaN;
		if (!this.mVisible) {
			return;
		}
		if (this.mMowerState != MOWER_SQUISHED) {
			aShadowImageIndex = 0;
			aScaleX = 1;
			aScaleY = 1;
			aShadowX = this.mPosX - 5;
			aShadowY = this.mPosY - this.mAltitude + 30;
		}
		g.pushState();
		this.mReanim.x = this.mPosX + 4;
		this.mReanim.y = this.mPosY - this.mAltitude;
		this.mReanim.draw(g);
		g.popState();
	}

	public function Die() {
		this.mDead = true;
	}

	public function StartMower() {
		if (this.mMowerState == MOWER_TRIGGERED) {
			return;
		}
		this.mReanim.animRate = 70;
		this.app.foleyManager.playFoley(PVZFoleyType.LAWNMOWER);
		this.mBoard.mWaveRowGotLawnMowered[this.mRow] = this.mBoard.mCurrentWave;
		++this.mBoard.mTriggeredLawnMowers;
		this.mMowerState = MOWER_TRIGGERED;
	}

	public function GetLawnMowerAttackRect():Rectangle {
		return new Rectangle(this.mPosX, this.mPosY, 50, 54);
	}

	public function Update() {
		var aZombie:Zombie = null;
		var LAWN_MOWER_ROLL_IN_TIME = 0;
		var aRowDiff = 0;
		var aZombieRect:Rectangle = null;
		var aOverlap = 0;
		var aRange = 0;
		if (this.mMowerState == MOWER_SQUISHED) {
			--this.mSquishedCounter;
			if (this.mSquishedCounter <= 0) {
				this.Die();
			}
			return;
		}
		if (this.mMowerState == MOWER_ROLLING_IN) {
			++this.mRollingInCounter;
			LAWN_MOWER_ROLL_IN_TIME = 100;
			this.mPosX = TodCommon.TodAnimateCurveFloat(0, LAWN_MOWER_ROLL_IN_TIME, this.mRollingInCounter, -160, -21, TodCommon.CURVE_EASE_IN_OUT);
			if (this.mRollingInCounter == LAWN_MOWER_ROLL_IN_TIME) {
				this.mMowerState = MOWER_READY;
			}
			return;
		}
		if (this.mBoard.mGameScene != PVZApp.SCENE_PLAYING) {
			return;
		}
		var aAttackRect = this.GetLawnMowerAttackRect();
		for (_tmp_ in this.mBoard.mZombies) {
			aZombie = _tmp_;
			aRowDiff = aZombie.mRow - this.mRow;
			if (aRowDiff == 0) {
				if (aZombie.mZombiePhase != PHASE_ZOMBIE_MOWERED) {
					aZombieRect = aZombie.GetZombieRect();
					aOverlap = this.mBoard.GetRectOverlap(aAttackRect, aZombieRect);
					aRange = 0;
					if (aOverlap > aRange) {
						if (this.mMowerState == MOWER_READY) {
							if (!aZombie.mHasHead) {
								continue;
							}
						}
						this.MowZombie(aZombie);
					}
				}
			}
		}
		if (this.mMowerState != MOWER_TRIGGERED && this.mMowerState != MOWER_SQUISHED) {
			return;
		}
		var aSpeed:Float = 2.33;
		if (this.mChompCounter > 0) {
			--this.mChompCounter;
			aSpeed = TodCommon.TodAnimateCurveFloat(CHOMP_TIME, 0, this.mChompCounter, aSpeed, 1, TodCommon.CURVE_BOUNCE_SLOW_MIDDLE);
		}
		this.mPosX += aSpeed;
		this.mPosY = this.mBoard.GetPosYBasedOnRow(this.mPosX + 28, this.mRow) + 16;
		if (this.mPosX > BOARD_WIDTH) {
			this.Die();
		}
		this.mReanim.update();
	}

	public function MowZombie(theZombie:Zombie) {
		if (this.mMowerState == MOWER_READY) {
			this.StartMower();
			this.mChompCounter = Std.int(CHOMP_TIME / 2);
		} else if (this.mMowerState == MOWER_TRIGGERED) {
			this.mChompCounter = CHOMP_TIME;
		}
		this.app.foleyManager.playFoley(PVZFoleyType.SPLAT);
		theZombie.MowDown();
	}
}
