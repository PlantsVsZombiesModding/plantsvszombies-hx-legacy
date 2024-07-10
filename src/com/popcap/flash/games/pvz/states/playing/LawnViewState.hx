package com.popcap.flash.games.pvz.states.playing;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.states.IState;
import com.popcap.flash.framework.widgets.ui.CButtonWidget;
import com.popcap.flash.framework.widgets.ui.IButtonListener;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.logic.MessageWidget;
import com.popcap.flash.games.pvz.logic.TodCommon;
import com.popcap.flash.games.pvz.resources.PVZFonts;

class LawnViewState implements IState implements IButtonListener {
	public static inline final PANLEFT = 0;

	public static var TimePanLeftStart:Int = 500;

	public static var TimePanLeftEnd:Int = TimePanLeftStart + 1500;

	public static var TimePanRightStart:Int = 100;

	public static var TimePanRightEnd:Int = TimePanRightStart + 1000;

	public static inline final PANRIGHT = 1;

	var theButton:CButtonWidget;

	var theState:Int = 0;

	var app:PVZApp;

	var drawMessage:Bool = true;

	public function new(app:PVZApp) {
		// super();
		this.app = app;
	}

	public function draw(g:Graphics2D) {
		this.app.widgetManager.drawScreen(g);
	}

	public function buttonMouseEnter(id:Float) {}

	public function onEnter() {
		this.theState = PANLEFT;
		this.drawMessage = true;
		this.app.mBoard.mMenuButton.setVisible(false);
		this.app.mCutsceneTime = 0;
		this.theButton = new CButtonWidget(0, this);
		this.theButton.label = "";
		this.theButton.setColor(Std.int(CButtonWidget.COLOR_LABEL), Color.RGB(1, 1, 1));
		var font = this.app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
		this.theButton.font = font;
		this.theButton.setDisabled(true);
		this.theButton.visible = true;
		this.theButton.resize(0, 0, 540, 405);
		this.app.widgetManager.addWidget(this.theButton);
		this.app.widgetManager.setFocus(this.theButton);
	}

	public function update() {
		var posStart = 0;
		var posEnd = 0;
		var x = 0;
		var aBoardLeftPosition = 0;
		this.app.widgetManager.updateFrame();
		this.app.mCutsceneTime += 10;
		var aTimePanLeftStart = TimePanLeftStart;
		var aTimePanLeftEnd = TimePanLeftEnd;
		var aTimePanRightStart = TimePanRightStart;
		var aTimePanRightEnd = TimePanRightEnd;
		if (this.theState == PANLEFT) {
			if (this.app.mCutsceneTime > aTimePanLeftStart) {
				posStart = Std.int(PVZApp.BACKGROUND_IMAGE_WIDTH - this.app.width - PVZApp.BOARD_OFFSET);
				posEnd = 0;
				x = TodCommon.TodAnimateCurve(aTimePanLeftStart, aTimePanLeftEnd, this.app.mCutsceneTime, posStart, posEnd, TodCommon.CURVE_EASE_IN_OUT);
				this.app.mBoard.move(-x, 0);
			}
			if (this.app.mBoard.x == 0 && this.drawMessage) {
				this.drawMessage = false;
				this.theButton.setDisabled(false);
				this.app.mBoard.DisplayAdvice("[CLICK_TO_CONTINUE]", MessageWidget.MESSAGE_STYLE_HINT_STAY, Board.ADVICE_NONE);
			}
		} else if (this.theState == PANRIGHT) {
			aBoardLeftPosition = 0;
			if (this.app.mCutsceneTime <= aTimePanRightStart) {
				this.app.mBoard.move(aBoardLeftPosition, 0);
			}
			if (this.app.mCutsceneTime > aTimePanRightStart && this.app.mCutsceneTime <= aTimePanRightEnd) {
				posStart = -aBoardLeftPosition;
				posEnd = Std.int(-PVZApp.BOARD_OFFSET + PVZApp.BACKGROUND_IMAGE_WIDTH - this.app.width);
				x = TodCommon.TodAnimateCurve(aTimePanRightStart, aTimePanRightEnd, this.app.mCutsceneTime, posStart, posEnd, TodCommon.CURVE_EASE_IN_OUT);
				this.app.mBoard.move(-x, 0);
			}
			if (this.app.mBoard.x <= -257) {
				this.app.stateManager.changeState(PVZApp.STATE_SEEDCHOOSER);
			}
		}
	}

	public function buttonDownTick(id:Float) {}

	public function onPush() {}

	public function buttonMouseMove(id:Float, x:Float, y:Float) {}

	public function onExit() {
		this.app.widgetManager.removeWidget(this.theButton);
		this.app.widgetManager.setFocus(this.app.mSeedChooserScreen);
		this.app.mBoard.ClearAdvice(Board.ADVICE_NONE);
		this.app.mCutsceneTime = 0;
	}

	public function buttonMouseLeave(id:Float) {}

	public function buttonPress(id:Float) {}

	public function onPop() {}

	public function buttonRelease(id:Float) {
		this.theButton.setDisabled(true);
		this.app.mCutsceneTime = 0;
		this.theState = PANRIGHT;
		this.app.mBoard.ClearAdvice(Board.ADVICE_NONE);
	}
}
