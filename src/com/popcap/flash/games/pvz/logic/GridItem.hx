package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.resources.particles.ParticleSystem;
import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.plants.CPlant;
import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
import com.popcap.flash.games.pvz.resources.PVZImages;
import com.popcap.flash.games.pvz.resources.PVZParticles;
import openfl.geom.Rectangle;

class GridItem {
	public static inline final GRIDITEM_GRAVESTONE = 1;

	public static inline final GRIDITEM_SCARY_POT = 2;

	public static inline final GRIDITEM_STATE_SCARY_POT_LEAF = 4;

	public static inline final GRIDITEM_STATE_PORTAL_CLOSED = 2;

	public static inline final GRIDITEM_STATE_GRAVESTONE_SPECIAL = 1;

	public static inline final GRIDITEM_STATE_SCARY_POT_QUESTION = 3;

	public static inline final GRIDITEM_STATE_SCARY_POT_ZOMBIE = 5;

	public static inline final GRIDITEM_STATE_NORMAL = 0;

	public static inline final GRIDITEM_NONE = 0;

	public var mScaryPotType:Int = 0;

	var mGravestoneImage:ImageInst;

	public var mPosX:Float = Math.NaN;

	public var mPosY:Float = Math.NaN;

	public var mGridItemCounter:Int = 0;

	public var mTransparentCounter:Int = 0;

	public var app:PVZApp;

	public var mHighlighted:Bool = false;

	public var mGridItemState:Int = 0;

	public var mRenderOrder:Int = 0;

	public var mSunCount:Int = 0;

	public var mGoalX:Float = Math.NaN;

	public var mGoalY:Float = Math.NaN;

	public var mGridItemParticle:ParticleSystem;

	public var mZombieType:Int = 0;

	var mScaryPotImage:ImageInst;

	public var mSeedType:Int = 0;

	public var mGridItemType:Int = 0;

	public var mGridX:Int = 0;

	public var mGridY:Int = 0;

	public var mGridItemReanim:Reanimation;

	var mGravestoneMoundsImage:ImageInst;

	public var mDead:Bool = false;

	public var mBoard:Board;

	public function new(app:PVZApp, theBoard:Board) {
		// super();
		this.app = app;
		this.mBoard = theBoard;
		this.mGridItemType = GRIDITEM_NONE;
		this.mGridX = 0;
		this.mGridY = 0;
		this.mGridItemCounter = 0;
		this.mRenderOrder = 0;
		this.mDead = false;
		this.mPosX = 0;
		this.mPosY = 0;
		this.mGoalX = 0;
		this.mGoalY = 0;
		this.mGridItemReanim = null;
		this.mGridItemParticle = null;
		this.mZombieType = Board.ZOMBIE_INVALID;
		this.mSeedType = Board.SEED_NONE;
		this.mScaryPotType = Board.SCARYPOT_NONE;
		this.mHighlighted = false;
		this.mTransparentCounter = 0;
		this.mSunCount = 0;
		this.mScaryPotImage = app.imageManager.getImageInst(PVZImages.IMAGE_SCARY_POT);
		this.mGravestoneImage = app.imageManager.getImageInst(PVZImages.IMAGE_TOMBSTONES);
		this.mGravestoneMoundsImage = app.imageManager.getImageInst(PVZImages.IMAGE_TOMBSTONE_MOUNDS);
	}

	public function GridItemDie() {
		this.mDead = true;
		if (this.mGridItemReanim != null) {
			this.mGridItemReanim.mIsDead = true;
			this.mGridItemReanim = null;
		}
		if (this.mGridItemParticle != null) {
			this.mGridItemParticle.die();
			this.mGridItemParticle = null;
		}
	}

	public function DrawScaryPot(g:Graphics2D) {
		var aImageCol = this.mGridItemState;
		var aXPos = this.mBoard.GridToPixelX(this.mGridX, this.mGridY) - 2;
		var aYPos = this.mBoard.GridToPixelY(this.mGridX, this.mGridY) - 17;
		this.mScaryPotImage.frame = aImageCol;
		g.drawImage(this.mScaryPotImage, aXPos, aYPos);
		if (this.mHighlighted) {
			if (this.mTransparentCounter == 0) {
				this.mScaryPotImage.useColor = true;
				this.mScaryPotImage.setColor(196 / 255, 1.5, 1.5, 1.5);
				g.drawImage(this.mScaryPotImage, aXPos, aYPos);
			}
		} else {
			this.mScaryPotImage.setColor(1, 1, 1, 1);
		}
	}

	public function UpdateScaryPot() {
		if (this.mTransparentCounter > 0) {
			--this.mTransparentCounter;
		}
	}

	public function Draw(g:Graphics2D) {
		switch (this.mGridItemType) {
			case GRIDITEM_GRAVESTONE:
				this.DrawGraveStone(g);

			case GRIDITEM_SCARY_POT:
				this.DrawScaryPot(g);
		}
	}

	public function Update() {
		if (this.mGridItemType == GRIDITEM_SCARY_POT) {
			this.UpdateScaryPot();
		}
	}

	public function AddGraveStoneParticles() {
		var aGridCelOffsetX = ASCompat.toInt(this.mBoard.mGridCelOffset[this.mGridX][this.mGridY][0]);
		var aGridCelOffsetY = ASCompat.toInt(this.mBoard.mGridCelOffset[this.mGridX][this.mGridY][1]);
		var aXPos = this.mBoard.GridToPixelX(this.mGridX, this.mGridY) + aGridCelOffsetX;
		var aYPos = this.mBoard.GridToPixelY(this.mGridX, this.mGridY) + aGridCelOffsetY + 40;
		var anEffect = this.app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_GRAVESTONERISE);
		anEffect.setPosition(aXPos, aYPos);
		this.mBoard.mRenderManager.add(new ParticleRenderable(anEffect, Board.RENDER_LAYER_PARTICLE));
		this.app.foleyManager.playFoley(PVZFoleyType.DIRT_RISE);
	}

	public function DrawGraveStone(g:Graphics2D) {
		if (this.mGridItemCounter <= 0) {
			return;
		}
		var aHeightPosition = TodCommon.TodAnimateCurve(0, 100, this.mGridItemCounter, 1000, 0, TodCommon.CURVE_EASE_IN_OUT);
		var aGridCelLook = ASCompat.toInt(this.mBoard.mGridCelLook[this.mGridX][this.mGridY]);
		var aGridCelOffsetX = ASCompat.toInt(this.mBoard.mGridCelOffset[this.mGridX][this.mGridY][0]);
		var aGridCelOffsetY = ASCompat.toInt(this.mBoard.mGridCelOffset[this.mGridX][this.mGridY][1]);
		var aCelWidth = 58;
		var aCelHeight = 61;
		var aGraveCol = aGridCelLook % 5;
		var aGraveRow = 0;
		if (this.mGridY == 0) {
			aGraveRow = 1;
		} else if (this.mGridItemState == GRIDITEM_STATE_GRAVESTONE_SPECIAL) {
			aGraveRow = 0;
		} else {
			aGraveRow = 2 + aGridCelLook % 2;
		}
		this.mGravestoneImage.frame = aGridCelLook;
		if (aGridCelLook < 14) {
			this.mGravestoneMoundsImage.frame = aGridCelLook + 5;
		} else {
			this.mGravestoneMoundsImage.frame = aGridCelLook;
		}
		var aVisibleHeight = TodCommon.TodAnimateCurve(0, 1000, aHeightPosition, aCelHeight, 0, TodCommon.CURVE_EASE_IN_OUT);
		var aExtraBottomClip = TodCommon.TodAnimateCurve(0, 50, aHeightPosition, 0, 14, TodCommon.CURVE_EASE_IN_OUT);
		var aVisibleHeightDirt = TodCommon.TodAnimateCurve(500, 1000, aHeightPosition, aCelHeight, 0, TodCommon.CURVE_EASE_IN_OUT);
		var aTopClip = 0;
		var aGraveBusterPlant = this.mBoard.GetPlantsOnLawn(this.mGridX, this.mGridY);
		if (ASCompat.toBool(aGraveBusterPlant) && aGraveBusterPlant.mState == CPlant.STATE_GRAVEBUSTER_EATING) {
			aTopClip = Std.int(TodCommon.TodAnimateCurveFloat(CPlant.GRAVE_BUSTER_EAT_TIME, 0, aGraveBusterPlant.mStateCountdown, 10, 40,
				TodCommon.CURVE_LINEAR));
		}
		var aSrcRect = new Rectangle(aCelWidth * aGraveCol, aCelHeight * aGraveRow + aTopClip, aCelWidth, aVisibleHeight - aExtraBottomClip - aTopClip);
		var aSrcRectDirt = new Rectangle(aCelWidth * aGraveCol, aCelHeight * aGraveRow, aCelWidth, aVisibleHeightDirt);
		var aXPos = this.mBoard.GridToPixelX(this.mGridX, this.mGridY) + 2 + aGridCelOffsetX;
		var aYPos = this.mBoard.GridToPixelY(this.mGridX, this.mGridY) - 5 + aGridCelOffsetY;
		g.pushState();
		g.setClipRect(aXPos + this.mBoard.x, aYPos + aTopClip, 53, 52 - aTopClip);
		g.drawImage(this.mGravestoneImage, aXPos, aYPos + 61 - aVisibleHeight);
		g.popState();
		g.drawImage(this.mGravestoneMoundsImage, aXPos - 5, aYPos + 41);
	}
}
