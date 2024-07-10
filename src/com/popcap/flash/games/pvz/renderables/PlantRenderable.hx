package com.popcap.flash.games.pvz.renderables;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.render.Renderable;
import com.popcap.flash.games.pvz.logic.plants.CPlant;

class PlantRenderable implements Renderable {
	var mDepth:Float = Math.NaN;

	var mPlant:CPlant;

	public function new(plant:CPlant, depth:Float = 0) {
		// super();
		this.mPlant = plant;
		this.mDepth = depth;
	}

	public function getIsDisposable():Bool {
		return this.mPlant.getDead();
	}

	public function draw(g:Graphics2D) {
		this.mPlant.Draw(g);
	}

	public function update() {
		this.mPlant.Update();
	}

	public function getIsVisible():Bool {
		return true;
	}

	public function getDepth():Float {
		return this.mDepth;
	}

	public function toString():String {
		return "Plant@" + this.mDepth;
	}
}
