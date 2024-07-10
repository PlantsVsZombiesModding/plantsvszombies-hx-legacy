package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.resources.PVZImages;
import flash.display.BitmapData;
import flash.geom.Matrix;

class CursorPreview extends GameObject {
	static inline final SEED_SUNFLOWER = 1;

	public static inline final SEED_LEFTPEATER = 49;

	public static inline final SEED_PUFFSHROOM = 8;

	static inline final PLANTING_OK = "ok";

	static inline final SEED_NONE = -1;

	static inline final SEED_CHERRYBOMB = 2;

	static inline final LAWN_YMIN = 40;

	static inline final SEED_SQUASH = 4;

	static inline final SEED_PEASHOOTER = 0;

	static inline final SEED_WALLNUT = 3;

	static inline final SEED_REPEATER = 7;

	static inline final SEED_CHOMPER = 6;

	public static inline final SEED_SUNSHROOM = 9;

	static inline final LAWN_YMAX = 365;

	public static inline final SEED_FUMESHROOM = 10;

	static inline final PLANTING_NOT_HERE = "not here";

	static inline final LAWN_XMIN = 27;

	static inline final GRIDSIZEX = 9;

	static inline final VARIATION_NORMAL = "normal";

	public static inline final SEED_EXPLODE_O_NUT = 50;

	public static inline final SEED_GRAVEBUSTER = 11;

	static inline final GRIDSIZEY = 5;

	static inline final SEED_SNOWPEA = 5;

	static inline final LAWN_XMAX = 513;

	public var mGridX:Int = 0;

	var mSeedImages:Array<ASAny>;

	public var mGridY:Int = 0;

	public function new(app:PVZApp, theBoard:Board) {
		super();
		this.mSeedImages = new Array<ASAny>();
		// super();
		this.app = app;
		mBoard = theBoard;
		mX = 0;
		mY = 0;
		mWidth = 54;
		mHeight = 54;
		this.mGridX = 0;
		this.mGridY = 0;
		mVisible = false;
	}

	public function draw(g:Graphics2D) {
		if (!mVisible) {
			return;
		}
		var aPlantingSeedType = mBoard.GetSeedTypeInCursor();
		if (aPlantingSeedType == SEED_NONE) {
			return;
		}
		var anImg:ImageInst = this.mSeedImages[aPlantingSeedType];
		if (anImg == null) {
			anImg = this.GetPlantImage(aPlantingSeedType);
		}
		var aCenterX:Float = 28;
		var aCenterY:Float = 28;
		var aOffsetX = aCenterX - anImg.width / 2;
		var aOffsetY = aCenterY - anImg.height / 2;
		g.drawImage(anImg, mX + aOffsetX, mY + aOffsetY);
	}

	public function update() {
		var aPlantingSeedType = mBoard.GetSeedTypeInCursor();
		var aMouseX = Std.int(app.widgetManager.lastMouseX);
		var aMouseY = Std.int(app.widgetManager.lastMouseY);
		this.mGridX = mBoard.PlantingPixelToGridX(aMouseX, aMouseY, aPlantingSeedType);
		this.mGridY = mBoard.PlantingPixelToGridY(aMouseX, aMouseY, aPlantingSeedType);
		if (this.mGridX < 0 || this.mGridX >= GRIDSIZEX || this.mGridY < 0 || this.mGridY >= GRIDSIZEY) {
			mVisible = false;
		} else if (mBoard.IsPlantInCursor() && mBoard.CanPlantAt(this.mGridX, this.mGridY, aPlantingSeedType) == PLANTING_OK) {
			mX = mBoard.GridToPixelX(this.mGridX, this.mGridY);
			mY = mBoard.GridToPixelY(this.mGridX, this.mGridY);
			mVisible = true;
		} else {
			mVisible = false;
		}
	}

	function drawBufferedSeed(seedType:Float):ImageInst {
		var aPlantReanimType = mBoard.GetPlantDefinition(Std.int(seedType));
		var aPlantReanim = app.reanimator.createReanimation(aPlantReanimType);
		switch (seedType) {
			case SEED_PEASHOOTER | SEED_REPEATER | SEED_SNOWPEA:
				aPlantReanim.currentTrack = "anim_full_idle";
			case SEED_WALLNUT:
				aPlantReanim.currentTrack = "anim_idle1";
			case SEED_EXPLODE_O_NUT:
				aPlantReanim.currentTrack = "anim_idle1";
				aPlantReanim.useColor = true;

				aPlantReanim.overrideColor = Color.RGB(1, 64 / 255, 64 / 255);
			default:
				aPlantReanim.currentTrack = "anim_idle";
		}
		aPlantReanim.update();
		var aBounds = aPlantReanim.getBoundsForFrame();
		var aImage = new ImageInst(new ImageData(new BitmapData(Std.int(aBounds.width), Std.int(aBounds.height), true, 0)));
		var bufferG = new Graphics2D(aImage.pixels);
		aPlantReanim.drawLerp(bufferG, new Matrix(), 0.5);
		this.mSeedImages[Std.int(seedType)] = aImage;
		return aImage;
	}

	function GetPlantImage(theType:Int):ImageInst {
		var aPlantImg:ImageInst = null;
		switch (theType) {
			case SEED_PEASHOOTER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTERSINGLE);
			case SEED_SUNFLOWER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNFLOWER);
			case SEED_CHERRYBOMB:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHERRYBOMB);
			case SEED_SQUASH:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SQUASH);
			case SEED_CHOMPER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHOMPER);
			case SEED_SNOWPEA:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SNOWPEA);
			case SEED_REPEATER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTER);
			case SEED_WALLNUT:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
			case SEED_EXPLODE_O_NUT:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
				aPlantImg.useColor = true;

				aPlantImg.setColor(0.5, 1, 64 / 255, 64 / 255);
			case SEED_PUFFSHROOM:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM);
			case SEED_SUNSHROOM:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
			case SEED_FUMESHROOM:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
			case SEED_GRAVEBUSTER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
			case SEED_LEFTPEATER:
				aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_LEFTFACINGPEASHOOTER);
		}
		aPlantImg.useColor = true;
		if (theType != SEED_EXPLODE_O_NUT) {
			aPlantImg.setColor(0.5, 1, 1, 1);
		}
		this.mSeedImages[theType] = aPlantImg;
		return aPlantImg;
	}
}
