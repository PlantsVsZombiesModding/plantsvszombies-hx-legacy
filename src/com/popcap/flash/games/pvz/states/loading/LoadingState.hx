package com.popcap.flash.games.pvz.states.loading;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.states.IState;
import com.popcap.flash.games.pvz.PVZApp;

class LoadingState implements IState {
	var app:PVZApp;

	public function new(app:PVZApp) {
		// super();
		this.app = app;
	}

	public function onEnter() {}

	public function draw(g:Graphics2D) {}

	public function onPush() {}

	public function onExit() {}

	public function update() {
		this.app.stateManager.changeState(PVZApp.STATE_TITLE_SCREEN);
	}

	public function onPop() {}
}
