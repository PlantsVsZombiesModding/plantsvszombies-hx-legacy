package com.popcap.flash.games.pvz.logic.Plants;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.particles.ParticleSystem;
import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.logic.GameObject;
import com.popcap.flash.games.pvz.logic.TodCommon;
import com.popcap.flash.games.pvz.logic.zombies.Zombie;
import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
import com.popcap.flash.games.pvz.resources.PVZParticles;
import flash.geom.Rectangle;

class CPlant extends GameObject {
	public static inline final SEED_PUFFSHROOM = 8;

	public static inline final STATE_SQUASH_RISING = 5;

	public static inline final STATE_CHOMPER_BITING = 8;

	public static inline final PHASE_ZOMBIE_BURNED = 2;

	public static inline final SEED_PEASHOOTER = 0;

	public static inline final STATE_BOWLING_DOWN = 14;

	public static inline final REANIM_CHERRYBOMB = 3;

	public static inline final PHASE_ZOMBIE_DYING = 1;

	public static inline final RENDER_LAYER_SCREEN_FADE = 900000;

	public static inline final PROJECTILE_PUFF = 2;

	public static inline final STATE_SUNSHROOM_GROWING = 16;

	public static inline final DAMAGE_HITS_SHIELD_AND_BODY = 1;

	public static inline final REANIM_SQUASH = 4;

	public static inline final SEED_GRAVEBUSTER = 11;

	public static inline final RENDER_LAYER_FOG = 500000;

	public static inline final STATE_BOWLING_UP = 13;

	public static inline final DAMAGE_SPIKE = 5;

	public static inline final STATE_CHOMPER_SWALLOWING = 12;

	public static inline final SEED_EXPLODE_O_NUT = 50;

	public static inline final STATE_READY = 1;

	public static inline final SEED_SUNFLOWER = 1;

	static inline final HELMTYPE_PAIL = 2;

	public static inline final PHASE_ZOMBIE_NORMAL = 0;

	public static inline final SEED_NONE = -1;

	public static inline final SEED_CHERRYBOMB = 2;

	public static inline final STATE_CHOMPER_DIGESTING = 11;

	public static inline final SEED_CHOMPER = 6;

	public static inline final PROJECTILE_SNOWPEA = 1;

	public static inline final RENDER_LAYER_GROUND = 200000;

	public static inline final DAMAGE_FREEZE = 2;

	public static inline final STATE_DOINGSPECIAL = 2;

	public static inline final DAMAGE_BYPASSES_SHIELD = 0;

	public static inline final TICKS_PER_SECOND = 100;

	public static inline final SEED_SUNSHROOM = 9;

	public static inline final SEED_WALLNUT = 3;

	public static inline final PHASE_POLEVAULTER_IN_VAULT = 5;

	static inline final HELMTYPE_NONE = 0;

	public static inline final STATE_SQUASH_PRE_LAUNCH = 4;

	public static inline final RENDER_LAYER_LAWN = 300000;

	public static final RENDER_LAYER_PARTICLE:Int = RENDER_LAYER_LAWN + 7000;

	public static final RENDER_LAYER_PLANT:Int = RENDER_LAYER_LAWN + 2000;

	public static final RENDER_LAYER_PROJECTILE:Int = RENDER_LAYER_LAWN + 5000;

	public static inline final PROJECTILE_PEA = 0;

	static inline final HELMTYPE_TRAFFIC_CONE = 1;

	public static inline final RENDER_LAYER_ABOVE_UI = 800000;

	public static inline final SEED_REPEATER = 7;

	public static inline final STATE_SUNSHROOM_BIG = 17;

	public static inline final STATE_GRAVEBUSTER_LANDING = 18;

	public static inline final STATE_GRAVEBUSTER_EATING = 19;

	public static inline final STATE_CHOMPER_BITING_MISSED = 10;

	public static inline final SEED_FUMESHROOM = 10;

	public static inline final SEED_SNOWPEA = 5;

	public static inline final STATE_CHOMPER_BITING_GOT_ONE = 9;

	public static inline final STATE_NOTREADY = 0;

	public static inline final WEAPON_PRIMARY = 0;

	public static inline final PHASE_POLEVAULTER_PRE_VAULT = 4;

	public static inline final RENDER_LAYER_TOP = 400000;

	public static final RENDER_LAYER_LAWN_MOWER:Int = RENDER_LAYER_LAWN + 6000;

	public static inline final DAMAGE_DOESNT_LEAVE_BODY = 4;

	public static inline final REANIM_SUNFLOWER = 2;

	public static inline final SEED_SQUASH = 4;

	public static inline final PHASE_POLEVAULTER_POST_VAULT = 6;

	public static inline final STATE_SQUASH_LOOK = 3;

	public static inline final REANIM_NONE = -1;

	public static inline final REANIM_PEASHOOTER = 0;

	public static inline final STATE_SQUASH_DONE_FALLING = 7;

	public static inline final RENDER_LAYER_UI_TOP = 700000;

	public static inline final PHASE_ZOMBIE_MOWERED = 3;

	public static inline final REANIM_WALLNUT = 1;

	public static inline final SEED_LEFTPEATER = 49;

	public static inline final RENDER_LAYER_COIN_BANK = 600000;

	public static final RENDER_LAYER_GRAVE_STONE:Int = RENDER_LAYER_LAWN + 1000;

	public static inline final STATE_SQUASH_FALLING = 6;

	public static inline final STATE_SUNSHROOM_SMALL = 15;

	public static inline final GRAVE_BUSTER_EAT_TIME = 400;

	public static inline final DAMAGE_DOESNT_CAUSE_FLASH = 3;

	public static final RENDER_LAYER_ZOMBIE:Int = RENDER_LAYER_LAWN + 3000;

	public static inline final RENDER_LAYER_UI_BOTTOM = 100000;

	public var mPlantMaxHealth:Int = 0;

	public var mFrameLength:Int = 0;

	public var mFrame:Int = 0;

	public var mPlantRect:Rectangle;

	public var mLaunchRate:Int = 0;

	public var mBodyReanimation:Reanimation;

	public var mBlinkCountdown:Int = 0;

	public var mDisappearCountdown:Int = 0;

	public var mHeadReanimation:Reanimation;

	public var mPlantCol:Int = 0;

	public var mState:Int = 0;

	public var mStartRow:Int = 0;

	public var mTargetZombie:Zombie;

	public var mHighlighted:Bool = false;

	public var mWakeUpCounter:Int = 0;

	public var mSquished:Bool = false;

	public var mTargetX:Int = 0;

	public var mTargetY:Int = 0;

	public var mAnimPing:Bool = false;

	public var mBlinkReanimation:Reanimation;

	public var mSubclass:Int = 0;

	public var mRecentlyEatenCountdown:Int = 0;

	public var mEatenFlashCountdown:Int = 0;

	public var mSeedType:Int = 0;

	public var mLaunchCounter:Int = 0;

	public var mReanimationType:Int = 0;

	public var mNumFrames:Int = 0;

	public var mPlantAttackRect:Rectangle;

	public var mShootingCounter:Int = 0;

	public var mIsAsleep:Bool = false;

	public var mDoSpecialCountdown:Int = 0;

	public var mDead:Bool = false;

	public var mStateCountdown:Int = 0;

	public var mPlantHealth:Int = 0;

	public var mAnimCounter:Int = 0;

	public function new() {
		super();
		// super();
	}

	public function GetPlantAttackRect(thePlantWeapon:Int):Rectangle {
		var aRect:Rectangle = null;
		if (mBoard.IsWallnutBowlingLevel()) {
			aRect = new Rectangle(mX + 0, mY, mWidth - 14, mHeight);
		} else if (this.mSeedType == SEED_SQUASH) {
			aRect = new Rectangle(mX + 14, mY, mWidth - 23, mHeight);
		} else if (this.mSeedType == SEED_CHOMPER) {
			aRect = new Rectangle(mX + 54, mY, 28, mHeight);
		} else if (this.mSeedType == SEED_PUFFSHROOM) {
			aRect = new Rectangle(mX + 40, mY, 155, mHeight);
		} else if (this.mSeedType == SEED_FUMESHROOM) {
			aRect = new Rectangle(mX + 40, mY, 230, mHeight);
		} else if (this.mSeedType == SEED_LEFTPEATER) {
			aRect = new Rectangle(0, mY, mX, mHeight);
		} else {
			aRect = new Rectangle(mX + 41, mY, 540, mHeight);
		}
		return aRect;
	}

	public function UpdateReanim() {
		this.mBodyReanimation.update();
		if (this.mHeadReanimation == null) {}
	}

	public function DoSpecial() {}

	public function FindTargetZombie(theRow:Int, thePlantWeapon:Int):Zombie {
		var aZombie:Zombie = null;
		var aRowDiff = 0;
		var aRange = 0;
		var aZombieRect:Rectangle = null;
		var aOverlap = 0;
		var aPickWeight = 0;
		var aAttackRect = this.GetPlantAttackRect(thePlantWeapon);
		var aHighestWeight = 0;
		var aBestZombie:Zombie = null;
		for (_tmp_ in mBoard.mZombies) {
			aZombie = _tmp_;
			aRowDiff = aZombie.mRow - theRow;
			aRange = 0;
			if (aRowDiff == 0) {
				if (aZombie.EffectedByDamage()) {
					if (aZombie.mFromWave != Zombie.ZOMBIE_WAVE_CUTSCENE) {
						if (this.mSeedType == SEED_CHOMPER) {
							if (aZombie.IsDeadOrDying() || !aZombie.mHasHead) {
								continue;
							}
							if (aZombie.mIsEating || this.mState == STATE_CHOMPER_BITING) {
								aRange = 60;
							}
						}
						if (this.mSeedType == SEED_EXPLODE_O_NUT) {
							if (aZombie.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT) {
								continue;
							}
						}
						aZombieRect = aZombie.GetZombieRect();
						aOverlap = mBoard.GetRectOverlap(aAttackRect, aZombieRect);
						if (aOverlap >= -aRange) {
							aPickWeight = Std.int(-aZombieRect.x);
							if (aBestZombie == null || aPickWeight > aHighestWeight) {
								aHighestWeight = aPickWeight;
								aBestZombie = aZombie;
							}
						}
					}
				}
			}
		}

		return aBestZombie;
	}

	public function PlayBodyReanim(theTrackName:String, theLoopType:ReanimLoopType, theBlendTime:Int, theAnimRate:Float) {}

	public function SetSleeping(theIsAsleep:Bool) {
		var aAnimTime = Math.NaN;
		if (this.mIsAsleep == theIsAsleep) {
			return;
		}
		this.mIsAsleep = theIsAsleep;
		if (theIsAsleep) {
			aAnimTime = this.mBodyReanimation.animTime;
			this.mBodyReanimation.currentTrack = "anim_sleep";
			this.mBodyReanimation.animTime = aAnimTime;
		} else {
			aAnimTime = this.mBodyReanimation.animTime;
			this.mBodyReanimation.currentTrack = "anim_idle";
			this.mBodyReanimation.animTime = aAnimTime;
		}
	}

	public function UpdateBowling() {
		var aPosX = 0;
		var aPosY = 0;
		var anEffect:ParticleSystem = null;
		var aSpeed = this.mBodyReanimation.getTrackVelocity("_ground");
		mX -= Std.int(aSpeed);
		if (mX > 540) {
			this.Die();
		}
		var aRowSpeed = 2;
		if (this.mState == STATE_BOWLING_UP) {
			mY -= aRowSpeed;
		} else if (this.mState == STATE_BOWLING_DOWN) {
			mY += aRowSpeed;
		}
		var aDiffY = mBoard.GridToPixelY(0, mRow) - mY;
		if (aDiffY > 2 || aDiffY < -2) {
			return;
		}
		var aNewState = this.mState;
		if (aNewState == STATE_BOWLING_UP && mRow == 0) {
			aNewState = STATE_BOWLING_DOWN;
		} else if (aNewState == STATE_BOWLING_DOWN && mRow == 4) {
			aNewState = STATE_BOWLING_UP;
		}
		var aZombie = this.FindTargetZombie(mRow, WEAPON_PRIMARY);
		if (aZombie != null) {
			aPosX = Std.int(mX + mWidth / 2);
			aPosY = Std.int(mY + mHeight / 2);
			if (this.mSeedType == SEED_EXPLODE_O_NUT) {
				app.foleyManager.playFoley(PVZFoleyType.CHERRYBOMB);
				app.foleyManager.playFoley(PVZFoleyType.BOWLINGIMPACT2);
				mBoard.KillAllZombiesInRadius(mRow, aPosX, aPosY, 90, 1, true);
				anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_POWIE);
				anEffect.setPosition(aPosX, aPosY);
				mBoard.mRenderManager.add(new ParticleRenderable(anEffect));
				mBoard.ShakeBoard(2, -4);
				this.Die();
				return;
			}
			app.foleyManager.playFoley(PVZFoleyType.BOWLINGIMPACT);
			if (aZombie.mHelmType != HELMTYPE_NONE) {
				if (aZombie.mHelmType == HELMTYPE_PAIL) {
					app.foleyManager.playFoley(PVZFoleyType.SHIELD_HIT);
				} else if (aZombie.mHelmType == HELMTYPE_TRAFFIC_CONE) {
					app.foleyManager.playFoley(PVZFoleyType.PLASTIC_HIT);
				}
				aZombie.TakeHelmDamage(900, 0);
			} else {
				aZombie.TakeDamage(1800, 0);
			}
			if (mRow == 4 || this.mState == STATE_BOWLING_DOWN) {
				aNewState = STATE_BOWLING_UP;
			} else if (mRow == 0 || this.mState == STATE_BOWLING_UP) {
				aNewState = STATE_BOWLING_DOWN;
			} else if (Math.random() * 2 == 0) {
				aNewState = STATE_BOWLING_DOWN;
			} else {
				aNewState = STATE_BOWLING_UP;
			}
		}
		if (aNewState == STATE_BOWLING_UP) {
			this.mState = STATE_BOWLING_UP;
			--mRow;
		} else if (aNewState == STATE_BOWLING_DOWN) {
			this.mState = STATE_BOWLING_DOWN;
			++mRow;
		}
	}

	public function IsOnBoard():Bool {
		return true;
	}

	public function DoBlink() {}

	public function IsNocturnal(theSeedtype:Int):Bool {
		if (theSeedtype == SEED_PUFFSHROOM || theSeedtype == SEED_SUNSHROOM || theSeedtype == SEED_FUMESHROOM) {
			return true;
		}

		return false;
	}

	public function Animate() {}

	public function getRow():Int {
		return mRow;
	}

	public function MouseDown(x:Int, y:Int) {}

	public function getCol():Int {
		return this.mPlantCol;
	}

	public function UpdateReanimColor() {
		var aFade = Math.NaN;
		if (this.mSeedType == SEED_EXPLODE_O_NUT) {
			this.mBodyReanimation.useColor = true;
			this.mBodyReanimation.overrideColor.alpha = 1;
			this.mBodyReanimation.overrideColor.red = 1;
			this.mBodyReanimation.overrideColor.green = 0.25;
			this.mBodyReanimation.overrideColor.blue = 0.25;
		}
		if (this.mHighlighted) {
			this.mBodyReanimation.useColor = true;
			this.mBodyReanimation.overrideColor.alpha = 1;
			this.mBodyReanimation.overrideColor.red = 1;
			this.mBodyReanimation.overrideColor.green = 1;
			this.mBodyReanimation.overrideColor.blue = 1;
			this.mBodyReanimation.additiveColor.alpha = 50 / 255;
			this.mBodyReanimation.additiveColor.red = 0.25;
			this.mBodyReanimation.additiveColor.green = 0.25;
			this.mBodyReanimation.additiveColor.blue = 0.25;
		} else if (this.mEatenFlashCountdown > 0) {
			aFade = TodCommon.ClampInt(this.mEatenFlashCountdown * 3, 0, 255);
			aFade /= 255;
			this.mBodyReanimation.useColor = true;
			this.mBodyReanimation.additiveColor.alpha = 0;
			this.mBodyReanimation.additiveColor.red = aFade;
			this.mBodyReanimation.additiveColor.green = aFade;
			this.mBodyReanimation.additiveColor.blue = aFade;
		} else {
			this.mBodyReanimation.useColor = false;
		}
	}

	public function GetPlantRect():Rectangle {
		var aRect:Rectangle = null;
		aRect = new Rectangle(mX + 10, mY, mWidth - 8, mHeight);
		if (this.mSeedType == SEED_LEFTPEATER) {
			aRect.x += 20;
		}

		return aRect;
	}

	public function IsInPlay():Bool {
		return true;
	}

	public function Draw(g:Graphics2D) {
		var aImageIndex = 0;
		if (mBoard.mGameScene == Board.SCENE_ZOMBIES_WON || mBoard.mGameScene == Board.SCENE_AWARD) {}
		var aImageRow = 0;
		var aOffsetX:Float = 0;
		var aOffsetY:Float = 0;
		this.mBodyReanimation.x = mX;
		this.mBodyReanimation.y = mY;
		if (mBoard.IsWallnutBowlingLevel()) {
			this.mBodyReanimation.drawLerp(g);
		} else {
			this.mBodyReanimation.draw(g);
		}
		if (this.mHeadReanimation == null) {}
	}

	public function EndBlink() {}

	public function Update() {}

	public function getDead():Bool {
		return this.mDead;
	}

	public function UpdateBlink() {}

	public function Die() {
		this.mDead = true;
	}

	public function PlayIdleAnim(theRate:Float) {}
}
