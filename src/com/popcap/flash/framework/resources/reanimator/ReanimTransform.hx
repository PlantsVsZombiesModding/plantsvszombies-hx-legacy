package com.popcap.flash.framework.resources.reanimator;

import com.popcap.flash.framework.resources.images.ImageInst;
import openfl.geom.Matrix;

class ReanimTransform {
	public var matrix:Matrix;

	public var sX:Float = Math.NaN;

	public var sY:Float = Math.NaN;

	public var cache:ImageInst;

	public var kX:Float = Math.NaN;

	public var kY:Float = Math.NaN;

	public var image:ImageInst;

	public var alpha:Float = Math.NaN;

	public var tX:Float = Math.NaN;

	public var tY:Float = Math.NaN;

	public var frame:Float = Math.NaN;

	public var imageID:String;

	public function new() {
		// super();
		this.tX = Math.NaN;
		this.tY = Math.NaN;
		this.kX = Math.NaN;
		this.kY = Math.NaN;
		this.sX = Math.NaN;
		this.sY = Math.NaN;
		this.frame = Math.NaN;
		this.alpha = Math.NaN;
		this.image = null;
	}

	public function fillInFrom(param1:ReanimTransform) {
		if (param1 == null) {
			param1 = new ReanimTransform();
			param1.tX = 0;
			param1.tY = 0;
			param1.kX = 0;
			param1.kY = 0;
			param1.sX = 1;
			param1.sY = 1;
			param1.frame = -1;
			param1.alpha = 1;
		}
		if (Math.isNaN(this.tX)) {
			this.tX = param1.tX;
		}
		if (Math.isNaN(this.tY)) {
			this.tY = param1.tY;
		}
		if (Math.isNaN(this.kX)) {
			this.kX = param1.kX;
		}
		if (Math.isNaN(this.kY)) {
			this.kY = param1.kY;
		}
		if (Math.isNaN(this.sX)) {
			this.sX = param1.sX;
		}
		if (Math.isNaN(this.sY)) {
			this.sY = param1.sY;
		}
		if (Math.isNaN(this.frame)) {
			this.frame = param1.frame;
		}
		if (Math.isNaN(this.alpha)) {
			this.alpha = param1.alpha;
		}
		if (this.image == null) {
			this.image = param1.image;
		}
		this.calcMatrix();
	}

	public function calcMatrix() {
		this.matrix = new Matrix(Math.cos(this.kX) * this.sX, -Math.sin(this.kX) * this.sX, Math.sin(this.kY) * this.sY, Math.cos(this.kY) * this.sY, this.tX,
			this.tY);
	}

	public function toString():String {
		return "[" + this.frame + "] x:" + this.tX + " y:" + this.tY + " image:" + this.image;
	}
}
