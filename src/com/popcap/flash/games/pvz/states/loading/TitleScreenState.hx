package com.popcap.flash.games.pvz.states.loading;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.fonts.TXTFontDescriptor;
import com.popcap.flash.framework.resources.images.ImageDescriptor;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.framework.resources.reanimator.XMLReanimDescriptor;
import com.popcap.flash.framework.states.IState;
import com.popcap.flash.framework.widgets.ui.CButtonWidget;
import com.popcap.flash.framework.widgets.ui.IButtonListener;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.resources.PVZImages;
import com.popcap.flash.games.pvz.resources.PVZReanims;
import openfl.geom.Matrix;
import openfl.utils.ByteArray;

class TitleScreenState implements IState implements IButtonListener {
	static final IMAGE_REANIM_SPROUT_PETAL_CLASS:Class<Dynamic> = TitleScreenState_IMAGE_REANIM_SPROUT_PETAL_CLASS;

	static final IMAGE_REANIM_SPROUT_BODY_CLASS:Class<Dynamic> = TitleScreenState_IMAGE_REANIM_SPROUT_BODY_CLASS;

	static final IMAGE_REANIM_POTATOMINE_ROCK1_CLASS:Class<Dynamic> = TitleScreenState_IMAGE_REANIM_POTATOMINE_ROCK1_CLASS;

	static final IMAGE_REANIM_POTATOMINE_ROCK3_CLASS:Class<Dynamic> = TitleScreenState_IMAGE_REANIM_POTATOMINE_ROCK3_CLASS;

	static final IMAGE_REANIM_ZOMBIE_HEAD_CLASS:Class<Dynamic> = TitleScreenState_IMAGE_REANIM_ZOMBIE_HEAD_CLASS;

	static inline final MINIMUM_LOAD_TIME = 300;

	static final IMAGE_REANIM_ZOMBIE_HAIR_CLASS:Class<Dynamic> = TitleScreenState_IMAGE_REANIM_ZOMBIE_HAIR_CLASS;

	static final IMAGE_REANIM_ZOMBIE_JAW_CLASS:Class<Dynamic> = TitleScreenState_IMAGE_REANIM_ZOMBIE_JAW_CLASS;

	final TITLESCREEN_CLASS:Class<Dynamic> = TitleScreenState_TITLESCREEN_CLASS;

	var currentBarWidth:Float = 0;

	var loadingComplete:Bool = false;

	var app:PVZApp;

	final BRIANNETOD16_IMAGE_CLASS:Class<Dynamic> = TitleScreenState_BRIANNETOD16_IMAGE_CLASS;

	final LOADBAR_ZOMBIE_REANIM_CLASS:Class<Dynamic> = TitleScreenState_LOADBAR_ZOMBIE_REANIM_CLASS;

	var progress:Float = 0;

	var reanims:Array<ASAny>;

	final LOADBAR_SPROUT_REANIM_CLASS:Class<Dynamic> = TitleScreenState_LOADBAR_SPROUT_REANIM_CLASS;

	var startButton:CButtonWidget;

	var loaderDirt:ImageInst;

	var triggerPoints:Array<ASAny>;

	var pvzLogoImg:ImageInst;

	final SODROLLCAP_CLASS:Class<Dynamic> = TitleScreenState_SODROLLCAP_CLASS;

	var loadbarGrass:ImageInst;

	var titleImg:ImageInst;

	final PVZ_LOGO_CLASS:Class<Dynamic> = TitleScreenState_PVZ_LOGO_CLASS;

	var imgSodrollcap:ImageInst;

	final LOADBAR_DIRT_CLASS:Class<Dynamic> = TitleScreenState_LOADBAR_DIRT_CLASS;

	final BRIANNETOD16_FONT_CLASS:Class<Dynamic> = TitleScreenState_BRIANNETOD16_FONT_CLASS;

	var progressCapCounter:Float = 0;

	var sproutTransforms:Array<ASAny>;

	var progressCap:Float = 0;

	var totalBarWidth:Float = 314;

	var triggerId:Float = 0;

	var largeStartButton:CButtonWidget;

	final LOADBAR_GRASS_CLASS:Class<Dynamic> = TitleScreenState_LOADBAR_GRASS_CLASS;

	public function new(app:PVZApp) {
		this.sproutTransforms = new Array<ASAny>();
		// super();
		this.app = app;
		this.reanims = new Array<ASAny>();
		this.startButton = new CButtonWidget(0, this);
		this.startButton.setDisabled(true);
		this.startButton.visible = false;
		this.largeStartButton = new CButtonWidget(0, this);
		this.largeStartButton.setDisabled(true);
		this.largeStartButton.visible = false;
		this.triggerPoints = [0.11, 0.32, 0.54, 0.72, 0.906];
	}

	public function buttonMouseEnter(id:Float) {}

	public function onPop() {}

	public function buttonMouseMove(id:Float, x:Float, y:Float) {}

	public function onPush() {}

	public function onExit() {
		this.app.widgetManager.removeAllWidgets(true);
	}

	public function buttonPress(id:Float) {}

	public function onEnter() {
		var aByteArray:ByteArray = null;
		this.app.imageManager.addDescriptor(PVZImages.IMAGE_TITLESCREEN, new ImageDescriptor(this.TITLESCREEN_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_PVZ_LOGO", new ImageDescriptor(this.PVZ_LOGO_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_LOADBAR_DIRT", new ImageDescriptor(this.LOADBAR_DIRT_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_LOADBAR_GRASS", new ImageDescriptor(this.LOADBAR_GRASS_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_REANIM_SODROLLCAP", new ImageDescriptor(this.SODROLLCAP_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_REANIM_POTATOMINE_ROCK1", new ImageDescriptor(IMAGE_REANIM_POTATOMINE_ROCK1_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_REANIM_POTATOMINE_ROCK3", new ImageDescriptor(IMAGE_REANIM_POTATOMINE_ROCK3_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_REANIM_SPROUT_BODY", new ImageDescriptor(IMAGE_REANIM_SPROUT_BODY_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_REANIM_SPROUT_PETAL", new ImageDescriptor(IMAGE_REANIM_SPROUT_PETAL_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_REANIM_ZOMBIE_HEAD", new ImageDescriptor(IMAGE_REANIM_ZOMBIE_HEAD_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_REANIM_ZOMBIE_HAIR", new ImageDescriptor(IMAGE_REANIM_ZOMBIE_HAIR_CLASS));
		this.app.imageManager.addDescriptor("IMAGE_REANIM_ZOMBIE_JAW", new ImageDescriptor(IMAGE_REANIM_ZOMBIE_JAW_CLASS));
		this.app.fontManager.addDescriptor("FONT_BRIANNETOD16", new TXTFontDescriptor(this.BRIANNETOD16_FONT_CLASS, [this.BRIANNETOD16_IMAGE_CLASS]));
		aByteArray = (Type.createInstance(this.LOADBAR_SPROUT_REANIM_CLASS, []) : ByteArray);
		this.app.reanimator.loadReanim(PVZReanims.REANIM_LOADBAR_SPROUT, new XMLReanimDescriptor(aByteArray));
		aByteArray = (Type.createInstance(this.LOADBAR_ZOMBIE_REANIM_CLASS, []) : ByteArray);
		this.app.reanimator.loadReanim(PVZReanims.REANIM_LOADBAR_ZOMBIEHEAD, new XMLReanimDescriptor(aByteArray));
		this.titleImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_TITLESCREEN);
		this.pvzLogoImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PVZ_LOGO);
		this.loaderDirt = this.app.imageManager.getImageInst(PVZImages.IMAGE_LOADBAR_DIRT);
		this.loadbarGrass = this.app.imageManager.getImageInst(PVZImages.IMAGE_LOADBAR_GRASS);
		this.imgSodrollcap = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SODROLLCAP);
		this.totalBarWidth = 0.3925 * this.app.appWidth;
		this.startButton.label = this.app.stringManager.translateString("[LOADING]");
		this.startButton.setColor(Std.int(CButtonWidget.COLOR_LABEL), Color.RGB(218 / 255, 184 / 255, 33 / 255));
		this.startButton.setColor(Std.int(CButtonWidget.COLOR_LABEL_HILITE), Color.RGB(1, 0, 0));
		var font = this.app.fontManager.getFontInst("FONT_BRIANNETOD16");
		font.scale = 0.675;
		this.startButton.font = font;
		this.startButton.resize(0.3 * this.app.screenWidth, 0.9 * this.app.screenHeight, this.totalBarWidth, 0.0833 * this.app.appHeight);
		this.startButton.visible = true;
		this.largeStartButton.resize(0, 0, this.app.screenWidth, this.app.screenHeight);
		this.app.widgetManager.addWidget(this.startButton);
		this.app.resourceManager.loadResourceLibrary("resources.swf");
	}

	public function update() {
		var reanim:Reanimation = null;
		var reanimType:String = null;
		var reanimTrack:String = null;
		var x = Math.NaN;
		var y = Math.NaN;
		var newReanim:Reanimation = null;
		var matrix:Matrix = null;
		for (_tmp_ in this.reanims) {
			reanim = _tmp_;
			reanim.update();
		}
		if (this.loadingComplete) {
			return;
		}
		++this.progressCapCounter;
		this.progressCap = this.progressCapCounter / MINIMUM_LOAD_TIME;
		var loadingProgress = this.app.resourceManager.getPercentageLoaded();
		this.app.adAPI.setLoadPercent(Std.int(loadingProgress * 100));
		this.progress = Math.min(this.progressCap, loadingProgress);
		this.currentBarWidth = this.progress * this.totalBarWidth;
		if (!this.loadingComplete && this.progress >= 1) {
			this.loadingComplete = true;
			this.startButton.setDisabled(false);
			this.largeStartButton.setDisabled(false);
			this.largeStartButton.setVisible(true);
			this.startButton.label = this.app.stringManager.translateString("[CLICK_TO_START]");
		}
		var remaining = new Array<ASAny>();
		var numPoints = this.triggerPoints.length;
		for (i in 0...numPoints) {
			if (this.triggerPoints[i] > this.progress) {
				remaining.push(this.triggerPoints[i]);
			} else {
				reanimType = PVZReanims.REANIM_LOADBAR_SPROUT;
				reanimTrack = "anim_sprout";
				if (i == this.triggerPoints.length - 1) {
					reanimType = PVZReanims.REANIM_LOADBAR_ZOMBIEHEAD;
					reanimTrack = "anim_zombie";
				}
				x = 225 * 0.675 + this.triggerPoints[i] * this.totalBarWidth;
				y = 511 * 0.675;
				newReanim = this.app.reanimator.createReanimation(reanimType);
				newReanim.x = x;
				newReanim.y = y;
				newReanim.currentTrack = reanimTrack;
				newReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
				newReanim.animRate = 18;
				matrix = new Matrix();
				if (this.triggerId == 1 || this.triggerId == 3) {
					matrix.scale(-1, 1);
				} else if (this.triggerId == 2) {
					matrix.translate(0, -5);
					matrix.scale(1.1, 1.3);
				} else if (this.triggerId == 4) {
					matrix.translate(-20, 0);
				}
				this.reanims.push(newReanim);
				this.sproutTransforms[this.reanims.length - 1] = matrix;
				++this.triggerId;
			}
		}
		this.triggerPoints = remaining;
	}

	public function draw(g:Graphics2D) {
		var reanim:Reanimation = null;
		var rollLength = Math.NaN;
		var rotation = Math.NaN;
		var scale = Math.NaN;
		var matrix:Matrix = null;
		g.blitImage(this.titleImg);
		g.blitImage(this.pvzLogoImg, 50 * 0.675, 30 * 0.675);
		var aBarX:Float = 240;
		var aBarY = 0.9 * 600 - 17;
		g.pushState();
		g.translate((aBarX + 4) * 0.675, (aBarY + 18) * 0.675);
		g.drawImage(this.loaderDirt, 0, 0);
		g.popState();
		if (this.currentBarWidth >= this.totalBarWidth) {
			g.pushState();
			g.translate(aBarX * 0.675, aBarY * 0.675);
			g.drawImage(this.loadbarGrass, 0, 0);
			g.popState();
		} else {
			g.pushState();
			g.setClipRect(aBarX * 0.675, aBarY * 0.675, this.currentBarWidth, this.loadbarGrass.height);
			g.translate(aBarX * 0.675, aBarY * 0.675);
			g.drawImage(this.loadbarGrass, 0, 0);
			g.translate(-aBarX, -aBarY);
			g.popState();
		}
		var i:Float = 0;
		while (i < this.reanims.length) {
			reanim = this.reanims[Std.int(i)];
			reanim.drawLerp(g, this.sproutTransforms[Std.int(i)]);
			i++;
		}
		if (this.currentBarWidth < this.totalBarWidth) {
			rollLength = this.currentBarWidth * 0.94;
			rotation = 2 * rollLength / 180 * Math.PI;
			scale = 1 - this.currentBarWidth / this.totalBarWidth / 2;
			matrix = new Matrix();
			matrix.translate(-this.imgSodrollcap.width / 2, -this.imgSodrollcap.height / 2);
			matrix.rotate(rotation);
			matrix.scale(scale, scale);
			matrix.translate(aBarX * 0.675 + rollLength + 11 * 0.675, (aBarY - 3 - 35 * scale + 35) * 0.675);
			g.pushState();
			g.setTransform(matrix);
			g.drawImage(this.imgSodrollcap, 0, 0);
			g.popState();
		}
		g.reset();

		this.app.widgetManager.drawScreen(g);
	}

	public function buttonMouseLeave(id:Float) {}

	public function buttonDownTick(id:Float) {}

	public function buttonRelease(id:Float) {
		this.startButton.setDisabled(true);
		this.largeStartButton.setDisabled(true);

		this.app.adAPI.SessionReady(this.StartSession);
	}

	function StartSession() {
		this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
	}
}
