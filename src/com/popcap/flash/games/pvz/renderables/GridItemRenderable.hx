package com.popcap.flash.games.pvz.renderables;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.render.Renderable;
import com.popcap.flash.games.pvz.logic.GridItem;

class GridItemRenderable implements Renderable {
	var mGridItem:GridItem;

	var mDepth:Float = Math.NaN;

	public function new(gridItem:GridItem, depth:Float = 0) {
		// super();
		this.mGridItem = gridItem;
		this.mDepth = depth;
	}

	public function getIsDisposable():Bool {
		return this.mGridItem.mDead;
	}

	public function draw(g:Graphics2D) {
		this.mGridItem.Draw(g);
	}

	public function getDepth():Float {
		return this.mDepth;
	}

	public function toString():String {
		return "GridItem@" + this.mDepth;
	}

	public function update() {
		this.mGridItem.Update();
	}

	public function getIsVisible():Bool {
		return true;
	}
}
