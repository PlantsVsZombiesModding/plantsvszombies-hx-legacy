package com.popcap.flash.games.pvz.states.playing;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.states.IState;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.logic.TodCommon;

class PanLeftState implements IState {
	public static var TimePanLeftStart:Int = 500;

	public static var TimePanLeftEnd:Int = TimePanLeftStart + 1500;

	var app:PVZApp;

	public function new(app:PVZApp) {
		// super();
		this.app = app;
	}

	public function onEnter() {
		this.app.mBoard.mMenuButton.disabled = true;
		this.app.mCutsceneTime = 0;
		if (this.app.mBoard.ChooseSeedsOnCurrentLevel()) {}
	}

	public function draw(g:Graphics2D) {
		this.app.widgetManager.drawScreen(g);
	}

	public function onPush() {}

	public function onExit() {}

	public function update() {
		var posStart = 0;
		var posEnd = 0;
		var x = 0;
		this.app.widgetManager.updateFrame();
		this.app.mCutsceneTime += 10;
		var aTimePanLeftStart = TimePanLeftStart;
		var aTimePanLeftEnd = TimePanLeftEnd;
		if (this.app.mCutsceneTime > aTimePanLeftStart) {
			posStart = Std.int(PVZApp.BACKGROUND_IMAGE_WIDTH - this.app.width - PVZApp.BOARD_OFFSET);
			posEnd = 0;
			x = TodCommon.TodAnimateCurve(aTimePanLeftStart, aTimePanLeftEnd, this.app.mCutsceneTime, posStart, posEnd, TodCommon.CURVE_EASE_IN_OUT);
			this.app.mBoard.move(-x, 0);
		}
		if (this.app.mBoard.x == 0) {
			this.app.stateManager.changeState(PVZApp.STATE_SODROLL);
		}
	}

	public function onPop() {}
}
