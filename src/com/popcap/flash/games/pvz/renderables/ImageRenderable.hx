package com.popcap.flash.games.pvz.renderables;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.render.Renderable;
import com.popcap.flash.framework.resources.images.ImageInst;

class ImageRenderable implements Renderable {
	var mImage:ImageInst;

	var mDead:Bool = false;

	var mDepth:Float = Math.NaN;

	public function new(image:ImageInst, depth:Float = 0) {
		// super();
		this.mImage = image;
		this.mDepth = depth;
		this.mDead = false;
	}

	public function getIsDisposable():Bool {
		return this.mDead;
	}

	public function draw(g:Graphics2D) {
		g.blitImage(this.mImage);
	}

	@:flash.property @:isVar public var dead(never, set):Bool;

	public function set_dead(value:Bool):Bool {
		return this.mDead = value;
	}

	public function getDepth():Float {
		return this.mDepth;
	}

	public function update() {}

	public function getIsVisible():Bool {
		return true;
	}

	public function toString():String {
		return "Image@" + this.mDepth;
	}
}
