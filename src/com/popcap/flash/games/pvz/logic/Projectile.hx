package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.resources.particles.ParticleSystem;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.zombies.Zombie;
import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
import com.popcap.flash.games.pvz.resources.PVZImages;
import com.popcap.flash.games.pvz.resources.PVZParticles;
import openfl.geom.Rectangle;

class Projectile extends GameObject {
	static inline final BOARD_HEIGHT = 405;

	static inline final BOARD_WIDTH = 540;

	public static inline final MOTION_BACKWARDS = 2;

	static inline final LAWN_YMIN = 60;

	static inline final DAMAGE_HITS_SHIELD_AND_BODY = 1;

	public static inline final PROJECTILE_PEA = 0;

	static final PROJECTILE_SPEED:Float = 3.33 * 0.67;

	public static inline final PROJECTILE_PUFF = 2;

	static inline final DAMAGE_SPIKE = 5;

	static inline final LAWN_YMAX = 365;

	public static inline final MOTION_STRAIGHT = 0;

	static inline final DAMAGE_FREEZE = 2;

	static inline final DAMAGE_DOESNT_CAUSE_FLASH = 3;

	static inline final LAWN_XMIN = 20;

	public static inline final MOTION_PUFF = 1;

	static inline final DAMAGE_BYPASSES_SHIELD = 0;

	static inline final GRIDSIZEY = 5;

	public static inline final PROJECTILE_SNOWPEA = 1;

	static inline final GRIDSIZEX = 9;

	static inline final DAMAGE_DOESNT_LEAVE_BODY = 4;

	static inline final LAWN_XMAX = 513;

	public var mDead:Bool = false;

	var mSnowPeaParticlesRenderable:ParticleRenderable;

	var renderCounter:Int = 0;

	var mSnowPeaParticles:ParticleSystem;

	public var mProjectileType:Int = 0;

	var mPosX:Float = 0;

	var mPosY:Float = 0;

	var mImpactRect:Rectangle;

	public var mMotionType:Int = 0;

	public var mDamageRangeFlags:Int = 0;

	public var mProjectileAge:Int = 0;

	public var mClickBackoffCounter:Int = 0;

	public var mDamage:Int = 0;

	public var mTargetZombieID:Zombie;

	public function new() {
		super();
		// super();
		this.mImpactRect = new Rectangle();
	}

	public function FindCollisionTarget():Zombie {
		var aZombie:Zombie = null;
		var aRowDiff = 0;
		var aZombieRect:Rectangle = null;
		var aProjectileRect = this.mImpactRect;
		var aZombieClosest:Zombie = null;
		var aFarthestLeft = 0;
		for (_tmp_ in mBoard.mZombies) {
			aZombie = _tmp_;
			aRowDiff = aZombie.mRow - mRow;
			if (aRowDiff == 0) {
				if (!aZombie.IsDeadOrDying()) {
					if (aZombie.EffectedByDamage()) {
						aZombieRect = aZombie.GetZombieRect();
						if (aZombieRect.left <= this.mImpactRect.right) {
							if (aZombieRect.right >= this.mImpactRect.left) {
								if (!(ASCompat.toBool(aZombieClosest) && aZombie.mX >= aFarthestLeft)) {
									aZombieClosest = aZombie;
									aFarthestLeft = aZombie.mX;
								}
							}
						}
					}
				}
			}
		}

		return aZombieClosest;
	}

	public function DoImpact(theZombie:Zombie) {
		var aSplatParticleType:String = null;
		var zType = 0;
		var aDamageFlags:Float = 0;
		if (this.mProjectileType == PROJECTILE_SNOWPEA) {
			aDamageFlags = DAMAGE_FREEZE;
		}
		theZombie.TakeDamage(this.mDamage, Std.int(aDamageFlags));
		if (theZombie.mHelmHealth > 0) {
			zType = theZombie.mZombieType;
			if (theZombie.mZombieType == Zombie.ZOMBIE_TRAFFIC_CONE) {
				app.foleyManager.playFoley(PVZFoleyType.PLASTIC_HIT);
			} else if (zType == Zombie.ZOMBIE_PAIL || zType == Zombie.ZOMBIE_DOOR) {
				app.foleyManager.playFoley(PVZFoleyType.SHIELD_HIT);
			}
		}
		app.foleyManager.playFoley(PVZFoleyType.SPLAT);
		var aSplatPosX = mX + 12 * 0.675;
		var aSplatPosY = mY + 12 * 0.675;
		if (this.mProjectileType == PROJECTILE_PEA) {
			aSplatParticleType = PVZParticles.PARTICLE_PEASPLAT;
		} else if (this.mProjectileType == PROJECTILE_SNOWPEA) {
			aSplatParticleType = PVZParticles.PARTICLE_SNOWPEASPLAT;
		} else if (this.mProjectileType == PROJECTILE_PUFF) {
			aSplatPosX -= 5;
			aSplatParticleType = PVZParticles.PARTICLE_PUFFSPLAT;
		}
		if (this.mMotionType == MOTION_BACKWARDS) {
			aSplatPosX -= 30;
		}
		var anEffect = app.particleManager.spawnParticleSystem(aSplatParticleType);
		anEffect.setPosition(aSplatPosX, aSplatPosY);
		mBoard.mRenderManager.add(new ParticleRenderable(anEffect, GameObject.RENDER_LAYER_PARTICLE));

		this.Die();
	}

	public function Die() {
		if (this.mSnowPeaParticles != null) {
			if (this.mSnowPeaParticles.mDead == false) {
				this.mSnowPeaParticles.die();
			}
		}

		this.mDead = true;
	}

	public function CheckForCollision() {
		if (mX > BOARD_WIDTH || mX + mWidth < 0) {
			this.Die();
			return;
		}
		var aZombie = this.FindCollisionTarget();
		if (aZombie != null) {
			this.DoImpact(aZombie);
		}
	}

	public function Draw(g:Graphics2D) {
		var aImage:ImageInst = null;
		var aScale = Math.NaN;
		if (this.mProjectileType == PROJECTILE_PEA) {
			aImage = app.imageManager.getImageInst(PVZImages.IMAGE_PROJECTILEPEA);
			g.drawImage(aImage, mX, mY);
		} else if (this.mProjectileType == PROJECTILE_PUFF) {
			aImage = app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM_PUFF1);
			aScale = TodCommon.TodAnimateCurveFloat(0, 30, this.mProjectileAge, 0.3, 1, TodCommon.CURVE_LINEAR);
			g.pushState();
			g.scale(aScale, aScale);
			g.drawImage(aImage, mX, mY);
			g.popState();
		} else {
			this.mSnowPeaParticles.draw(g);
			aImage = app.imageManager.getImageInst(PVZImages.IMAGE_PROJECTILESNOWPEA);
			g.drawImage(aImage, mX, mY);
		}
	}

	public function Update() {
		if (mBoard.mGameScene == Board.SCENE_ZOMBIES_WON
			|| mBoard.mGameScene == Board.SCENE_AWARD
			|| mBoard.mGameScene == Board.SCENE_LEVEL_INTRO) {
			return;
		}
		++this.mProjectileAge;
		var aPopToFrontAge = 20;
		if (this.mProjectileType == PROJECTILE_PEA || this.mProjectileType == PROJECTILE_SNOWPEA) {
			aPopToFrontAge = 0;
		}
		var aParticleOffsetX:Float = 6;
		var aParticleOffsetY:Float = 10;
		if (this.mProjectileType == PROJECTILE_SNOWPEA && this.mSnowPeaParticles != null) {
			this.mSnowPeaParticles.update();
			this.mSnowPeaParticles.setPosition(mX + aParticleOffsetX, mY + aParticleOffsetY);
		}
		if (this.mProjectileAge > aPopToFrontAge) {}
		var deltaX:Float = 0;
		if (this.mMotionType == MOTION_BACKWARDS) {
			deltaX -= PROJECTILE_SPEED;
		} else {
			deltaX += PROJECTILE_SPEED;
		}
		this.mPosX += deltaX;
		mX = Std.int(this.mPosX);
		this.mImpactRect.x = mX;
		if (this.mProjectileType == PROJECTILE_PEA || this.mProjectileType == PROJECTILE_SNOWPEA) {
			this.mImpactRect.x -= 15 * 0.675;
		}

		this.CheckForCollision();
	}

	public function ProjectileInitialize(theX:Int, theY:Int, theRenderOrder:Int, theRow:Int, theProjectileType:Int, app:PVZApp, theBoard:Board) {
		var aParticleOffsetX = Math.NaN;
		var aParticleOffsetY = Math.NaN;
		this.app = app;
		mBoard = theBoard;
		this.mPosX = theX;
		this.mPosY = theY;
		var aGridX = mBoard.PixelToGridXKeepOnBoard(theX, theY);
		this.mDamage = 20;
		this.mProjectileType = theProjectileType;
		if (this.mProjectileType == PROJECTILE_PUFF) {
			this.mMotionType = MOTION_PUFF;
		} else {
			this.mMotionType = MOTION_STRAIGHT;
		}
		mRow = theRow;
		this.mDamageRangeFlags = 0;
		this.mDead = false;
		this.mTargetZombieID = null;
		this.mProjectileAge = 0;
		this.mClickBackoffCounter = 0;
		mWidth = Std.int(40 * 0.675);
		mHeight = Std.int(40 * 0.675);
		if (this.mProjectileType == PROJECTILE_SNOWPEA) {
			aParticleOffsetX = 8 * 0.675;
			aParticleOffsetY = 13 * 0.675;
			this.mSnowPeaParticles = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SNOWPEATRAIL);
			this.mSnowPeaParticles.setPosition(mX + aParticleOffsetX, mY + aParticleOffsetY);
			this.renderCounter = 0;
		}
		mX = Std.int(this.mPosX);
		mY = Std.int(this.mPosY);
		this.mImpactRect.x = mX;
		this.mImpactRect.y = mY;
		this.mImpactRect.width = mWidth;
		this.mImpactRect.height = mHeight;
	}
}
