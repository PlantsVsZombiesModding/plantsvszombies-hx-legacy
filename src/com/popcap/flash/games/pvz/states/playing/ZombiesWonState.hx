package com.popcap.flash.games.pvz.states.playing;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.states.IState;
import com.popcap.flash.framework.utils.Utils;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.PVZMusic;
import com.popcap.flash.games.pvz.logic.TodCommon;
import com.popcap.flash.games.pvz.resources.PVZImages;
import flash.geom.Rectangle;

class ZombiesWonState implements IState {
	static var TIME_PAN_RIGHT_START:Int = 1500;

	static var TIME_PAN_RIGHT_END:Int = TIME_PAN_RIGHT_START + 2000;

	static var TIME_GRAPHIC_START:Int = TIME_PAN_RIGHT_START + 2500;

	static var TIME_GRAPHIC_SHAKE:Int = TIME_GRAPHIC_START + 1000;

	static var TIME_GRAPHIC_SHAKE_END:Int = TIME_GRAPHIC_SHAKE + 1000;

	static var TIME_GRAPHIC_END:Int = TIME_GRAPHIC_SHAKE_END + 3000;

	static var TIME_END:Int = TIME_GRAPHIC_END;

	var mImageBounds:Rectangle;

	var mScreenBounds:Rectangle;

	var mZombiesWon:ImageInst;

	var mImageOffsetX:Float = 0;

	var mImageOffsetY:Float = 0;

	var mApp:PVZApp;

	var mImageScale:Float = 1;

	public function new(app:PVZApp) {
		this.mImageBounds = new Rectangle();
		this.mScreenBounds = new Rectangle(0, 0, 540, 405);
		// super();
		this.mApp = app;
	}

	public function onEnter() {
		if (this.mZombiesWon == null) {
			this.mZombiesWon = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_ZOMBIESWON);
		}
		this.mApp.musicManager.playMusic(PVZMusic.LOSEMUSIC, false);
		this.mApp.mBoard.mMenuButton.setVisible(false);
		if (this.mApp.IsScaryPotterLevel()) {
			this.mApp.mCutsceneTime = TIME_END - 10;
		} else {
			this.mApp.mCutsceneTime = 0;
		}
	}

	public function draw(g:Graphics2D) {
		this.mApp.widgetManager.drawScreen(g);
		if (this.mApp.IsScaryPotterLevel()) {
			return;
		}
		if (this.mApp.mCutsceneTime >= TIME_GRAPHIC_START && this.mApp.mCutsceneTime < TIME_GRAPHIC_END) {
			this.mImageBounds.x = 0;
			this.mImageBounds.y = 0;
			this.mImageBounds.width = this.mZombiesWon.width * this.mImageScale;
			this.mImageBounds.height = this.mZombiesWon.height * this.mImageScale;
			Utils.align(this.mImageBounds, this.mScreenBounds, Utils.ALIGN_CENTER, Utils.ALIGN_CENTER);
			g.pushState();
			g.scale(this.mImageScale, this.mImageScale);
			g.drawImage(this.mZombiesWon, this.mImageBounds.x + this.mImageOffsetX, this.mImageBounds.y + this.mImageOffsetY);
			g.popState();
		}
	}

	public function update() {
		var x = 0;
		this.mApp.widgetManager.updateFrame();
		this.mApp.mCutsceneTime += 10;
		var time:Float = this.mApp.mCutsceneTime;
		if (time == TIME_END) {
			this.mApp.stateManager.changeState(PVZApp.STATE_DIALOG_BOX);
		}
		if (time > TIME_PAN_RIGHT_START && time <= TIME_PAN_RIGHT_END) {
			x = TodCommon.TodAnimateCurve(TIME_PAN_RIGHT_START, TIME_PAN_RIGHT_END, Std.int(time), 0, PVZApp.BOARD_OFFSET, TodCommon.CURVE_EASE_IN_OUT);
			this.mApp.mBoard.move(x, 0);
		}
		if (time == TIME_GRAPHIC_START - 400 || time == TIME_GRAPHIC_START - 900) {
			this.mApp.foleyManager.playFoley(PVZFoleyType.CHOMP);
		}
		if (time > TIME_PAN_RIGHT_START) {
			this.mApp.mBoard.mShowZombieWalking = true;
		}
		if (time == TIME_GRAPHIC_START) {
			this.mApp.foleyManager.playFoley(PVZFoleyType.SCREAM);
		}
		if (time >= TIME_GRAPHIC_START && time < TIME_GRAPHIC_SHAKE) {
			this.mImageScale = (time - TIME_GRAPHIC_START) / (TIME_GRAPHIC_SHAKE - TIME_GRAPHIC_START);
		}
		this.mImageOffsetX = 0;
		this.mImageOffsetY = 0;
		if (time >= TIME_GRAPHIC_SHAKE && time < TIME_GRAPHIC_SHAKE_END) {
			this.mImageOffsetX = Math.random() * 4 - 2;
			this.mImageOffsetY = Math.random() * 4 - 2;
		}
	}

	public function onPush() {}

	public function onExit() {}

	public function onPop() {}
}
