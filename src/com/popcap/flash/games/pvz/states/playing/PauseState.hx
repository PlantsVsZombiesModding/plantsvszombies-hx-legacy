package com.popcap.flash.games.pvz.states.playing;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.states.IState;
import com.popcap.flash.framework.widgets.ui.CButtonWidget;
import com.popcap.flash.games.pvz.PVZApp;

class PauseState implements IState {
	var mApp:PVZApp;

	var mButton:CButtonWidget;

	public function new(app:PVZApp) {
		// super();
		this.mApp = app;
		this.mButton = new CButtonWidget(0, null);
		this.mButton.resize(0, 0, this.mApp.screenWidth, this.mApp.screenHeight);
		this.mButton.setDisabled(true);
	}

	public function draw(g:Graphics2D) {
		g.fillRect(0, 0, 540, 405, 2566914048);
	}

	public function update() {}

	public function onPush() {}

	public function onPop() {}

	public function onEnter() {
		this.mApp.widgetManager.addWidget(this.mButton);
	}

	public function onExit() {
		this.mApp.widgetManager.removeWidget(this.mButton);
	}
}
