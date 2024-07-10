package com.popcap.flash.games.pvz.renderables;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.render.Renderable;
import com.popcap.flash.games.pvz.logic.LawnMower;

class LawnMowerRenderable implements Renderable {
	var mDepth:Float = Math.NaN;

	var mLawnMower:LawnMower;

	public function new(lawnMower:LawnMower, depth:Float = 0) {
		// super();
		this.mLawnMower = lawnMower;
		this.mDepth = depth;
	}

	public function getIsDisposable():Bool {
		return this.mLawnMower.mDead;
	}

	public function draw(g:Graphics2D) {
		this.mLawnMower.Draw(g);
	}

	public function update() {
		this.mLawnMower.Update();
	}

	public function getIsVisible():Bool {
		return this.mLawnMower.mVisible;
	}

	public function getDepth():Float {
		return this.mDepth;
	}

	public function toString():String {
		return "LawnMower@" + this.mDepth;
	}
}
