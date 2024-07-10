package com.popcap.flash.games.pvz.states.playing;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.states.IState;
import com.popcap.flash.framework.utils.Utils;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import flash.geom.Rectangle;

class ReadySetStartState implements IState {
	static inline final SET_START:Float = 60;

	static inline final READY_START:Float = 0;

	static inline final PLANT_DURATION:Float = 80;

	static inline final SET_SCALE:Float = 0.1;

	static inline final READY_SCALE:Float = 0.1;

	static inline final READY_DURATION:Float = 60;

	static inline final SET_DURATION:Float = 60;

	static inline final PLANT_START:Float = 120;

	static inline final PLANT_SCALE:Float = 0.3;

	var mSetText:ImageInst;

	var mReadyText:ImageInst;

	var mPlantText:ImageInst;

	var mScreenBounds:Rectangle;

	var mTextBounds:Rectangle;

	var mTimer:Float = 0;

	var mCurrentText:ImageInst;

	var mFont:FontInst;

	var mApp:PVZApp;

	var mTextScale:Float = 0;

	var mInited:Bool = false;

	public function new(app:PVZApp) {
		// super();
		this.mApp = app;
	}

	public function onPop() {}

	public function update() {
		this.mApp.widgetManager.updateFrame();
		this.mApp.mCutsceneTime += 10;
		this.mTimer += 1;
		var time:Float = 0;
		if (this.mTimer > PLANT_START + PLANT_DURATION) {
			this.mApp.stateManager.changeState(PVZApp.STATE_START_LEVEL);
		} else if (this.mTimer >= SET_START + SET_DURATION) {
			this.mCurrentText = this.mPlantText;
			this.mTextScale = 1 + PLANT_SCALE;
		} else if (this.mTimer >= READY_START + READY_DURATION) {
			time = (this.mTimer - SET_START) / SET_DURATION;
			this.mCurrentText = this.mSetText;
			this.mTextScale = 1 + SET_SCALE * time;
		} else {
			time = (this.mTimer - READY_START) / READY_DURATION;
			this.mCurrentText = this.mReadyText;
			this.mTextScale = 1 + READY_SCALE * time;
		}
	}

	public function draw(g:Graphics2D) {
		this.mApp.widgetManager.drawScreen(g);
		if (!this.mInited) {
			return;
		}
		this.mTextBounds.x = this.mCurrentText.x;
		this.mTextBounds.y = this.mCurrentText.y;
		this.mTextBounds.width = this.mCurrentText.width * this.mTextScale;
		this.mTextBounds.height = this.mCurrentText.height * this.mTextScale;
		Utils.align(this.mTextBounds, this.mScreenBounds, Utils.ALIGN_CENTER, Utils.ALIGN_CENTER);
		g.pushState();
		g.scale(this.mTextScale, this.mTextScale);
		g.drawImage(this.mCurrentText, this.mTextBounds.x, this.mTextBounds.y);
		g.popState();
	}

	function init() {
		if (this.mInited == true) {
			return;
		}
		this.mFont = this.mApp.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR28);
		this.mScreenBounds = new Rectangle(0, 0, 540, 405);
		this.mTextBounds = new Rectangle();
		this.mReadyText = Utils.createStringImage(this.mApp.stringManager.translateString("[LEVEL_INTRO_READY]"), this.mFont, this.mScreenBounds,
			Utils.JUSTIFY_CENTER);
		this.mReadyText.setColor(1, 246 / 250, 9 / 250, 9 / 250);
		this.mReadyText.useColor = true;
		this.mSetText = Utils.createStringImage(this.mApp.stringManager.translateString("[LEVEL_INTRO_SET]"), this.mFont, this.mScreenBounds,
			Utils.JUSTIFY_CENTER);
		this.mSetText.setColor(1, 246 / 250, 9 / 250, 9 / 250);
		this.mSetText.useColor = true;
		this.mPlantText = Utils.createStringImage(this.mApp.stringManager.translateString("[LEVEL_INTRO_PLANT]"), this.mFont, this.mScreenBounds,
			Utils.JUSTIFY_CENTER);
		this.mPlantText.setColor(1, 246 / 250, 9 / 250, 9 / 250);
		this.mPlantText.useColor = true;
		this.mInited = true;
	}

	public function onExit() {}

	public function onPush() {}

	public function onEnter() {
		this.init();
		this.mTextScale = 1;
		this.mCurrentText = this.mReadyText;
		this.mTimer = 0;
		this.mApp.foleyManager.playFoley(PVZFoleyType.READYSETPLANT);
	}
}
